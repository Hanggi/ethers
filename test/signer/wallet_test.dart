// 📦 Package imports:
import 'package:ethers/signers/wallet.dart';
import 'package:ethers/utils/hdnode/hd_node.dart';
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:ethers/ethers.dart';

final provider = ethers.providers.jsonRpcProvider();

void main() async {
  final accounts = await provider.listAccounts();
  const mnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

  group('Wallet', () {
    test('.fromMnemonic()', () async {
      final walletMnemonic = Wallet.fromMnemonic(
          'announce room limb pattern dry unit scale effort smooth jazz weasel alcohol');

      expect(
          walletMnemonic.address, '0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1');
      expect(walletMnemonic.privateKey,
          '0x1da6847600b0ee25e9ad9a52abbd786dd2502fa4005dd5af9310b7cc7a3b25db');
      expect(walletMnemonic.publicKey,
          '0x04b9e72dfd423bcf95b3801ac93f4392be5ff22143f9980eb78b3a860c4843bfd04829ae61cdba4b3b1978ac5fc64f5cc2f4350e35a108a9c9a92a81200a60cd64');

      expect(walletMnemonic.mnemonic!.phrase,
          'announce room limb pattern dry unit scale effort smooth jazz weasel alcohol');
      expect(walletMnemonic.mnemonic!.path, defaultPath);
    });

    test('.fromPrivateKey()', () async {
      final walletMnemonic = Wallet.fromMnemonic(mnemonic);

      final walletPrivateKey =
          Wallet.fromPrivateKey(walletMnemonic.privateKey!);

      expect(walletMnemonic.privateKey,
          '0x1ab42cc412b618bdea3a599e3c9bae199ebf030895b039e9db1e30dafb12b727');
      expect(walletMnemonic.privateKey, walletPrivateKey.walletPrivateKey);
      expect(
          walletMnemonic.address, '0x9858EfFD232B4033E47d90003D41EC34EcaEda94');

      // signingKey
      expect(walletMnemonic.signingKey!.privateKey,
          '0x1ab42cc412b618bdea3a599e3c9bae199ebf030895b039e9db1e30dafb12b727');
      expect(walletMnemonic.signingKey!.publicKey,
          '0x0437b0bb7a8288d38ed49a524b5dc98cff3eb5ca824c9f9dc0dfdb3d9cd600f299a6179912b7451c09896c4098eca7ce6b2e58330672795e847c4d6af44e024230');
      expect(walletMnemonic.signingKey!.compressedPublicKey,
          '0x0237b0bb7a8288d38ed49a524b5dc98cff3eb5ca824c9f9dc0dfdb3d9cd600f299');

      expect(walletMnemonic.privateKey, walletPrivateKey.privateKey);
      expect(walletMnemonic.address, walletPrivateKey.address);
      expect(walletMnemonic.signingKey!.privateKey,
          walletPrivateKey.signingKey!.privateKey);
      expect(walletMnemonic.signingKey!.publicKey,
          walletPrivateKey.signingKey!.publicKey);
      expect(
        walletMnemonic.signingKey!.compressedPublicKey,
        walletPrivateKey.signingKey!.compressedPublicKey,
        reason: 'compressedPublicKey not equal',
      );
    });
  });
}
