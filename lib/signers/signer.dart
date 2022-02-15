// 🌎 Project imports:
import 'package:ethers/params/block_tag.dart';
import 'package:ethers/providers/provider.dart';
import 'package:ethers/providers/types/transaction_types.dart';

abstract class Signer {
  Provider? provider;

  /// ==========================================================================
  /// Sub-classes MUST implement these
  /// ==========================================================================

  Future<String> getAddress();

  signMessage();

  signTransaction();

  Signer connect(Provider provider);

  /// ==========================================================================
  /// Sub-classes MAY override these
  /// ==========================================================================

  Future<BigInt> getBalance({
    BlockTag? blockTag,
  }) async {
    if (provider == null) {
      throw 'missing provider';
    }
    final address = await getAddress();
    return await provider!.getBalance(
      address,
      blockTag: blockTag,
    );
  }

  Future<int> getTransactionCount({
    BlockTag? blockTag,
  }) async {
    if (provider == null) {
      throw 'missing provider';
    }
    final address = await getAddress();
    return await provider!.getTransactionCount(
      address,
      blockTag: blockTag,
    );
  }

  Future<BigInt> estimateGas(TransactionRequest transaction) async {
    if (provider == null) {
      throw 'missing provider';
    }
    return await provider!.estimateGas(transaction);
  }

  Future<String> call(
    TransactionRequest transaction, {
    BlockTag? blockTag,
  }) async {
    if (provider == null) {
      throw 'missing provider';
    }
    // TODO: check transaction valid.
    return await provider!.call(transaction, blockTag: blockTag);
  }

  // Future<Uint8List> signTransaction() async {}

}
