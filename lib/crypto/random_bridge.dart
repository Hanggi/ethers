// 🎯 Dart imports:
import 'dart:math';
import 'dart:typed_data';

// 📦 Package imports:
import 'package:pointycastle/api.dart';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';

/// Utility to use dart:math's Random class to generate numbers used by
/// pointycastle.
class RandomBridge implements SecureRandom {
  Random dartRandom;

  RandomBridge(this.dartRandom);

  @override
  String get algorithmName => 'DartRandom';

  @override
  BigInt nextBigInteger(int bitLength) {
    final fullBytes = bitLength ~/ 8;
    final remainingBits = bitLength % 8;

    // Generate a number from the full bytes. Then, prepend a smaller number
    // covering the remaining bits.
    final main = bytesToUnsignedInt(nextBytes(fullBytes));
    final additional = dartRandom.nextInt(1 << remainingBits);
    return main + (BigInt.from(additional) << (fullBytes * 8));
  }

  @override
  Uint8List nextBytes(int count) {
    final list = Uint8List(count);

    for (var i = 0; i < list.length; i++) {
      list[i] = nextUint8();
    }

    return list;
  }

  @override
  int nextUint16() => dartRandom.nextInt(1 << 16);

  @override
  int nextUint32() {
    // this is 2^32. We can't write 1 << 32 because that evaluates to 0 on js
    return dartRandom.nextInt(4294967296);
  }

  @override
  int nextUint8() => dartRandom.nextInt(1 << 8);

  @override
  void seed(CipherParameters params) {
    // ignore, dartRandom will already be seeded if wanted
  }
}
