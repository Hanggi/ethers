// 🎯 Dart imports:
import 'dart:typed_data';

// 📦 Package imports:
import 'package:bip32/bip32.dart' as bip32;
import 'package:convert/convert.dart';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';
import 'package:ethers/crypto/secp256k1.dart';
import 'package:ethers/signers/types/wordlist.dart';
import 'package:ethers/signers/wallet.dart';
import 'package:ethers/utils/hdnode/mnemonic.dart';

const defaultPath = "m/44'/60'/0'/0/0";

class HDNode implements ExternallyOwnedAccount {
  /// The private key for this HDNode.
  @override
  String? privateKey;

  /// The (compresses) public key for this HDNode.
  final String publicKey;

  /// The address of this HDNode.
  @override
  String? address;

  /// The chain code is used as a non-secret private key which is then used with EC-multiply to provide the ability to derive addresses without the private key of child non-hardened nodes.
  ///
  /// Most developers will not need to use this.
  final String chainCode;

  /// The fingerprint is meant as an index to quickly match parent and children nodes together, however collisions may occur and software should verify matching nodes.
  ///
  /// Most developers will not need to use this.
  final String fingerprint;

  /// The fingerprint of the parent node. See fingerprint for more details.
  ///
  /// Most developers will not need to use this.
  final String parentFingerprint;

  /// The index of this HDNode. This will match the last component of the path.
  ///
  /// Most developers will not need to use this.
  final int index;

  /// The depth of this HDNode. This will match the number of components (less one, the m/) of the path.
  ///
  /// Most developers will not need to use this.
  final int depth;

  /// A serialized string representation of this HDNode. Not all properties are included in the serialization, such as the mnemonic and path, so serializing and deserializing (using the fromExtendedKey class method) will result in reduced information.
  // TODO: extendedKey

  /// The mnemonic of this HDNode, if known.
  Mnemonic? mnemonic;

  /// The path of this HDNode, if known. If the mnemonic is also known, this will match mnemonic.path.
  String? path = 'm';

  List<String> getWordList(String mnemonic) {
    return mnemonic.split(' ');
  }

  HDNode({
    required this.privateKey,
    required this.publicKey,
    required this.address,
    required this.chainCode,
    required this.fingerprint,
    required this.parentFingerprint,
    required this.index,
    required this.depth,
    required this.mnemonic,
    this.path,
  });

  static HDNode _nodeFromRoot(
    bip32.BIP32 root, {
    String? mnemonic,
    String? path,
  }) {
    final privateKeyInt = bytesToUnsignedInt(root.privateKey!);
    final addressHex = '0x' +
        hex.encode(publicKeyToAddress(privateKeyToPublic(privateKeyInt)));
    final publicKeyHex = '0x' + hex.encode(root.publicKey);

    return HDNode(
      privateKey: '0x' + hex.encode(root.privateKey!),
      publicKey: publicKeyHex,
      address: getChecksumAddress(addressHex),
      chainCode: '0x' + hex.encode(root.chainCode),
      index: root.index,
      depth: root.depth,
      parentFingerprint: root.parentFingerprint != 0
          ? '0x' + root.parentFingerprint.toRadixString(16)
          : '0x00000000',
      fingerprint: '0x' + hex.encode(root.fingerprint),
      mnemonic: Mnemonic(
        phrase: mnemonic,
        path: path,
      ),
      path: path ?? 'm',
    );
  }

  factory HDNode._fromSeed(Uint8List seed, String? _mnemonic) {
    if (seed.length < 16 || seed.length > 64) {
      throw 'invalid seed';
    }
    final root = bip32.BIP32.fromSeed(seed);

    return _nodeFromRoot(root, mnemonic: _mnemonic);
  }

  factory HDNode.fromMnemonic(
    String mnemonic, {
    String? password,
    Wordlist? wordlist,
  }) {
    return HDNode._fromSeed(mnemonicToSeed(mnemonic), mnemonic);
  }

  factory HDNode.fromSeed(Uint8List seed) {
    return HDNode._fromSeed(seed, null);
  }

  // TODO: HDNode.fromExtendedKey

  /// Return a new instance of hdNode with its private key removed but all other properties preserved. This ensures that the key can not leak the private key of itself or any derived children, but may still be used to compute the addresses of itself and any non-hardened children.
  HDNode neuter() {
    var newHDNode = this;
    newHDNode.privateKey = null;
    return newHDNode;
  }

  /// Return a new [HDNode] which is the child of hdNode found by deriving path.
  HDNode derivePath(String path) {
    final root = bip32.BIP32.fromPrivateKey(
      Uint8List.fromList(hex.decode(strip0x(privateKey!))),
      Uint8List.fromList(hex.decode(strip0x(chainCode))),
    );

    final child = root.derivePath(path);
    return _nodeFromRoot(
      child,
      path: path,
    );
  }
}
