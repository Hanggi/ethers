// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/ethers.dart';

final provider = ethers.providers
    .jsonRpcProvider('https://data-seed-prebsc-1-s1.binance.org:8545');

void main() {
  test('Ethers', () async {
    final blockNumber = await provider.getBlockNumber();
    expect(blockNumber, isNot(0));

    ethers.providers.jsonRpcProvider('http://localhost:7545');
  });

  test('Querying the Blockchain', () async {
    // Look up the current block number
    await provider.getBlockNumber();
    // 14135476

    // // Get the balance of an account (by address or ENS name, if supported by network)
    // final balance = await provider.getBalance("ethers.eth");
    // // { BigNumber: "82826475815887608" }
    //
    // // Often you need to format the output to something more user-friendly,
    // // such as in ether (instead of wei)
    // ethers.utils.formatEther(balance);
    // // '0.082826475815887608'
    //
    // // If a user enters a string in an input field, you may need
    // // to convert it from ether (as a string) to wei (as a BigNumber)
    // ethers.utils.parseEther("1.0");
    // // { BigInt: "1000000000000000000" }
  });
}
