import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/2offer.dart';
import 'package:pet_user_app/screens/2profileScreen.dart';
import 'package:pet_user_app/screens/2requestScreen.dart';
import 'package:pet_user_app/screens/profileScreen.dart';

class Bottomnavigationbar extends BaseRoute {
  Bottomnavigationbar({a, o}) : super(a: a, o: o, r: 'Bottomnavigationbar');
  @override
  _BottomnavigationbarState createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends BaseRouteState {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        return null;
      },
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BottomNavigationBar(
                fixedColor: Theme.of(context).primaryColor,
                onTap: _onItemTap,
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  // BottomNavigationBarItem(
                  //   icon: const Icon(
                  //     Icons.home,
                  //   ),
                  //   label: "home",
                  // ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.message_outlined,
                    ),
                    label: "request",
                  ),
                  // BottomNavigationBarItem(
                  //   icon: const FaIcon(
                  //     FontAwesomeIcons.blog,
                  //   ),
                  //   label: "blogs",
                  // ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.menu_book_sharp,
                    ),
                    label: " services",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.person,
                    ),
                    label: "profile",
                  )
                ],
              ),
            ),
            body: _children().elementAt(_selectedIndex)),
      ),
    );
  }

  bool isloading = true;

  _onItemTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  // List<Widget> _children() => [HomeScreen(), RequestListScreen(), BlogListScreen(), OfferServiceScreen(), ProfileScreen()];
  List<Widget> _children() =>
      [RequestListScreen(), OfferServiceScreen(), ProfileScreen2()];
}
