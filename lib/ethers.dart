library ethers;

import 'package:ethers/providers/json_rpc_provider.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

final ethers = Ethers();

class Ethers {
  Providers providers = Providers();

  Utils utils = Utils();
}

class Providers {
  jsonRpcProvider(String? url) {
    return JsonRpcProvider(url);
  }
}

class Utils {
  String defaultPath = "m/44'/60'/0'/0/0";
}
