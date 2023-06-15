import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/2serviceAgreementScreen.dart';

class OfferServiceScreen extends BaseRoute {
  OfferServiceScreen({a, o}) : super(a: a, o: o, r: 'OfferServiceScreen');
  @override
  _OfferServiceScreenState createState() => _OfferServiceScreenState();
}

class _OfferServiceScreenState extends BaseRouteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Services",
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          //center button
          Center(
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/offre.png',
                      ),
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 1.0, color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiceAgreementScreen()),
                        );
                      },
                      child: Text(
                        "offer services now",
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
