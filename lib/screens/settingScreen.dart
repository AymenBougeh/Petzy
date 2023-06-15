import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/aboutUsScreen.dart';
import 'package:pet_user_app/screens/addRatingScreen.dart';
import 'package:pet_user_app/screens/languageSelectionScreen.dart';

import 'package:pet_user_app/screens/logInScreen1.dart';
import 'package:pet_user_app/screens/myPostScreen.dart';
import 'package:pet_user_app/screens/profileScreen.dart';
import 'package:pet_user_app/screens/supportsUsScreen.dart';

import 'package:pet_user_app/screens/userAccountScreen.dart';
import 'package:pet_user_app/screens/userReviewScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var connId;

class SettingScreen extends BaseRoute {
  // SettingScreen() : super();
  SettingScreen({a, o}) : super(a: a, o: o, r: 'SettingScreen');
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends BaseRouteState {
  _SettingScreenState() : super();
  @override
  void initState() {
    super.initState();
    getconnId();
  }

  void getconnId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    connId = prefs.getInt('connId');
    print(connId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: Text(
            'Settings',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserReviewScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  Icons.reviews,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'My Reviews',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    // color: Colors.red,
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Icon(
                                FontAwesomeIcons.wallet,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Payment Methods',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(),
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              size: 18, color: Color(0xFF8F8F8F)),
                        )
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LanguageSelectionScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  FontAwesomeIcons.language,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Language Selection',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt("connId", connId);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyPostScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  FontAwesomeIcons.stickyNote,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'My Moments',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AboutUsScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  FontAwesomeIcons.infoCircle,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'About us',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SupportsUsScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  FontAwesomeIcons.handsHelping,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Supports',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddRatingScreen(
                              a: widget.analytics,
                              o: widget.observer,
                            )));
                  },
                  child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  FontAwesomeIcons.thumbsUp,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Love the app? Rate us',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    logOutDialog();
                  },
                  child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 325, bottom: 10),
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  Icons.logout,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Logout',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: Color(0xFF8F8F8F)),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  logOutDialog() async {
    try {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
            child: CupertinoAlertDialog(
              title: Text("Exit"),
              content: Text('Are you sure you want to exit app?'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    // Dismiss the dialog but don't
                    // dismiss the swiped item
                    return Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Logout'),
                  onPressed: () async {
                    // Clear the locally stored JWT token
                    await FlutterSecureStorage().delete(key: 'token');

                    // Navigate to the login screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LogInScreen1(
                          a: widget.analytics,
                          o: widget.observer,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Exception - base.dart - exitAppDialog(): ' + e.toString());
    }
  }
}
