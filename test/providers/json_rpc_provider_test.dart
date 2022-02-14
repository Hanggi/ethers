// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/ethers.dart';

final provider = ethers.providers.jsonRpcProvider();

void main() {
  var accounts;
  test('listAccounts', () async {
    accounts = await provider.listAccounts();
    expect(accounts.length, isNot(0));
  });

  test('getBlockNumber', () async {
    final blockNumber = await provider.getBlockNumber();
    expect(blockNumber, 0);
  });

  test('getGasPrice', () async {
    final gasPrice = await provider.getGasPrice();
    expect(gasPrice, isNot(0));
  });

  test('getBalance', () async {
    final balance = await provider.getBalance(accounts[0]);
    expect(balance, isNot(0));
  });

  test('getTransactionCount', () async {
    final count =
        await provider.getBalance('0x0000000000000000000000000000000000000000');
    expect(count, isNot(0));
  });

  test('getCode', () async {
    final code =
        await provider.getCode('0x55d398326f99059ff775485246999027b3197955');
    expect(code, isNot(''));

    final zero =
        await provider.getCode('0x0000000000000000000000000000000000000000');
    expect(zero, '0x');
  });

  test('getStorageAt', () async {
    // TODO: Implement test.
  });

  test('getTransaction', () async {
    // TODO: Implement test.
  });

  test('getTransactionReceipt', () async {
    // TODO: Implement test.
  });
}
