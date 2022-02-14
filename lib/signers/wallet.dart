import 'package:ethers/providers/provider.dart';
import 'package:ethers/signers/signer.dart';

class Wallet extends Signer {
  final String address;
  final Provider provider;

  Wallet({
    required this.address,
    required this.provider,
  });

  @override
  Signer connect(Provider provider) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  getAddress() {
    // TODO: implement getAddress
    throw UnimplementedError();
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
