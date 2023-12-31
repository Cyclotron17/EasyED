import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sapp/Pages/test2screen.dart';

import 'package:sapp/helper/helper_function.dart';
import 'package:sapp/auth/login_page.dart';
import 'package:sapp/main.dart';

import 'package:sapp/service/auth_service.dart';
import 'package:sapp/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double appbarheight = 45;

    double devicewidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(38, 90, 232, 1)))
            : SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // const Text(
                        //   "MoveEasy",
                        //   style: TextStyle(
                        //       fontSize: 40, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(height: 10),
                        // const Text(
                        //     "Create your account now to chat and explore",
                        //     style: TextStyle(
                        //         fontSize: 15, fontWeight: FontWeight.w400)),
                        // SizedBox(
                        //     height: 400,
                        //     width: 500,
                        //     child: Image.asset(
                        //       "assets/Rectangle 129.png",
                        //       fit: BoxFit.cover,
                        //     )),
                        Container(
                          width: devicewidth,
                          height: deviceheight * 0.23,
                          decoration: ShapeDecoration(
                            color: Color(0xFF265AE8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(42),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  "Welcome Back to\n EasyED",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Sign up to continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            height: 290,
                            child: Image.asset("assets/register.jpg")),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 22.0, right: 22.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF265AE8),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color(0xFF265AE8),
                                      ), //<-- SEE HERE
                                    ),
                                    labelText: "Full Name",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    fullName = val;
                                  });
                                },
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Name cannot be empty";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF265AE8),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color(0xFF265AE8),
                                      ), //<-- SEE HERE
                                    ),
                                    labelText: "Email",
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },

                                // check tha validation
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please enter a valid email";
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF265AE8),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 3,
                                        color: Color(0xFF265AE8),
                                      ), //<-- SEE HERE
                                    ),
                                    labelText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    )),
                                validator: (val) {
                                  if (val!.length < 6) {
                                    return "Password must be at least 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF265AE8),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Login now",
                                style: const TextStyle(
                                    color: Color(0xFF265AE8),
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginPage());
                                  }),
                          ],
                        )),
                      ],
                    )),
              ),
      ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, test2screen());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
