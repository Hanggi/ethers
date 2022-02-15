// 🎯 Dart imports:
import 'dart:typed_data';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';
import 'package:ethers/params/block_tag.dart';

class TransactionRequest {
  final String to;
  final String? from;
  final BigInt? nonce;

  final BigInt gasLimit;
  final BigInt gasPrice;

  final Uint8List? data;
  final BigInt value;
  final int chainId;

  final num? type;
  // final ?? accessList;

  final BigInt? maxPriorityFeePerGas;
  final BigInt? maxFeePerGas;

  TransactionRequest({
    required this.to,
    required this.from,
    this.nonce,
    required this.gasLimit,
    required this.gasPrice,
    required this.value,
    required this.chainId,
    this.data,
    this.type,
    this.maxPriorityFeePerGas,
    this.maxFeePerGas,
  });

  Map<String, dynamic> toJSON() {
    return {
      'to': to,
      'from': from,
      'gas': '0x${gasLimit.toRadixString(16)}',
      'gasPrice': '0x${gasPrice.toRadixString(16)}', // TODO: it's gwei?
      'value': '0x${value.toRadixString(16)}', // TODO: it's gwei?
      if (data != null) 'data': bytesToHex(data!, include0x: true),
    };
  }
}

class TransactionResponse {
  final String hash;

  final int? blockNumber;
  final String? blockHash;
  final int? timestamp;

  final int confirmations;

  final String from;

  final String? raw;

  TransactionResponse({
    required this.hash,
    this.blockNumber,
    this.blockHash,
    this.timestamp,
    required this.confirmations,
    required this.from,
    this.raw,
  });

  wait() {
    // TODO:
  }
}

class TransactionReceipt {
  final String to;
  final String from;
  final String contractAddress;
  final int transactionIndex;
  final String? root;
  final BigInt gasUsed;
  final String logsBloom;
  final String blockHash;
  final String transactionHash;
  final List<Log> logs;
  final int blockNumber; // TODO: use bigint?
  final int confirmations;
  final BigInt cumulativeGasUsed;
  final BigInt effectiveGasPrice;
  final bool byzantium;
  final num type; // TODO: int?
  final num? status; // TODO: int?

  TransactionReceipt({
    required this.to,
    required this.from,
    required this.contractAddress,
    required this.transactionIndex,
    this.root,
    required this.gasUsed,
    required this.logsBloom,
    required this.blockHash,
    required this.transactionHash,
    required this.logs,
    required this.blockNumber,
    required this.confirmations,
    required this.cumulativeGasUsed,
    required this.effectiveGasPrice,
    required this.byzantium,
    required this.type,
    this.status,
  });
}

class Log {
  final num blockNumber;
  final String blockHash;
  final int transactionIndex;
  final bool removed;
  final String address;
  final String data;
  final List<String> topics;
  final String transactionHash;
  final int logIndex;

  Log({
    required this.blockNumber,
    required this.blockHash,
    required this.transactionIndex,
    required this.removed,
    required this.address,
    required this.data,
    required this.topics,
    required this.transactionHash,
    required this.logIndex,
  });
}

class EventFilter {
  final String? address;
  final List<dynamic>? topics;

  EventFilter({this.address, this.topics});
}

class Filter extends EventFilter {
  final BlockTag? fromBlock;
  final BlockTag? toBlock;

  Filter({this.fromBlock, this.toBlock});
}
