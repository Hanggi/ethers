// 🌎 Project imports:
import 'package:ethers/providers/json_rpc_provider.dart';
import 'package:ethers/providers/provider.dart';
import 'package:ethers/signers/signer.dart';

class JsonRpcSigner extends Signer {
  final JsonRpcProvider provider;
  final int? index;
  final String? address;

  JsonRpcSigner({
    required this.provider,
    this.address,
    this.index = 0,
  });

  @override
  JsonRpcSigner connect(Provider provider) {
    throw 'cannot alter JSON-RPC Signer connection';
  }

  @override
  Future<String> getAddress() async {
    // TODO:
    return '';
  }

  @override
  signMessage() {}

  @override
  signTransaction() {}

  connectUnchecked(Provider provider) {
    // TODO:
  }

  // @override
  // Future<BigInt> getBalance({
  //   BlockTag? blockTag,
  // }) async {
  //   return await provider.getBalance();
  // }
}
