import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/pets.dart';
import 'package:pet_user_app/screens/2editProfile.dart';
import 'package:pet_user_app/screens/2settingProfile.dart';
import 'package:pet_user_app/screens/ReminderScreen.dart';
import 'package:pet_user_app/screens/myWalletScreen.dart';
import 'package:pet_user_app/screens/notificationScreen.dart';
import 'package:pet_user_app/screens/petProfileScreen.dart';
import 'package:pet_user_app/screens/settingScreen.dart';
import 'package:pet_user_app/screens/userAccountScreen.dart';
import 'package:pet_user_app/screens/wishListScreen.dart';
import 'package:pet_user_app/screens/addPetScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var fullname;
var imagePro;
String imagePath;
var loc;
var workerId;

class ProfileScreen2 extends BaseRoute {
  // ProfileScreen() : super();
  ProfileScreen2({a, o}) : super(a: a, o: o, r: 'ProfileScreen');
  @override
  _ProfileScreenState2 createState() => new _ProfileScreenState2();
}

class _ProfileScreenState2 extends BaseRouteState {
  _ProfileScreenState2() : super();

  @override
  void initState() {
    super.initState();
    getData();
  }

  // void getworkerId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   workerId = prefs.getInt('workerId');
  //   print(workerId);
  // }

  bool loading = true, error = false;

  getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        error = false;
        loading = true;
        fullname = prefs.getString("name");
        imagePro = prefs.getString("image");
        loc = prefs.getString('loc');
        imagePath = imagePro == "undefind"
            ? imagePro
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1DeyZNqRdLF9WiyJOo7YQW5HxbSp3F6tNQQ';
        workerId = prefs.getInt('workerId');
      });
    } catch (e) {
      setState(() {
        error = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.add,
            size: 0,
          ),
          title: Text(
            'Profile',
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt("workerId", workerId);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingScreen2(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: SizedBox(
            child: loading
                ? Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          // color: Colors.red,
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(imagePath),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      fullname.toString(),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 10),
                                      child: Text(
                                        loc ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => EditProfile(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        width: 85,
                                        height: 30,
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),

                          // padding: const EdgeInsets.
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RemindeScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                          child: Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(bottom: 10, top: 35),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: Icon(
                                          FontAwesomeIcons.clock,
                                          color: Theme.of(context).primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          'Reminder',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(),
                                    child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 18,
                                        color: Color(0xFF8F8F8F)),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(),
                                        child: Icon(
                                          Icons.notifications_none_outlined,
                                          size: 18,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          'Notifications',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(),
                                    child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 18,
                                        color: Color(0xFF8F8F8F)),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyWalletScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          'My Wallet',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(),
                                    child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 18,
                                        color: Color(0xFF8F8F8F)),
                                  )
                                ],
                              )),
                        ),
                      ],
                    )))
                : Center(child: CircularProgressIndicator())));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
