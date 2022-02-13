import 'package:ethers/utils/hdnode/hd_node.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ethers/ethers.dart';

final provider = ethers.providers
    .jsonRpcProvider('https://data-seed-prebsc-1-s1.binance.org:8545');
// Testnet: https://data-seed-prebsc-1-s1.binance.org:8545

void main() {
  group('Mnemonic', () {
    test('.fromMnemonic() invalid', () async {
      try {
        HDNode.fromMnemonic('invalid mnemonic invalid');
      } catch (err) {
        expect(err, 'invalid mnemonic');
      }
    });

    test('.fromMnemonic() valid with multiple spaces', () async {
      HDNode.fromMnemonic(
          '   abandon    abandon  abandon abandon abandon abandon abandon abandon abandon abandon abandon about    ');
    });

    test('.fromMnemonic() returns expected HDNode', () async {
      final hdNode = HDNode.fromMnemonic(
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about');

      expect(
        hdNode.privateKey,
        '0x1837c1be8e2995ec11cda2b066151be2cfb48adf9e47b151d46adab3a21cdf67',
        reason: 'privateKey not expected',
      );
      expect(
        hdNode.publicKey,
        '0x03d902f35f560e0470c63313c7369168d9d7df2d49bf295fd9fb7cb109ccee0494',
        reason: 'publicKey not expected',
      );
      expect(
        hdNode.address,
        '0xa8E070649A1D98651D281FdD428BD3EeC0d279e0',
        reason: 'address not expected',
      );

      expect(
        hdNode.chainCode,
        '0x7923408dadd3c7b56eed15567707ae5e5dca089de972e07f3b860450e2a3b70e',
        reason: 'chainCode not expected',
      );
    });
  });
}
