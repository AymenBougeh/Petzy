import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/order.dart';
import 'package:pet_user_app/models/entites/pets.dart';
import 'package:pet_user_app/models/entites/worker.dart';
import 'package:pet_user_app/screens/2settingProfile.dart';
import 'package:pet_user_app/widgets/bottomNavigationBarWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

var workerId;
var worker = [];
var connId;
var userpets = [];
var pickUp;
var dropOf;
var selectedPetName;
var selectedNumberOfMeals;
var selectedNumberOfWalks;
var workerName;
var workerPrice;

class ReviewBookingScreen extends BaseRoute {
  // ReviewBookingScreen() : super();
  ReviewBookingScreen({a, o}) : super(a: a, o: o, r: 'ReviewBookingScreen');
  @override
  _ReviewBookingScreenState createState() => new _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends BaseRouteState {
  bool _isChecked = false;
  bool _isChecked1 = false;
  _ReviewBookingScreenState() : super();
  bool confirm = false;
  double ratingVal = 0.0;
  ApiUtils _apiUtils = ApiUtils();
  List<Worker> wrkr;
  List<Pets> pets = [];
  List<Order> order;
  @override
  void initState() {
    super.initState();
    getWorkerId();
    fetchWorkerById();
    fetchPets();
  }

  void getWorkerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    workerId = prefs.getInt('workerId');
    connId = prefs.getInt('connId');
    print(workerId);
    print(connId);
  }

  Future<void> fetchWorkerById() async {
    final wrkr = await _apiUtils.getAllWorker();
    final filteredWrkr =
        wrkr.where((book) => book.workerId == workerId).toList();
    if (filteredWrkr.isNotEmpty) {
      final selectedWorker = filteredWrkr.first;
      workerName = selectedWorker.name;
      workerPrice = selectedWorker.price;
      setState(() {
        worker = filteredWrkr;
      });

      print('Worker Name: $workerName');
      print('Worker Price: $workerPrice');
    }
  }

