import 'package:blockchain_flutter/UI.dart';
import 'package:blockchain_flutter/block_chain.dart';
import 'package:blockchain_flutter/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_block_chain.dart';
import 'chat_screen.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final firstNotifier = Provider.of<ContractLinking>(context, listen:true);
    // final  authNotifier= Provider.of<RegisterContractLinking>(context, listen:true);
    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider<ContractLinking>(
    //         create: (_) => firstNotifier,
    //       ),
    //       ChangeNotifierProvider<RegisterContractLinking >(
    //         create: (_) => authNotifier ,
    //       ),
    //
    //     ],
    //   child: MaterialApp(
    //     title: "Hello World",
    //     theme: ThemeData(
    //         brightness: Brightness.dark,
    //         primaryColor: Colors.cyan[400],
    //         accentColor: Colors.deepOrange[200]),
    //     home: Spash(),
    //   ),
    // );

    // Inserting Provider as a parent of HelloUI()
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: "Hello World",
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200]),
        home: Spash(),
      ),
    );
  }
}