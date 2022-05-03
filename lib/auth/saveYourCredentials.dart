import 'package:blockchain_flutter/chat/allChats.dart';
import 'package:flutter/services.dart';

// ignore_for_file: file_names


import 'package:blockchain_flutter/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../chat_screen.dart';
import '../widgets.dart';
import 'auth_block_chain.dart';

String userID="";

class CopyTOClickBoard extends StatefulWidget {
  var address;
  var keyStr ;
   CopyTOClickBoard(this.address,this.keyStr,) ;

  @override
  _CopyTOClickBoardState createState() => _CopyTOClickBoardState();
}

class _CopyTOClickBoardState extends State<CopyTOClickBoard> {


  bool checkedValue = false;
  bool register = true;
  List textfieldsStrings = [
    "", //firstName
    "", //lastName
    "", //email
    "", //password
    "", //confirmPassword
  ];



  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery
        .of(context)
        .size;
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    bool isDarkMode = true;
    return Scaffold(
        body: Center(
            child: Container(
                height: size.height,
                width: size.height,
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xff151f2c) : Colors.white,
                ),
                child: SafeArea(
                  child: Stack(
                      children: [
                  SingleChildScrollView(
                  child: Column(
                  children: [
                      Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                  child: Align(
                    child: Text(
                      'Welcome ,',
                      style: GoogleFonts.poppins(
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xff1D1617),
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.015),
                  child: Align(
                      child: Text(
                        'Save the Keys',
                        style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xff1D1617),
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      )

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                ),


              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                     widget.address,
                      style: GoogleFonts.poppins(
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xff1D1617),
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Clipboard.setData(new ClipboardData(text:   widget.address)).then((_){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("address copied to clipboard")));
                        });
                      },
                      child: Container(
                          color: Colors.deepOrange,
                          child: Text("Copy",style: TextStyle(fontSize: 20),)))
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        widget.keyStr,
                    style: GoogleFonts.poppins(
                      color: isDarkMode
                          ? Colors.white
                          : const Color(0xff1D1617),
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
            ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Clipboard.setData(new ClipboardData(text:  widget.keyStr)).then((_){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Key copied to clipboard")));
                        });
                      },
                      child: Container(
                          color: Colors.deepOrange,
                          child: Text("Copy",style: TextStyle(fontSize: 20),)))
                ],
              ),


                // Form(
                //   child: buildTextField(
                //     "Address",
                //     Icons.lock_outline,
                //     false,
                //     size,
                //         (valuemail) {
                //       if (valuemail.length < 5) {
                //         buildSnackError(
                //           'Invalid email',
                //           context,
                //           size,
                //         );
                //         return '';
                //       }
                //       if (!RegExp(
                //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                //           .hasMatch(valuemail)) {
                //         buildSnackError(
                //           'Invalid email',
                //           context,
                //           size,
                //         );
                //         return '';
                //       }
                //       return null;
                //     },
                //     _emailKey,
                //     2,
                //     isDarkMode,
                //   ),
                // ),
                // Form(
                //   child: buildTextField(
                //     "Passsword Key",
                //     Icons.vpn_key_outlined,
                //     true,
                //     size,
                //         (valuepassword) {
                //       if (valuepassword.length < 6) {
                //         buildSnackError(
                //           'Invalid password',
                //           context,
                //           size,
                //         );
                //         return '';
                //       }
                //       return null;
                //     },
                //     _passwordKey,
                //     3,
                //     isDarkMode,
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.015,
                    vertical: size.height * 0.025,
                  ),
                  child: register
                      ? CheckboxListTile(
                    title: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "By creating an account, you agree to our ",
                            style: TextStyle(
                              color: const Color(0xffADA4A5),
                              fontSize: size.height * 0.015,
                            ),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                // ignore: avoid_print
                                print('Conditions of Use');
                              },
                              child: Text(
                                "Conditions of Use",
                                style: TextStyle(
                                  color: const Color(0xffADA4A5),
                                  decoration:
                                  TextDecoration.underline,
                                  fontSize: size.height * 0.015,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: const Color(0xffADA4A5),
                              fontSize: size.height * 0.015,
                            ),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                // ignore: avoid_print
                                print('Privacy Notice');
                              },
                              child: Text(
                                "Privacy Notice",
                                style: TextStyle(
                                  color: const Color(0xffADA4A5),
                                  decoration:
                                  TextDecoration.underline,
                                  fontSize: size.height * 0.015,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    activeColor: const Color(0xff7B6F72),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                    controlAffinity:
                    ListTileControlAffinity.leading,
                  )
                      : InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //       const ForgotPasswordPage()),
                      // );
                    },
                    child: Text(
                      "",
                      style: TextStyle(
                        color: const Color(0xffADA4A5),
                        decoration: TextDecoration.underline,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                ),

                AnimatedPadding(
                    duration: const Duration(milliseconds: 500),
                    padding: register
                        ? EdgeInsets.only(top: size.height * 0.025)
                        : EdgeInsets.only(top: size.height * 0.085),
                    child: ButtonWidget(
                        text: "Done",
                        backColor: isDarkMode
                        ? [
                        Colors.black,
                        Colors.black,
                        ]
                        : const [Color(0xff92A3FD),
                    Color(0xff9DCEFF)],
                    textColor: const [
                      Colors.white,
                      Colors.white,
                    ],
                    onPressed: () async {
                      // await  contractLink.getUsers();

                      userID = widget.address;

                      Navigator.push(context,MaterialPageRoute(
                          builder: (context)=> AllChat()
                      ));

                    }))]))])
    )
    )
    )
    );
  }
  }



  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
