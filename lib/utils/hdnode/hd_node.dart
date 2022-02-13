import 'dart:typed_data';

import 'package:bip32/bip32.dart' as bip32;
import 'package:convert/convert.dart';
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
  final String? fingerprint;
  final String? parentFingerprint;
  final int index;
  final int depth;

  Mnemonic? mnemonic;

  List<String> getWordList(String mnemonic) {
    return mnemonic.split(' ');
  }

  HDNode({
    required this.privateKey,
    required this.publicKey,
    required this.address,
    required this.chainCode,
    this.fingerprint,
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
    final addressHex = publicKeyToAddress(privateKeyToPublic(privateKeyInt));

    return HDNode(
      privateKey: '0x' + hex.encode(root.privateKey!),
      publicKey: '0x' + hex.encode(root.publicKey),
      address: getChecksumAddress('0x' + hex.encode(addressHex)),
      chainCode: '0x' + hex.encode(root.chainCode),
      index: 0,
      depth: 0,
      parentFingerprint: '0x00000000',
      mnemonic: Mnemonic(_mnemonic),
    );
  }

  factory HDNode.fromMnemonic(String mnemonic) {
    return HDNode._fromSeed(mnemonicToSeed(mnemonic), mnemonic);
  }

  factory HDNode.fromSeed(Uint8List seed) {
    return HDNode._fromSeed(seed, null);
  }
}
