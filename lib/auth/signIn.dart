// import 'package:login_ui/screens/forgotPasswordPage.dart';
// import 'package:login_ui/widgets/buttonWidget.dart';
import 'package:blockchain_flutter/auth/signUp.dart';
import 'package:blockchain_flutter/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../UI.dart';
import '../widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool checkedValue = false;
  bool register = false;
  List textfieldsStrings = [
    "", //firstName
    "", //lastName
    "", //email
    "", //password
    "", //confirmPassword
  ];

  final _firstnamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();

  TextEditingController addressCtlr = TextEditingController();
  TextEditingController keyCtrl = TextEditingController();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
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
                padding: EdgeInsets.only(top: size.height * 0.04),
            child: Align(
              child: Text(
                'Hey there,',
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
              child: register
                  ? Text(
                'Account Login',
                style: GoogleFonts.poppins(
                  color: isDarkMode
                      ? Colors.white
                      : const Color(0xff1D1617),
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : Text(
                'Welcome Back',
                style: GoogleFonts.poppins(
                  color: isDarkMode
                      ? Colors.white
                      : const Color(0xff1D1617),
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.03),
          ),




          Form(
            child: buildTextField(
              "Address",
              Icons.lock,
              false,
              size,
                  (valuemail) {
                if (valuemail.length < 5) {
                  buildSnackError(
                    'Invalid email',
                    context,
                    size,
                  );
                  return '';
                }

                return null;
              },
              _emailKey,
              2,
              isDarkMode,
              true
            ),
          ),
          Form(
            child: buildTextField(
              "Passsword",
              Icons.vpn_key,
              true,
              size,
                  (valuepassword) {
                if (valuepassword.length < 6) {
                  buildSnackError(
                    'Invalid password',
                    context,
                    size,
                  );
                  return '';
                }
                return null;
              },
              _passwordKey,
              3,
              isDarkMode,
              false
            ),
          ),

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
                      "By Lgging in, you agree to our ",
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
                "Forgot your password?",
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
                text: register ? "Register" : "Login",
                backColor: isDarkMode
                ? [
                Colors.black,
                Colors.black,
                ]
                : const [Color(0xff92A3FD), Color(0xff9DCEFF)],
            textColor: const [
              Colors.white,
              Colors.white,
            ],
            onPressed: () async {
              if (register) {
                //validation for register
                if (_firstnamekey.currentState!.validate()) {
                  if (_lastNamekey.currentState!.validate()) {
                    if (_emailKey.currentState!.validate()) {
                      if (_passwordKey.currentState!.validate()) {
                        if (_confirmPasswordKey.currentState!
                            .validate()) {
                          if (checkedValue == false) {
                            buildSnackError(
                                'Accept our Privacy Policy and Term Of Use',
                                context,
                                size);
                          } else {
                            print('register');
                          }
                        }
                      }
                    }
                  }
                }
              } else {
                //validation for login
                if (_emailKey.currentState!.validate()) {
                  if (_passwordKey.currentState!.validate()) {
                    // print('login');
                    // addressCtlr.value.text;
                    // keyCtrl.value.text;
                    // Navigator.pushReplacement<void, void>(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) =>  HelloUI(),
                    //   ),
                    // );

                  }
                }
              }
            },
          ),
        ),
        Container(height: 40,width:40,),

        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text: register
                    ? "Already have an account? "
                    : "Don’t have an account yet? ",
                style: TextStyle(
                  color: isDarkMode
                      ? Colors.white
                      : const Color(0xff1D1617),
                  fontSize: size.height * 0.018,
                ),
              ),
              WidgetSpan(
                child: InkWell(
                  onTap: () => setState(() {
                    if (register) {
                      register = false;
                    } else {
                      register = true;
                    }
                  }),
                  child: register
                      ? GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>  SignUp(),
                        ),
                      );

                    },
                        child: Text(
                    "Login",
                    style: TextStyle(
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Color(0xffEEA4CE),
                              Color(0xffC58BF2),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(
                              0.0,
                              0.0,
                              200.0,
                              70.0,
                            ),
                          ),
                        fontSize: size.height * 0.018,
                    ),
                  ),
                      )
                      : GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>  SignUp(),
                        ),
                      );

                    },
                        child: Text(
                    "Register",
                    style: TextStyle(
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Color(0xffEEA4CE),
                              Color(0xffC58BF2),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(
                                0.0, 0.0, 200.0, 70.0),
                          ),
                        // color: const Color(0xffC58BF2),
                        fontSize: size.height * 0.018,
                    ),
                  ),
                      ),
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
  }

  bool pwVisible = false;
  Widget buildTextField(
      String hintText,
      IconData icon,
      bool password,
      size,
      FormFieldValidator validator,
      Key key,
      int stringToEdit,
      bool isDarkMode,
      bool isaddress
      ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            controller: isaddress?addressCtlr:keyCtrl,
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldsStrings[stringToEdit] = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pwVisible = !pwVisible;
                    });
                  },
                  child: pwVisible
                      ? const Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xff7B6F72),
                  )
                      : const Icon(
                    Icons.visibility_outlined,
                    color: Color(0xff7B6F72),
                  ),
                ),
              )
                  : null,
            ),
          ),
        ),
      ),
    );
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
}