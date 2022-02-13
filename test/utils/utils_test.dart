// 📦 Package imports:
import 'package:ethers/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:

void main() {
  group('Conversion', () {
    final utils = Utils();
    final oneGwei = BigInt.from(1000000000);
    final oneEther = BigInt.from(1000000000000000000);

    test('formatUnitsByInt()', () async {
      expect(
        utils.formatUnitsByInt(oneGwei),
        '0.000000001',
        reason: 'should get pointer',
      );
      expect(utils.formatUnitsByInt(oneGwei, unit: 9), '1');
      expect(
        utils.formatUnitsByInt(oneEther),
        '1',
        reason: 'should be 1 Ether',
      );
    });

    test('formatUnitsByInt()', () async {
      expect(
        utils.formatUnitsByEtherUnit(oneGwei),
        '0.000000001',
        reason: 'should get pointer',
      );
      expect(utils.formatUnitsByEtherUnit(oneGwei, unit: EtherUnit.gwei), '1');
      expect(
        utils.formatUnitsByEtherUnit(oneEther),
        '1',
        reason: 'should be 1 Ether',
      );
    });

    test('parseUnitsByInt()', () async {
      expect(
        utils.parseUnitsByInt('0.000000001'),
        BigInt.from(1000000000),
        reason: 'should get BigInt',
      );
      expect(utils.parseUnitsByInt('0.000000001', unit: 9), BigInt.one);
      expect(
        utils.parseUnitsByInt('0.000000000000000001'),
        BigInt.one,
        reason: 'should be 1 BigInt',
      );
    });

    test('parseUnitsByEtherUnit()', () async {
      expect(
        utils.parseUnitsByEtherUnit('0.000000001'),
        BigInt.from(1000000000),
        reason: 'should get BigInt',
      );
      expect(utils.parseUnitsByEtherUnit('0.000000001', unit: EtherUnit.gwei),
          BigInt.one);
      expect(
        utils.parseUnitsByEtherUnit('0.000000000000000001'),
        BigInt.one,
        reason: 'should be 1 BigInt',
      );
    });
  });
}
