import 'dart:convert';
import 'dart:ffi';

import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/2Bottom_navigation_bar.dart';
import 'package:pet_user_app/screens/logInScreen2.dart';
import 'package:pet_user_app/screens/otpVerificationScreen.dart';
import 'package:pet_user_app/screens/2select-services.dart';
import 'package:pet_user_app/screens/signUpScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Api.dart';
import '../widgets/bottomNavigationBarWidget.dart';

var email, password, response;

class LogInScreen1 extends BaseRoute {
  // LogInScreen1() : super();F
  LogInScreen1({a, o}) : super(a: a, o: o, r: 'LogInScreen1');
  @override
  _LogInScreen1State createState() => new _LogInScreen1State();
}

class _LogInScreen1State extends BaseRouteState {
  _LogInScreen1State() : super();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/signIn.png'),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: TextFormField(
                      controller: emailcontroller,
                      // controller: _cForgotEmail,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        // prefixIcon: Icon(Icons.mail),
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      obscureText: !_showPassword,
                      controller: passwordcontroller,
                      // controller: _cForgotEmail,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility();
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        // prefixIcon: Icon(Icons.mail),
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(top: 20),
                  //     // color: Colors.red,
                  //     height: 45,
                  //     // padding: EdgeInsets.only(left: 20, right: 20),
                  //     width: MediaQuery.of(context).size.width,
                  //     child: TextButton(
                  //         // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  //         onPressed: () {
                  //           print('${MediaQuery.of(context).size.width}');
                  //           // print('Hello');
                  //           Navigator.of(context).push(MaterialPageRoute(
                  //               builder: (context) => LogInScreen2(
                  //                     a: widget.analytics,
                  //                     o: widget.observer,
                  //                   )));
                  //         },
                  //         child: Text(
                  //           "Continue",
                  //         ))),
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 155,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                // color: Colors.red,
                height: 45,
                padding: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () async {
                    if (emailcontroller.text.isEmpty ||
                        passwordcontroller.text.isEmpty) {
                      FancySnackbar.showSnackbar(
                        context,
                        snackBarType: FancySnackBarType.warning,
                        title: "Warning",
                        message: "Please enter email and password",
                        duration: 2,
                        onCloseEvent: () {},
                      );
                      return;
                    }

                    // First, search in the first table
                    response = await http.post(
                      Uri.parse(Api.urlLogin),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: json.encode({
                        "email": emailcontroller.text,
                        "password": passwordcontroller.text
                      }),
                    );

                    print(response.body);

                    if (response.body == "User not found") {
                      response = await http.post(
                        Uri.parse(Api.urlWorkerLogin),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body:
                            json.encode({"email": email, "password": password}),
                      );

                      print(response.body);

                      if (response.body == "worker not found") {
                        FancySnackbar.showSnackbar(
                          context,
                          snackBarType: FancySnackBarType.warning,
                          title: "Warning",
                          message: "User not found or invalid credentials",
                          duration: 2,
                          onCloseEvent: () {},
                        );
                      } else if (response.body == "Invalid password") {
                        FancySnackbar.showSnackbar(
                          context,
                          snackBarType: FancySnackBarType.warning,
                          title: "Warning",
                          message: "Invalid password",
                          duration: 2,
                          onCloseEvent: () {},
                        );
                      } else if (jsonDecode(response.body)["worker"]
                              ["status"] ==
                          "pending") {
                        FancySnackbar.showSnackbar(
                          context,
                          snackBarType: FancySnackBarType.warning,
                          title: "Warning",
                          message: "Please wait to verify",
                          duration: 2,
                          onCloseEvent: () {},
                        );
                        return;
                      } else {
                        // User found in the second table
                        var parse = jsonDecode(response.body);
                        String fullname = parse["worker"]["name"];
                        String imagePro = parse["worker"]["image"];
                        print("hello" + fullname);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("name", fullname);
                        prefs.setString("image", imagePro);

                        prefs.setInt("workerId", parse["worker"]["id"]);

                        // Perform specific actions for the second table's user
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Bottomnavigationbar(
                              a: widget.analytics,
                              o: widget.observer,
                            ),
                          ),
                        );
                      }
                    } else if (response.body == "Invalid password") {
                      FancySnackbar.showSnackbar(
                        context,
                        snackBarType: FancySnackBarType.warning,
                        title: "Warning",
                        message: "Invalid password",
                        duration: 2,
                        onCloseEvent: () {},
                      );
                    } else {
                      // User found in the first table
                      var parse = jsonDecode(response.body);
                      String fullname = parse["user"]["name"];
                      String imagePro = parse['user']["image"];
                      String phone = parse["user"]["phone"];
                      String email = parse["user"]["email"];

                      print("hello" + fullname + "image" + imagePro);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("name", fullname);
                      prefs.setString("phone", phone);
                      prefs.setString("image", imagePro);
                      prefs.setString("email", parse["user"]["email"]);

                      prefs.setInt("connId", parse["user"]["id"]);

                      // Perform specific actions for the first table's user
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BottomNavigationWidget(
                            a: widget.analytics,
                            o: widget.observer,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Login"),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text('New here?',
                            style:
                                Theme.of(context).primaryTextTheme.headline4),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ServiceSelectionScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Color(0xFFF0900C),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
  }
}
