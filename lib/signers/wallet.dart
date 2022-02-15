// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';
import 'package:ethers/crypto/secp256k1.dart';
import 'package:ethers/providers/provider.dart';
import 'package:ethers/signers/signer.dart';
import 'package:ethers/signers/types/wordlist.dart';
import 'package:ethers/utils/hdnode/hd_node.dart';
import 'package:ethers/utils/hdnode/mnemonic.dart';

class ExternallyOwnedAccount {
  String? address;
  String? privateKey;
}

class SigningKey {
  final String curve = "secp256k1";

  final String? privateKey;
  final String? publicKey;
  final String? compressedPublicKey;

  SigningKey({
    this.privateKey,
    this.publicKey,
    this.compressedPublicKey,
  });
}

class Wallet extends Signer implements ExternallyOwnedAccount {
  @override
  String? address;

  @override
  String? privateKey;
  final String walletPrivateKey;
  String? publicKey;

  final Provider? walletProvider;
  HDNode? hdNode;

  Mnemonic? mnemonic;
  SigningKey? signingKey;

  Wallet({
    this.signingKey,
    this.mnemonic,
    this.walletProvider,
    this.address,
    this.privateKey,
    this.publicKey,
  })  : assert(privateKey != null),
        walletPrivateKey = privateKey!;

  factory Wallet.fromPrivateKey(String privateKey) {
    final privateKeyInt = hexToInt(privateKey);
    final publicKeyUint8List = privateKeyToPublic(privateKeyInt);
    final publicKeyHex = bytesToHex(publicKeyUint8List);
    final compressedPublicKey = privateKeyToCompressedPublic(privateKeyInt);
    final publicKey = '0x04' + publicKeyHex;

    return Wallet(
      signingKey: SigningKey(
        privateKey: privateKey,
        compressedPublicKey: '0x02' + bytesToHex(compressedPublicKey),
        publicKey: publicKey,
      ),
      address: getChecksumAddress(
          bytesToHex(publicKeyToAddress(publicKeyUint8List), include0x: true)),
      privateKey: privateKey,
    );
  }

  factory Wallet.fromHDNode(HDNode hdNode) {
    final publicKey =
        '0x04' + bytesToHex(privateKeyToPublic(hexToInt(hdNode.privateKey!)));
    return Wallet(
      signingKey: SigningKey(
        privateKey: hdNode.privateKey,
        compressedPublicKey: hdNode.publicKey,
        publicKey: publicKey,
      ),
      mnemonic: hdNode.mnemonic,
      address: hdNode.address,
      privateKey: hdNode.privateKey,
      publicKey: publicKey,
    );
  }

  factory Wallet.fromMnemonic(
    String mnemonic, {
    String? path,
    Wordlist? wordlist,
  }) {
    path ??= defaultPath;
    return Wallet.fromHDNode(HDNode.fromMnemonic(mnemonic).derivePath(path));
  }

  @override
  Signer connect(Provider provider) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<String> getAddress() async {
    if (address == null) {
      throw 'no address';
    }
    return address!;
  }

  @override
  signMessage() {
    // TODO: implement signMessage
    throw UnimplementedError();
  }

  @override
  signTransaction() {
    // TODO: implement signTransaction
    throw UnimplementedError();
  }
}
