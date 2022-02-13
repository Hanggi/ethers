import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:ethers/crypto/keccak.dart';
// ignore: implementation_imports
import 'package:pointycastle/src/utils.dart' as p_utils;
import 'package:bip39/bip39.dart' as bip39;

/// If present, removes the 0x from the start of a hex-string.
String strip0x(String hex) {
  if (hex.startsWith('0x')) return hex.substring(2);
  return hex;
}

/// Converts the [bytes] given as a list of integers into a hexadecimal
/// representation.
///
/// If any of the bytes is outside of the range [0, 256], the method will throw.
/// The outcome of this function will prefix a 0 if it would otherwise not be
/// of even length. If [include0x] is set, it will prefix "0x" to the hexadecimal
/// representation. If [forcePadLength] is set, the hexadecimal representation
/// will be expanded with zeroes until the desired length is reached. The "0x"
/// prefix does not count for the length.
String bytesToHex(List<int> bytes,
    {bool include0x = false,
    int? forcePadLength,
    bool padToEvenLength = false}) {
  var encoded = hex.encode(bytes);

  if (forcePadLength != null) {
    assert(forcePadLength >= encoded.length);

    final padding = forcePadLength - encoded.length;
    encoded = ('0' * padding) + encoded;
  }

  if (padToEvenLength && encoded.length % 2 != 0) {
    encoded = '0$encoded';
  }

  return (include0x ? '0x' : '') + encoded;
}

/// Converts the hexadecimal string, which can be prefixed with 0x, to a byte
/// sequence.
Uint8List hexToBytes(String hexStr) {
  final bytes = hex.decode(strip0x(hexStr));
  if (bytes is Uint8List) return bytes;

  return Uint8List.fromList(bytes);
}

Uint8List unsignedIntToBytes(BigInt number) {
  assert(!number.isNegative);
  return p_utils.encodeBigIntAsUnsigned(number);
}

BigInt bytesToUnsignedInt(Uint8List bytes) {
  return p_utils.decodeBigIntWithSign(1, bytes);
}

///Converts the bytes from that list (big endian) to a (potentially signed)
/// BigInt.
BigInt bytesToInt(List<int> bytes) => p_utils.decodeBigInt(bytes);

Uint8List intToBytes(BigInt number) => p_utils.encodeBigInt(number);

///Takes the hexadecimal input and creates a [BigInt].
BigInt hexToInt(String hex) {
  return BigInt.parse(strip0x(hex), radix: 16);
}

/// Converts the hexadecimal input and creates an [int].
int hexToDartInt(String hex) {
  return int.parse(strip0x(hex), radix: 16);
}

Uint8List mnemonicToSeed(String mnemonic) {
  /// Normalize the case and spacing in the mnemonic (throws if the mnemonic is invalid)
  final wordsList = mnemonic.split(' ');
  wordsList.removeWhere((word) => word == '');
  mnemonic = wordsList.join(' ');
  if (!bip39.validateMnemonic(mnemonic)) {
    throw 'invalid mnemonic';
  }

  final seed = bip39.mnemonicToSeed(mnemonic);
  return seed;
}

bool isHexString(String value, {int? length}) {
  RegExp regExp = RegExp(
    r"^0x[0-9A-Fa-f]*$",
  );
  if (length != null && value.length != 2 + 2 * length) {
    return false;
  }
  return regExp.hasMatch(value);
}

String getChecksumAddress(String address) {
  if (!isHexString(address, length: 20)) {
    throw 'invalid hex value';
  }
  address = address.toLowerCase();

  final chars = address.substring(2).split("");

  Uint8List expanded = Uint8List(40);
  for (var i = 0; i < 40; i++) {
    expanded[i] = chars[i].codeUnitAt(0);
  }

  final hashed = keccak256(expanded);
  for (var i = 0; i < 40; i += 2) {
    if ((hashed[i >> 1] >> 4) >= 8) {
      chars[i] = chars[i].toUpperCase();
    }
    if ((hashed[i >> 1] & 0x0f) >= 8) {
      chars[i + 1] = chars[i + 1].toUpperCase();
    }
  }

  return '0x' + chars.join('');
}
