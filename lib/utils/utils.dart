// 🎯 Dart imports:
import 'dart:typed_data';

// 📦 Package imports:
import 'package:bip39/bip39.dart' as bip39;
import 'package:decimal/decimal.dart';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart' as fmt;

enum EtherUnit {
  /// Wei, the smallest and atomic amount of Ether
  wei,

  /// kwei, 1000 wei
  kwei,

  /// Mwei, one million wei
  mwei,

  /// Gwei, one billion wei. Typically a reasonable unit to measure gas prices.
  gwei,

  /// szabo, 10^12 wei or 1 μEther
  szabo,

  /// finney, 10^15 wei or 1 mEther
  finney,

  ether
}

class Utils {
  String defaultPath = "m/44'/60'/0'/0/0";

  static final Map<EtherUnit, BigInt> _factors = {
    EtherUnit.wei: BigInt.one,
    EtherUnit.kwei: BigInt.from(10).pow(3),
    EtherUnit.mwei: BigInt.from(10).pow(6),
    EtherUnit.gwei: BigInt.from(10).pow(9),
    EtherUnit.szabo: BigInt.from(10).pow(12),
    EtherUnit.finney: BigInt.from(10).pow(15),
    EtherUnit.ether: BigInt.from(10).pow(18)
  };

  static final Map<EtherUnit, int> _pows = {
    EtherUnit.wei: 1,
    EtherUnit.kwei: 3,
    EtherUnit.mwei: 6,
    EtherUnit.gwei: 9,
    EtherUnit.szabo: 12,
    EtherUnit.finney: 15,
    EtherUnit.ether: 18
  };

  Uint8List mnemonicToSeed(String mnemonic) {
    return fmt.mnemonicToSeed(mnemonic);
  }

  String mnemonicToEntropy(String mnemonic) {
    return bip39.mnemonicToEntropy(mnemonic);
  }

  bool isValidMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  /// ==========================================================================
  /// Conversion
  /// ==========================================================================

  formatUnitsByInt(
    BigInt value, {
    int unit = 18,
  }) {
    if (unit == 0) {
      return value;
    }

    return Decimal.parse((value / BigInt.from(10).pow(unit)).toString())
        .toString();
  }

  formatUnitsByEtherUnit(
    BigInt value, {
    EtherUnit unit = EtherUnit.ether,
  }) {
    return Decimal.parse((value / _factors[unit]!).toString()).toString();
  }

  formatEther(BigInt value) {
    return formatUnitsByInt(value);
  }

  parseUnitsByInt(
    String value, {
    int unit = 18,
  }) {
    return (Decimal.parse(value) * Decimal.ten.pow(unit).toDecimal())
        .toBigInt();
  }

  parseUnitsByEtherUnit(
    String value, {
    EtherUnit unit = EtherUnit.ether,
  }) {
    return (Decimal.parse(value) * Decimal.ten.pow(_pows[unit]!).toDecimal())
        .toBigInt();
  }

  BigInt parseEther(String value) {
    return (Decimal.parse(value) * Decimal.ten.pow(18).toDecimal()).toBigInt();
  }
}
