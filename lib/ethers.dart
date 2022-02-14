library ethers;

// 🌎 Project imports:
import 'package:ethers/providers/json_rpc_provider.dart';
import 'package:ethers/utils/utils.dart';

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
  JsonRpcProvider jsonRpcProvider({String? url}) {
    return JsonRpcProvider(url);
  }
}
