import 'package:flutter/material.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/order.dart';
import 'package:pet_user_app/screens/chatListScreen.dart';
import 'package:pet_user_app/screens/orderDetailScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends BaseRoute {
  // OrdersScreen() : super();
  OrdersScreen({a, o}) : super(a: a, o: o, r: 'OrdersScreen');
  @override
  _OrdersScreenState createState() => new _OrdersScreenState();
}

class _OrdersScreenState extends BaseRouteState {
  _OrdersScreenState() : super();
  List<Order> orders = [];
  ApiUtils _apiUtils = ApiUtils();
  @override
  void initState() {
    super.initState();
    getconnId();
    pendingOrders();
    activeOrders();
  }

  var connId;
  void getconnId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    connId = prefs.getInt('connId');
    print(connId);
  }

  // pending list
  var pending = [];
  Future<void> pendingOrders() async {
    final orders = await _apiUtils.getAllOrder();
    final filteredpending = orders
        .where((pen) => pen.userId == connId && pen.status == "pending")
        .toList();
    setState(() {
      pending = filteredpending;
    });
    print(pending);
  }

  // active list
  var active = [];
  Future<void> activeOrders() async {
    final orders = await _apiUtils.getAllOrder();
    final filteredActive = orders
        .where((act) => act.userId == connId && act.status == "accepted")
        .toList();
    setState(() {
      active = filteredActive;
    });
    print(active);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Orders',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
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
                  margin: EdgeInsets.only(top: 10),
                  height: 550,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      body: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 12),
                            height: 61,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Container(
                                child: PreferredSize(
                                  preferredSize: Size.fromHeight(40.0),
                                  child: AppBar(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2.0),
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    bottom: TabBar(
                                      unselectedLabelColor: Colors.grey,
                                      indicatorColor:
                                          Theme.of(context).primaryColor,
                                      tabs: [
                                        Tab(
                                          child: Container(
                                            child: Text(
                                              'Pending',
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            child: Text(
                                              'Active',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // create widgets for each tab bar here
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(0.11),
                              child: TabBarView(
                                children: [
                                  // first tab bar view widget
                                  Container(
                                      child: ListView.builder(
                                          itemCount: pending.length,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(),
                                              child: Card(
                                                elevation: 3,
                                                child: Container(
                                                  height: 124,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          //color: Colors.green,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    left: 10),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child: Column(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            38,
                                                                        backgroundImage:
                                                                            NetworkImage(""),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          pending[index]
                                                                              .workerName,
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .headline6,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Pet Boarding',
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .headline1,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Text(
                                                                                pending[index].petName,
                                                                                style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Text(
                                                                                pending[index].mealPerDay.toString() + ' daily meals',
                                                                                style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Start: ',
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                  Text(
                                                                                    pending[index].pickUpDate.toString().substring(0, 10),
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Finish: ',
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                  Text(
                                                                                    pending[index].dropOffDate.toString().substring(0, 10),
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 110,
                                                                  // color:
                                                                  //     Colors.yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 1),
                                                                            child:
                                                                                Text(
                                                                              'Order Id: W' + pending[index].id.toString(),
                                                                              style: TextStyle(
                                                                                fontSize: 10.5,
                                                                                color: Color(0xFFF0900C),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(left: 80),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              'assets/DT.png',
                                                                              width: 24,
                                                                              height: 24,
                                                                            ),
                                                                            Text(
                                                                              pending[index].price.toString(),
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            // Add some spacing between the text and the image
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),

                                  // second tab bar view widget
                                  Container(
                                      child: ListView.builder(
                                          itemCount: active.length,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(),
                                              child: Card(
                                                elevation: 3,
                                                child: Container(
                                                  height: 175,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          //color: Colors.green,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    left: 10),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child: Column(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            38,
                                                                        backgroundImage:
                                                                            NetworkImage(""),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          active[index].workerName ??
                                                                              "",
                                                                          style: Theme.of(context)
                                                                              .primaryTextTheme
                                                                              .headline6,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Pet Boarding',
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .headline1,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Text(
                                                                                active[index].petName ?? "",
                                                                                style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Text(
                                                                                active[index].mealPerDay.toString() ?? "",
                                                                                style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Start: ',
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                  Text(
                                                                                    active[index].pickUpDate.toString().substring(0, 10),
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 1),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'Finish: ',
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                  Text(
                                                                                    active[index].dropOffDate.toString().substring(0, 10) ?? "",
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 110,
                                                                  // color:
                                                                  //     Colors.yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 1),
                                                                            child:
                                                                                Text(
                                                                              'Order Id: W' + active[index].id.toString(),
                                                                              style: TextStyle(
                                                                                fontSize: 10.5,
                                                                                color: Color(0xFFF0900C),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(left: 80),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              'assets/DT.png',
                                                                              width: 24,
                                                                              height: 24,
                                                                            ),
                                                                            Text(
                                                                              pending[index].price.toString(),
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            // Add some spacing between the text and the image
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                        child: Divider(
                                                          height: 10,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 15),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(6),
                                                              width: 125,
                                                              height: 36,
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .cancel,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                3,
                                                                            left:
                                                                                2),
                                                                        child:
                                                                            Text(
                                                                          'Cancle',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text('|'),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15),
                                                              //  padding: EdgeInsets.all(6),
                                                              width: 125,
                                                              height: 36,
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .alarm,
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                3,
                                                                            left:
                                                                                2),
                                                                        child:
                                                                            Text(
                                                                          'Add Riminder',
                                                                          style:
                                                                              TextStyle(color: Theme.of(context).primaryColor),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
