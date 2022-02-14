import 'dart:typed_data';

import 'package:ethers/crypto/formatting.dart';

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
