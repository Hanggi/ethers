import 'package:ethers/params/block_tag.dart';
import 'package:ethers/providers/types/transaction_types.dart';

abstract class Provider {
  Future getBalance(String address, {BlockTag? blockTag});

  Future<int> getTransactionCount(String address, {BlockTag? blockTag});

  /// Execution
  Future<BigInt> estimateGas(TransactionRequest transaction);
  Future<String> call(TransactionRequest transaction, {BlockTag? blockTag});
  Future<TransactionResponse> sendTransaction(TransactionRequest transaction);
}
