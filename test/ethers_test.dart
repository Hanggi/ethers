import 'package:flutter_test/flutter_test.dart';

import 'package:ethers/ethers.dart';

final provider = ethers.providers
    .jsonRpcProvider('https://data-seed-prebsc-1-s1.binance.org:8545');

void main() {
  test('Ethers', () async {
    final blockNumber = await provider.getBlockNumber();
    expect(blockNumber, isNot(0));
  });
}
