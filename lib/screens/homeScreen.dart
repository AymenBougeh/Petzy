import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/address.dart';
import 'package:pet_user_app/models/entites/blogs.dart';
import 'package:pet_user_app/models/entites/event.dart';

import 'package:pet_user_app/screens/CartScreen.dart';
import 'package:pet_user_app/screens/addBlogScreen.dart';
import 'package:pet_user_app/screens/dogWalkingScreen.dart';
import 'package:pet_user_app/screens/petBoardingScreen.dart';
import 'package:pet_user_app/screens/productstoreScreen.dart';
import 'package:pet_user_app/screens/veterinaryScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

var connId;

class HomeScreen extends BaseRoute {
  // HomeScreen() : super();
  HomeScreen({a, o}) : super(a: a, o: o, r: 'HomeScreen');
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends BaseRouteState {
  int selectedValue = 0;
  _HomeScreenState() : super();
  Address userAddress;
  ApiUtils _apiUtils = ApiUtils();
  List<Blogs> blogs = [];
  List<Event> events = [];
  final PageController _pageController = PageController(initialPage: 0);
  Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchAndPostUserLocation();
    getConnId();
    _apiUtils.getAllBlogs().then((value) => setState(() => blogs = value));
    _apiUtils.getAllEvents().then((value) => setState(() => events = value));
    print(blogs);
    _startAutoPageChange();
  }

  @override
  void dispose() {
    _stopAutoPageChange();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPageChange() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (selectedValue < events.length - 1) {
        selectedValue++;
      } else {
        selectedValue = 0;
      }
      _pageController.animateToPage(
        selectedValue,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPageChange() {
    _timer?.cancel();
    _timer = null;
  }

  void getConnId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    connId = prefs.getInt('connId');
    print(connId);
  }

  Future<void> fetchAndPostUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return;
    } else if (permission == LocationPermission.deniedForever) {
      // Handle denied permission forever
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String country = placemark.administrativeArea ?? '';
      String address = placemark.thoroughfare ?? '';
      String city = placemark.locality ?? '';
      String state = placemark.subAdministrativeArea ?? '';
      String zip = placemark.postalCode ?? '';

      setState(() {
        userAddress = Address(
          name: country,
          address: address,
          city: city,
          state: state,
          zip: zip,
          latitude: position.latitude,
          longitude: position.longitude,
        );
      });

      // Update the user's address in the backend
      await _apiUtils.postAddress(userAddress);
      print(placemark);
      print(userAddress);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("loc", userAddress.state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false, // Used for removing back buttoon.
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFF34385A),
                size: 28,
              ),
              Flexible(
                child: Container(
                  // color: Colors.red,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        userAddress != null ? userAddress.name ?? '' : '',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      Row(
                        children: [
                          Text(
                              userAddress != null
                                  ? '${userAddress.state ?? ''}'
                                  : "",
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2),
                          Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.black,
                            size: 10,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartScreen(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF34385A),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 37,
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'Search',
                      contentPadding: EdgeInsets.only(top: 5, left: 10),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          'What are you looking for?',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PetBoardingScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Container(
                          // color: Colors.red,
                          width: 90,
                          height: 75,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/homepetboarding2.png',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'Pet boarding',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DogWalkingScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Container(
                          width: 90,
                          height: 95,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/homepetboarding3.png',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'Dog Walking',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VeterinaryScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Container(
                          width: 90,
                          height: 95,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/homepetboarding4.png',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'Veterinary',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductStoreScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Container(
                          width: 90,
                          height: 95,
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/homepetboarding2.png',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'Product Store',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Events',
                          style: Theme.of(context).primaryTextTheme.bodyText1),
                      Text(
                        '',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (val) {
                        selectedValue = val;
                        setState(() {});
                      },
                      itemCount: events.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 10, bottom: 10),
                                        child: Text(events[index].title ?? "",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline3),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                                events[index].description ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline2),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 2),
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                      radius: 30,
                                      // backgroundColor: Colors.red,
                                      backgroundImage: NetworkImage(
                                          events[index].date ?? "")),
                                )
                              ],
                            ),
                            DotsIndicator(
                              dotsCount: 3,
                              position: double.parse(selectedValue.toString()),
                              decorator: DotsDecorator(
                                color: Colors.black87, // Inactive color
                                activeColor: Color(0xFFF0900C),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Blogs',
                          style: Theme.of(context).primaryTextTheme.bodyText1),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddBlogScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Text('add blog',
                            style:
                                Theme.of(context).primaryTextTheme.headline6),
                      )
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      var blog = blogs[index];
                      return Container(
                        height: 84,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(blog.image),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        height: 70,
                                        width: 80,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width - 134,
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            blog.title,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                          ),
                                          Icon(
                                            Icons.bookmark,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Text(
                                          blog.content,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // bool isloading = true;
}
