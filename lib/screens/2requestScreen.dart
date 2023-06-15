import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestListScreen extends BaseRoute {
  RequestListScreen({a, o}) : super(a: a, o: o, r: 'RequestListScreen');
  @override
  _RequestListScreenState createState() => _RequestListScreenState();
}

class _RequestListScreenState extends BaseRouteState {
  List<Order> orders = [];
  ApiUtils _apiUtils = ApiUtils();

  @override
  void initState() {
    super.initState();
    getWorkerId();
    upcomingOrders();
    progresOrders();
    completedOrders();
  }

  var workerId;
  void getWorkerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    workerId = prefs.getInt('workerId');
    print(workerId);
  }

// upcoming list
  var upcoming = [];
  Future<void> upcomingOrders() async {
    final orders = await _apiUtils.getAllOrder();
    final filteredupcoming = orders
        .where((up) => up.workerId == workerId && up.status == "pending")
        .toList();
    setState(() {
      upcoming = filteredupcoming;
    });
    print(upcoming);
  }

// progress list
  var progress = [];
  Future<void> progresOrders() async {
    final orders = await _apiUtils.getAllOrder();
    final filteredProg = orders
        .where((prog) => prog.workerId == workerId && prog.status == "accepted")
        .toList();
    setState(() {
      progress = filteredProg;
    });
    print(progress);
  }

//completed list
  var completed = [];
  Future<void> completedOrders() async {
    final orders = await _apiUtils.getAllOrder();
    final filteredComp = orders
        .where(
            (comp) => comp.workerId == workerId && comp.status == "completed")
        .toList();
    setState(() {
      completed = filteredComp;
    });
    print(completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Requests",
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: const Color(0xffACB1C0),
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  tabs: [
                    Tab(
                      child: Text(
                        "Upcoming",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Progress",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Completed",
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(children: [
                  //third tab controller
                  Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView.builder(
                        itemCount: upcoming.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container(
                            child: Card(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(upcoming[index].petName ?? ""),
                                    subtitle: Text(("Walks " +
                                            upcoming[index]
                                                .walkPerDay
                                                .toString()) ??
                                        ""),
                                    trailing: Text(("Meals " +
                                            upcoming[index]
                                                .mealPerDay
                                                .toString()) ??
                                        ""),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.bungalow,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(upcoming[index]
                                            .pickUpDate
                                            .toString()
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(upcoming[index]
                                            .dropOffDate
                                            .toString()
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: const Divider(
                                        height: 5,
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 38,
                                        margin: const EdgeInsets.all(10),
                                        width: 100,
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            onPressed: () {
                                              declineDialog(upcoming[index].id,
                                                  upcomingOrders);
                                            },
                                            child: Text("decline",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor))),
                                      ),
                                      Container(
                                          height: 38,
                                          margin: const EdgeInsets.all(10),
                                          width: 100,
                                          child: TextButton(
                                              onPressed: () {
                                                acceptDialog(
                                                    upcoming[index].id,
                                                    "upcoming",
                                                    upcomingOrders,
                                                    progresOrders,
                                                    completedOrders);
                                              },
                                              child: Text(
                                                "accept",
                                              ))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                  //forth tab controller
                  Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView.builder(
                        itemCount: progress.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container(
                            child: Card(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(progress[index].petName ?? ""),
                                    subtitle: Text(
                                        progress[index].walkPerDay.toString() ??
                                            ""),
                                    trailing: Text(
                                        progress[index].mealPerDay.toString() ??
                                            ""),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.bungalow,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(progress[index]
                                            .pickUpDate
                                            .toString()
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(progress[index]
                                            .pickUpDate
                                            .toString()
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: const Divider(
                                        height: 5,
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 38,
                                        margin: const EdgeInsets.all(10),
                                        width: 100,
                                      ),
                                      Container(
                                          // color: Colors.red,
                                          height: 38,
                                          margin: const EdgeInsets.all(10),
                                          width: 100,
                                          child: TextButton(
                                              onPressed: () {
                                                acceptDialog(
                                                    progress[index].id,
                                                    "progress",
                                                    upcomingOrders,
                                                    progresOrders,
                                                    completedOrders);
                                              },
                                              child: Text(
                                                "completed",
                                              ))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                  //fifth tab controller
                  Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView.builder(
                        itemCount: completed.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container(
                            child: Card(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(completed[index].petName ?? ""),
                                    subtitle: Text(completed[index]
                                            .walkPerDay
                                            .toString() ??
                                        ""),
                                    trailing: Text(completed[index]
                                            .mealPerDay
                                            .toString() ??
                                        ""),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.bungalow,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(completed[index]
                                            .pickUpDate
                                            .toString()
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(completed[index]
                                            .dropOffDate
                                            .toString()
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: const Divider(
                                        height: 5,
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 38,
                                        margin: const EdgeInsets.all(10),
                                        width: 100,
                                      ),
                                      Container(
                                          // color: Colors.red,
                                          height: 38,
                                          margin: const EdgeInsets.all(10),
                                          width: 100,
                                          child: TextButton(
                                              onPressed: () {
                                                acceptDialog(
                                                    completed[index].id,
                                                    "completed",
                                                    upcomingOrders,
                                                    progresOrders,
                                                    completedOrders);
                                              },
                                              child: Text(
                                                "delete",
                                              ))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                ]))
              ],
            ),

            // TabBarView(children: [Text('data'), Text('data'), Text('data')])
          ),
        ),

        //main scaffold
      ),
    );
  }

  acceptDialog(int orderId, String confirmationType, Function() cb,
      Function() cb1, Function() cb2) async {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text("Requests"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "cancel",
                      style: const TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Dismiss the dialog but don't
                      // dismiss the swiped item
                      return Navigator.of(context).pop(false);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("confirm"),
                    onPressed: () async {
                      // Perform actions based on the confirmation type
                      if (confirmationType == "upcoming") {
                        // Actions for array1
                        var order = {"id": orderId, "status": "accepted"};
                        _apiUtils.updateOrder(order);
                        cb();
                        cb1();
                        cb2();
                      } else if (confirmationType == "progress") {
                        // Actions for array2
                        var order = {"id": orderId, "status": "completed"};
                        _apiUtils.updateOrder(order);
                        cb();
                        cb1();
                        cb2();
                      } else if (confirmationType == "completed") {
                        // Actions for array3

                        _apiUtils.deleteOrder(orderId);
                        cb();
                        cb1();
                        cb2();
                      }

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print('Exception - base.dart - exitAppDialog(): ' + e.toString());
    }
  }

  declineDialog(int orderId, Function() cb) async {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text(
                  "Request",
                ),
                content: Text(""),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "cancel",
                      style: const TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Dismiss the dialog but don't
                      // dismiss the swiped item
                      return Navigator.of(context).pop(false);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('Decline'),
                    onPressed: () async {
                      _apiUtils.deleteOrder(orderId);
                      cb();
                      Navigator.pop(context);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(a: widget.analytics, o: widget.observer)));
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print('Exception - base.dart - exitAppDialog(): ' + e.toString());
    }
  }
}
