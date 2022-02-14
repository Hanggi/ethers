// 🌎 Project imports:
import 'package:ethers/providers/json_rpc_provider.dart';
import 'package:ethers/providers/provider.dart';
import 'package:ethers/signers/signer.dart';

class JsonRpcSigner extends Signer {
  final JsonRpcProvider provider;
  final String? address;

  JsonRpcSigner({
    required this.provider,
    this.address,
  });

  connect(Provider provider) {
    // TODO:
  }

  connectUnchecked(Provider provider) {
    // TODO:
  }

  @override
  getAddress() {}
}
