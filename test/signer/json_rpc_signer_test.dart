// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/ethers.dart';

final provider = ethers.providers.jsonRpcProvider();

void main() async {
  final accounts = await provider.listAccounts();

  group('JsonRpcSigner', () {
    test('.getBalance()', () async {
      final balance = await provider.getBalance(accounts[0]);
      expect(balance, isNot(BigInt.zero));
    });

    test('.getGasPrice()', () async {
      final gasPrice = await provider.getGasPrice();
      expect(gasPrice, isNot(BigInt.zero));
    });
  });
}
