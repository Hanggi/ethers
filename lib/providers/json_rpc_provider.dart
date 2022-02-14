// 📦 Package imports:
import 'package:ethers/providers/types/transaction_types.dart';
import 'package:http/http.dart';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';
import 'package:ethers/json_rpc.dart';
import 'package:ethers/params/block_tag.dart';
import 'package:ethers/providers/provider.dart';
import 'package:ethers/signers/json_rpc_signer.dart';

const defaultURL = 'http://localhost:8545';

class JsonRpcProvider extends Provider {
  late final JsonRPC _jsonRPC;

  JsonRpcProvider(String? _url) {
    late final String url;
    if (_url == null) {
      url = defaultURL;
    } else {
      url = _url;
    }
    _jsonRPC = JsonRPC(url, Client());
  }

  String defaultUrl() {
    return defaultURL;
  }

  detectNetwork() {
    // TODO:
  }

  JsonRpcSigner getSigner() {
    // TODO:
    return JsonRpcSigner(
      provider: this,
    );
  }

  JsonRpcSigner getUncheckedSigner() {
    // TODO:
    return JsonRpcSigner(
      provider: this,
    );
  }

  Future<List<String>> listAccounts() async {
    final accounts = await send<List<dynamic>>('eth_accounts', params: []);
    return accounts.cast<String>();
  }

  prepareRequest() {
    // TODO:
  }

  perform() {
    // TODO:
  }

  Future<T> send<T>(String function, {List<dynamic>? params}) {
    return _makeRPCCall<T>(function, params);
  }

  /// ==========================================================================
  /// Querying the Blockchain
  /// ==========================================================================

  ///Whether errors, handled or not, should be printed to the console.
  bool printErrors = false;

  Future<T> _makeRPCCall<T>(String function, [List<dynamic>? params]) async {
    try {
      final data = await _jsonRPC.call(function, params);
      // ignore: only_throw_errors
      if (data is Error || data is Exception) throw data;

      return data.result as T;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      if (printErrors) print(e);

      rethrow;
    }
  }

  /// Returns the number of the most recent block on the chain.
  Future<int> getBlockNumber() {
    return _makeRPCCall<String>('eth_blockNumber')
        .then((s) => hexToInt(s).toInt());
  }

  /// Returns the amount of Ether typically needed to pay for one unit of gas.
  ///
  /// Although not strictly defined, this value will typically be a sensible
  /// amount to use.
  Future<BigInt> getGasPrice() async {
    final data = await _makeRPCCall<String>('eth_gasPrice');
    return hexToInt(data);
  }

  /// Gets the balance of the account with the specified address.
  ///
  /// This function allows specifying a custom block mined in the past to get
  /// historical data. By default, [BlockTag.latest] will be used.
  @override
  Future<BigInt> getBalance(
    String address, {
    BlockTag? blockTag,
  }) {
    final bt = blockTag?.toParam() ?? const BlockTag.latest().toParam();

    return _makeRPCCall<String>('eth_getBalance', [address.toLowerCase(), bt])
        .then((data) {
      return hexToInt(data);
    });
  }

  @override
  Future<int> getTransactionCount(
    String address, {
    BlockTag? blockTag,
  }) {
    final bt = blockTag?.toParam() ?? const BlockTag.latest().toParam();

    return _makeRPCCall<String>(
      'eth_getTransactionCount',
      [address.toLowerCase(), bt],
    ).then((data) {
      return hexToInt(data).toInt();
    });
  }

  /// Gets the code of a contract at the specified [address]
  ///
  /// This function allows specifying a custom block mined in the past to get
  /// historical data. By default, [BlockTag.latest] will be used.
  Future<String> getCode(
    String address, {
    BlockTag? blockTag,
  }) {
    final bt = blockTag?.toParam() ?? const BlockTag.latest().toParam();

    return _makeRPCCall<String>('eth_getCode', [address.toLowerCase(), bt]);
  }

  /// Gets an element from the storage of the contract with the specified
  /// [address] at the specified [position].
  /// See https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getstorageat for
  /// more details.
  /// This function allows specifying a custom block mined in the past to get
  /// historical data. By default, [BlockTag.latest] will be used.
  Future<String> getStorageAt(
    String address,
    BigInt position, {
    BlockTag? blockTag,
  }) {
    final bt = blockTag?.toParam() ?? const BlockTag.latest().toParam();

    return _makeRPCCall<String>(
        'eth_getStorageAt', [address, '0x${position.toRadixString(16)}', bt]);
  }

  /// Signs the given transaction using the keys supplied in the [cred]
  /// object to upload it to the client so that it can be executed.
  ///
  /// Returns a hash of the transaction which, after the transaction has been
  /// included in a mined block, can be used to obtain detailed information
  /// about the transaction.
  // Future<String> sendTransaction(Credentials cred, Transaction transaction,
  //     {int? chainId = 1, bool fetchChainIdFromNetworkId = false}) async {
  //   if (cred is CustomTransactionSender) {
  //     return cred.sendTransaction(transaction);
  //   }
  //
  //   var signed = await signTransaction(cred, transaction,
  //       chainId: chainId, fetchChainIdFromNetworkId: fetchChainIdFromNetworkId);
  //
  //   if (transaction.isEIP1559) {
  //     signed = prependTransactionType(0x02, signed);
  //   }
  //
  //   return sendRawTransaction(signed);
  // }

  getBlock({
    BlockTag? blockTag,
    bool? includeTransactions,
  }) async {
    final bt = blockTag?.toParam() ?? const BlockTag.latest().toParam();

    if (blockTag?.intValue != null) {
      return await _makeRPCCall<String>(
        'eth_getBlockByNumber',
        [bt, includeTransactions ?? false],
      );
    }

    // TODO: Verify hash value.
    return await _makeRPCCall<String>(
      'eth_getBlockByHash',
      [bt, includeTransactions ?? false],
    );
  }

  /// Returns the information about a transaction requested by transaction hash
  /// [transactionHash].
  Future<Map<String, dynamic>> getTransaction(String transactionHash) async {
    return await _makeRPCCall<Map<String, dynamic>>(
      'eth_getTransactionByHash',
      [transactionHash],
    );
  }

  /// Returns an receipt of a transaction based on its hash.
  Future<Map<String, dynamic>?> getTransactionReceipt(String hash) async {
    return await _makeRPCCall<Map<String, dynamic>?>(
      'eth_getTransactionReceipt',
      [hash],
    );
  }

  @override
  Future<BigInt> estimateGas(TransactionRequest transaction) async {
    // TODO: check transaction valid.
    final amountHex = await _makeRPCCall<String>('eth_estimateGas', [
      transaction.toJSON(),
    ]);
    return hexToInt(amountHex);
  }

  @override
  Future<String> call(
    TransactionRequest transaction, {
    BlockTag? blockTag,
  }) async {
    // TODO: check transaction valid.
    final bt = blockTag?.toParam() ?? const BlockTag.latest().toParam();
    return await _makeRPCCall<String>('eth_call', [
      {
        'to': transaction.to,
        'data': transaction.data,
        if (transaction.from != null) 'from': transaction.from,
      },
      bt,
    ]);
  }

  @override
  Future<TransactionResponse> sendTransaction(TransactionRequest transaction) {
    // TODO: implement sendTransaction
    throw UnimplementedError();
  }
}