  Future<void> fetchPets() async {
    final pets = await _apiUtils.getAllPets();
    final filteredPets = pets.where((pet) => pet.userId == connId).toList();
    setState(() {
      userpets = filteredPets;
    });
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
            color: Color(0xFF34385A),
          ),
        ),
        title: Text(
          'Review Booking',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF34385A),
            ),
          )
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: worker.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
                child: Container(
                    child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 0, left: 10),
                // color: Colors.red,
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              NetworkImage(worker[index].image ?? "")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            worker[index].name ?? "",
                            style: Theme.of(context).primaryTextTheme.headline5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 4, right: 10),
                            child: RatingBar.builder(
                              initialRating: ratingVal,
                              minRating: 0,
                              // direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              ignoreGestures: true,
                              updateOnDrag: false,
                              onRatingUpdate: (val) {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // padding: const EdgeInsets.
              ),
              Divider(
                height: 10,
                thickness: 1,
              ),
              Container(

                  // color: Colors.red,
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectBookingFor(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Booking for',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  children: [
                                    Text('Select Pet'),
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        size: 18, color: Color(0xFF8F8F8F)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      )
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  _selectdropoffdate(context, (selectedDate) {
                    setState(() {
                      dropOf = selectedDate;
                    });
                  });
                },
                child: Container(

                    // color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Drop off',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  children: [
                                    Text(dropOf != null &&
                                            dropOf.toString().length >= 10
                                        ? dropOf.toString().substring(0, 10)
                                        : ""),
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        size: 18, color: Color(0xFF8F8F8F)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Divider(
                            height: 10,
                            thickness: 1,
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  _selectpickupdate(context, (selectedDate) {
                    setState(() {
                      pickUp = selectedDate;
                    });
                  });
                },
                child: Container(

                    // color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Pick up',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  children: [
                                    Text(pickUp != null &&
                                            pickUp.toString().length >= 10
                                        ? pickUp.toString().substring(0, 10)
                                        : ""),
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        size: 18, color: Color(0xFF8F8F8F)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Divider(
                            height: 10,
                            thickness: 1,
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  _selectNumberOfMeals(context);
                },
                child: Container(

                    // color: Colors.red,
                    margin: EdgeInsets.only(bottom: 10, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Meals per days',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text((selectedNumberOfMeals.toString() +
                                                "/Meals") ??
                                            (""))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  children: [
                                    Text('Select Number'),
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        size: 18, color: Color(0xFF8F8F8F)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            height: 10,
                            thickness: 1,
                          ),
                        )
                      ],
                    )),
              ),
              Container(

                  // color: Colors.red,
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectNumberOfWalks(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Walk per Day',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: Row(
                                  children: [
                                    Text("Select Number"),
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        size: 18, color: Color(0xFF8F8F8F)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      )
                    ],
                  )),

              // price detail box
            ])));
          }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
            // color: Colors.red,
            height: 45,
            padding: EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                //olaaaa
                onPressed: () async {
                  var order = {
                    'user_id': connId,
                    'status': "pending",
                    'worker_name': workerName,
                    'pet_name': selectedPetName,
                    'pick_up_date': DateFormat('yyyy-MM-dd').format(pickUp),
                    'drop_of_date': DateFormat('yyyy-MM-dd').format(dropOf),
                    'walk_per_day': selectedNumberOfWalks,
                    'meal_per_day': selectedNumberOfMeals,
                    'worker_id': workerId,
                    'price': workerPrice,
                  };
                  print(order);

                  await _apiUtils.postOrder(order);

                  addToCartDialogBox(context);
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationWidget()));
                  });
                },
                child: Text(
                  "Add to Cart",
                ))),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  void _selectBookingFor(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: 315,
            child: Scaffold(
              body: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Booking For',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userpets.length,
                      itemBuilder: (BuildContext context, int index) {
                        String petName = userpets[index].name ?? "";
                        bool isChecked = petName ==
                            selectedPetName; // Check if the current pet is selected

                        return Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(2),
                                  horizontalTitleGap: 1,
                                  leading: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            userpets[index].image ?? ""),
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        petName,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText1,
                                      ),
                                      Icon(
                                        Icons.male,
                                        color: Color(0xff8f8f8f),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                      userpets[index].age.toString() ?? ""),
                                  trailing: Container(
                                    margin: EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isChecked) {
                                            selectedPetName =
                                                null; // Unselect the current pet if it was already selected
                                          } else {
                                            selectedPetName =
                                                petName; // Store the name of the selected pet
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          shape: BoxShape.circle,
                                          color: isChecked
                                              ? Theme.of(context).primaryColor
                                              : Colors.transparent,
                                        ),
                                        height: 18,
                                        width: 17,
                                        child: Center(
                                          child: Icon(
                                            Icons.check,
                                            color: isChecked
                                                ? Colors.white
                                                : Colors.transparent,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                child: Container(
                  height: 45,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (selectedPetName != null) {
                        print('Selected Pet: $selectedPetName');
                        // Perform any additional actions with the selected pet here
                      }
                      Navigator.of(context).pop(MaterialPageRoute(
                          builder: (context) => ReviewBookingScreen()));
                      setState(() {});
                    },
                    child: Text(
                      "Confirm",
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _selectNumberOfMeals(context) {
    // Variable to store the selected number of meals

    showModalBottomSheet(
      backgroundColor: Colors.red,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
                // color: Colors.cyan,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            height: 180,
            child: Scaffold(
              body: Wrap(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Select Number',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [Container()],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumberOfMeals =
                                      1; // Set the selected number of meals
                                });
                              },
                              child: Card(
                                elevation: selectedNumberOfMeals == 1 ? 6 : 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: selectedNumberOfMeals == 1
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text('1'),
                                  radius: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumberOfMeals =
                                      2; // Set the selected number of meals
                                });
                              },
                              child: Card(
                                elevation: selectedNumberOfMeals == 2 ? 6 : 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: selectedNumberOfMeals == 2
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text('2'),
                                  radius: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumberOfMeals =
                                      3; // Set the selected number of meals
                                });
                              },
                              child: Card(
                                elevation: selectedNumberOfMeals == 3 ? 6 : 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: selectedNumberOfMeals == 3
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text(
                                    '3',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .button
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  radius: 30,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                child: Container(
                  // color: Colors.red,
                  height: 45,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (selectedNumberOfMeals != null) {
                        print(
                            'Selected Number of Meals: $selectedNumberOfMeals');
                        // Perform any additional actions with the selected number of meals here
                      }
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (context) => ReviewBookingScreen(),
                        ),
                      );
                      setState(() {
                        confirm = true;
                      });
                    },
                    child: Text("Confirm"),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _selectNumberOfWalks(context) {
    // Variable to store the selected number of walks

    showModalBottomSheet(
      backgroundColor: Colors.red,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: 180,
            child: Scaffold(
              body: Wrap(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Select Number',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [Container()],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumberOfWalks =
                                      1; // Set the selected number of walks
                                });
                              },
                              child: Card(
                                elevation: selectedNumberOfWalks == 1 ? 6 : 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: selectedNumberOfWalks == 1
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text('1'),
                                  radius: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumberOfWalks =
                                      2; // Set the selected number of walks
                                });
                              },
                              child: Card(
                                elevation: selectedNumberOfWalks == 2 ? 6 : 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: selectedNumberOfWalks == 2
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text('2'),
                                  radius: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNumberOfWalks =
                                      3; // Set the selected number of walks
                                });
                              },
                              child: Card(
                                elevation: selectedNumberOfWalks == 3 ? 6 : 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: selectedNumberOfWalks == 3
                                      ? Colors.blue
                                      : Colors.white,
                                  child: Text(
                                    '3',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .button
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  radius: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0,
                child: Container(
                  height: 45,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (selectedNumberOfWalks != null) {
                        print(
                            'Selected Number of Walks: $selectedNumberOfWalks');
                        // Perform any additional actions with the selected number of walks here
                      }
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (context) => ReviewBookingScreen(),
                        ),
                      );
                      setState(() {
                        confirm = true;
                      });
                    },
                    child: Text("Confirm"),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _selectdropoffdate(
      BuildContext context, Function(DateTime) onDateSelected) {
    DateTime selectedDate = DateTime.now(); // Initialize with the current date

    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 10, 1),
                    lastDay: DateTime.utc(2030, 3, 1),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal bottom sheet
                    onDateSelected(selectedDate);
                    print(dropOf);
                  },
                  child: Text("Confirm"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _selectpickupdate(
      BuildContext context, Function(DateTime) onDateSelected) {
    DateTime selectedDate = DateTime.now(); // Initialize with the current date

    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 10, 1),
                    lastDay: DateTime.utc(2030, 3, 1),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal bottom sheet
                    onDateSelected(selectedDate);
                    print(pickUp);
                  },
                  child: Text("Confirm"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  addToCartDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Stack(
                //          overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                "Added to Cart",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              )),
                              Center(
                                  child: Text(
                                "Thank you for choosing whiskers",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              )),
                              Container(
                                height: 150,
                                width: 200,
                                child:
                                    Image.asset('assets/alertdialogimage.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -70.0,
                    left: 110,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            shape: BoxShape.circle,
                            color: Colors.transparent),
                        height: 28,
                        width: 25,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.times,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
