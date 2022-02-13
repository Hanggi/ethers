// 🎯 Dart imports:
import 'dart:typed_data';

// 📦 Package imports:
import 'package:bip32/bip32.dart' as bip32;
import 'package:convert/convert.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/digests/sha256.dart';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';
import 'package:ethers/crypto/secp256k1.dart';

const defaultPath = "m/44'/60'/0'/0/0";

class Mnemonic {
  String? phrase;
  String? path = 'm';
  String? locale = 'en';

  Mnemonic(String? phrase);
}

class HDNode {
  final String privateKey;
  final String publicKey;
  final String address;
  final String chainCode;
  final String fingerprint;
  final String parentFingerprint;
  final int index;
  final int depth;

  Mnemonic? mnemonic;
  String path = defaultPath;

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
  });

  factory HDNode._fromSeed(Uint8List seed, String? _mnemonic) {
    if (seed.length < 16 || seed.length > 64) {
      throw 'invalid seed';
    }
    final root = bip32.BIP32.fromSeed(seed);
    final privateKeyInt = bytesToUnsignedInt(root.privateKey!);
    final addressHex = '0x' +
        hex.encode(publicKeyToAddress(privateKeyToPublic(privateKeyInt)));
    final publicKeyHex = '0x' + hex.encode(root.publicKey);

    final sha256 = SHA256Digest();
    final ripemd160 = RIPEMD160Digest();
    final fingerprintHex = '0x' +
        hex
            .encode(ripemd160.process(sha256.process(root.publicKey)))
            .substring(0, 8);

    return HDNode(
      privateKey: '0x' + hex.encode(root.privateKey!),
      publicKey: publicKeyHex,
      address: getChecksumAddress(addressHex),
      chainCode: '0x' + hex.encode(root.chainCode),
      index: 0,
      depth: 0,
      parentFingerprint: '0x00000000',
      fingerprint: fingerprintHex,
      mnemonic: Mnemonic(_mnemonic),
    );
  }

  factory HDNode.fromMnemonic(String mnemonic) {
    return HDNode._fromSeed(mnemonicToSeed(mnemonic), mnemonic);
  }

  factory HDNode.fromSeed(Uint8List seed) {
    return HDNode._fromSeed(seed, null);
  }

  derivePath(String path) {}
}
