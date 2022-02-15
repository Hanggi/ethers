import 'package:ethers/signers/wallet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethers Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ethers Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mnemonic =
      "announce room limb pattern dry unit scale effort smooth jazz weasel alcohol";
  late Wallet walletMnemonic;

  @override
  void initState() {
    walletMnemonic = Wallet.fromMnemonic(mnemonic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mnemonic:' + mnemonic,
              textAlign: TextAlign.center,
            ),
            Text(
              'PrivateKey: ${walletMnemonic.privateKey}',
              textAlign: TextAlign.center,
            ),
            Text(
              'PublicKey: ${walletMnemonic.publicKey}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
