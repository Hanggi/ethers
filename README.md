# Ethers For Flutter

![test](https://github.com/Hanggi/ethers/actions/workflows/test.yml/badge.svg)

Ethers is a dart library that connects to interact with the Ethereum blockchain and inspired by [ethers.js](https://github.com/ethers-io/ethers.js/).

Thanks to [web3dart](https://github.com/simolus3/web3dart) which is no longer maintained.

## Installing

Add Ethers to your pubspec.yaml file:

```yaml
dependencies:
  ethers:
```

Import Ethers in files that it will be used:

```yaml
import 'package:ethers/ethers.dart';
```

## Usage

```dart
const provider = new ethers.providers.JsonRpcProvider();

// Look up the current block number
await provider.getBlockNumber();
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
```

TODO...
