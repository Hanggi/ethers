// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/ethers.dart';

final provider = ethers.providers.jsonRpcProvider();

void main() {
  test('Ethers', () async {
    // final blockNumber = await provider.getBlockNumber();
    // expect(blockNumber, isNot(0));
  });

  test('Querying the Blockchain', () async {
    // Look up the current block number
    final blockNumber = await provider.getBlockNumber();
    expect(blockNumber, 0);
    // 14135476

    // Get the balance of an account (by address or ENS name, if supported by network)
    final balance =
        await provider.getBalance("0x0000000000000000000000000000000000000000");
    // { BigInt: "10478645750785322678769" }

    // Often you need to format the output to something more user-friendly,
    // such as in ether (instead of wei)
    ethers.utils.formatEther(balance);
    // '10478.645750785321'

    // If a user enters a string in an input field, you may need
    // to convert it from ether (as a string) to wei (as a BigNumber)
    ethers.utils.parseEther("1.0");
    // { BigInt: "1000000000000000000" }
  }, tags: ['runOnNewChain']);
}
