// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/crypto/formatting.dart';

void main() {
  test('isHexString()', () async {
    expect(isHexString('1234'), false, reason: 'missing 0x');
    expect(isHexString('0x1234'), true);
    expect(isHexString('0xxyz'), false, reason: 'xyz is not hex');
    expect(isHexString('0xabcd'), true);
    expect(isHexString('0xff22'), true);

    expect(isHexString('0x1234567890', length: 5), true);
    expect(isHexString('0x1234567890', length: 4), false,
        reason: 'length not match');
  });

  test('getChecksumAddress()', () async {
    expect(
      getChecksumAddress(
          '0xa8E070649A1D98651D281FdD428BD3EeC0d279e0'.toLowerCase()),
      '0xa8E070649A1D98651D281FdD428BD3EeC0d279e0',
    );
  });
}
