// 🌎 Project imports:
import 'package:ethers/params/block_tag.dart';
import 'package:ethers/providers/types/block.dart';
import 'package:ethers/providers/types/transaction_types.dart';

abstract class Provider {
  /// Account
  Future getBalance(String address, {BlockTag? blockTag});
  Future<int> getTransactionCount(String address, {BlockTag? blockTag});
  Future<String> getCode(String address, {BlockTag? blockTag});
  Future<String> getStorageAt(
    String address,
    BigInt position, {
    BlockTag? blockTag,
  });

  /// Execution
  Future<BigInt> estimateGas(TransactionRequest transaction);
  Future<String> call(TransactionRequest transaction, {BlockTag? blockTag});
  Future<TransactionResponse> sendTransaction(TransactionRequest transaction);

  /// Queries
  Future<Block> getBlock(BlockTag blockTag);
  Future<BlockWithTransactions> getBlockWithTransactions(BlockTag blockTag);
  Future<TransactionResponse> getTransaction(String transactionHash);
  Future<TransactionReceipt> getTransactionReceipt(String transactionHash);

  /// Bloom-filter Queries
  Future<List<Log>> getLogs(Filter filter);

  /// ENS
  Future<String?> resolveName(String name);
  Future<String?> lookupAddress(String address);

  /// Event Emitter (ish)
  // Provider on(String eventName, dynamic listener);
  // Provider once(String eventName, dynamic listener);
  // Provider emit(String eventName, dynamic listener);
}
