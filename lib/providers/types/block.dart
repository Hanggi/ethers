// 🌎 Project imports:
import 'package:ethers/providers/types/transaction_types.dart';

class Block {
  final List<String> transactions;

  Block({required this.transactions});
}

class BlockWithTransactions {
  final List<TransactionResponse> transactions;
  BlockWithTransactions({required this.transactions});
}
