import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/logInScreen1.dart';
import 'package:pet_user_app/screens/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceSelectionScreen extends BaseRoute {
  ServiceSelectionScreen({a, o})
      : super(a: a, o: o, r: 'ServiceSelectionScreen');

  @override
  _ServiceSelectionScreenState createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends BaseRouteState {
  List<String> selectedServices = [];

  final List<String> services = [
    'Pet Bording',
    'Dog Walking',
    'Pet Owner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 370,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/reg.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "SELECT YOUR SERVICES",
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index];
                            final isSelected =
                                selectedServices.contains(service);

                            return CheckboxListTile(
                              title: Text(
                                service,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              value: isSelected,
                              activeColor: Theme.of(context).primaryColor,
                              checkColor: Colors.white,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value ?? false) {
                                    selectedServices.add(service);
                                  } else {
                                    selectedServices.remove(service);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () async {
                        if (selectedServices.isEmpty) {
                          FancySnackbar.showSnackbar(
                            context,
                            snackBarType: FancySnackBarType.warning,
                            title: "Warning",
                            message: "Please pick a role",
                            duration: 2,
                            onCloseEvent: () {},
                          );
                          return;
                        } else {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              "selectedServices", selectedServices[0]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SIgnUpScreen()),
                          );
                        }
                      },
                      child: Text("NEXT"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
