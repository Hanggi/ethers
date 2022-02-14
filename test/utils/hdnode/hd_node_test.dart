// 📦 Package imports:
import 'package:ethers/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/ethers.dart';
import 'package:ethers/utils/hdnode/hd_node.dart';

final provider = ethers.providers.jsonRpcProvider();
// Testnet: https://data-seed-prebsc-1-s1.binance.org:8545

void main() {
  group('HDNode', () {
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
      expect(
        hdNode.fingerprint,
        '0x73c5da0a',
        reason: 'fingerprint not expected',
      );
      expect(
        hdNode.parentFingerprint,
        '0x00000000',
        reason: 'parent fingerprint not expected',
      );
      expect(
        hdNode.mnemonic!.phrase,
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about',
        reason: 'mnemonic phrase not expected',
      );
    });

    test('.neuter()', () async {
      final hdNode = HDNode.fromMnemonic(
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about');

      final neutered = hdNode.neuter();
      expect(neutered.privateKey, null);
    });

    test('.derivePath()', () async {
      final hdNode = HDNode.fromMnemonic(
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about');

      final child = hdNode.derivePath(Utils().defaultPath);

      expect(
        child.privateKey,
        '0x1ab42cc412b618bdea3a599e3c9bae199ebf030895b039e9db1e30dafb12b727',
        reason: 'privateKey not expected',
      );
      expect(
        child.publicKey,
        '0x0237b0bb7a8288d38ed49a524b5dc98cff3eb5ca824c9f9dc0dfdb3d9cd600f299',
        reason: 'publicKey not expected',
      );
      expect(
        child.address,
        '0x9858EfFD232B4033E47d90003D41EC34EcaEda94',
        reason: 'address not expected',
      );
      expect(
        child.chainCode,
        '0x736094f4f24b67e838a4b3d23d31d229ca03e00c9bb99ce95da6d86e8b3847b5',
        reason: 'chainCode not expected',
      );
      expect(
        child.path,
        Utils().defaultPath,
        reason: 'path not expected',
      );
      expect(
        child.depth,
        5,
        reason: 'depth not expected',
      );
      expect(
        child.fingerprint,
        '0x4418d0b4',
        reason: 'fingerprint not expected',
      );
      expect(
        child.parentFingerprint,
        '0xe4389614',
        reason: 'parent fingerprint not expected',
      );
    });
  });
}
