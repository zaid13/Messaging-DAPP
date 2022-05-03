

import 'dart:ui';

import 'package:blockchain_flutter/UI.dart';
import 'package:blockchain_flutter/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'auth/signUp.dart';

class Spash extends StatelessWidget {
  const Spash({Key? key}) : super(key: key);



  checkFuture(context)async{

    var t = 4;
    await Future.delayed(Duration(seconds: 4),(){
print("frfrf");
Navigator.pushReplacement<void, void>(
  context,
  MaterialPageRoute<void>(
    builder: (BuildContext context) =>  SignUp(),
  ),
);
    });

    return t;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Align(
        alignment: Alignment.topCenter, // This will horizontally center from the top

        child: Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future:checkFuture(context) ,
            builder:(ctx,snap){
              return Stack(
                children: [

                  Container(


                    child: Image.asset('assets/images/background.jpeg',fit:BoxFit.cover,  height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                    alignment: Alignment.center,
                    child:HeartbeatProgressIndicator(
                      child: BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: new Container(
                            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                            child:  Image.asset('assets/images/decentralized.png',height: 100)
                        ),),
                    ),
                  ),
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}
