import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';

import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/cart.dart';
import 'package:pet_user_app/screens/checkoutScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var connId;
double totalPrice = 0.0;

class CartScreen extends BaseRoute {
  // CartScreen() : super();
  CartScreen({a, o}) : super(a: a, o: o, r: 'CartScreen');
  @override
  _CartScreenState createState() => new _CartScreenState();
}

class _CartScreenState extends BaseRouteState {
  _CartScreenState() : super();
  List<Cart> cart = [];
  var userCarts = [];
  ApiUtils _apiUtils = ApiUtils();
  @override
  void initState() {
    super.initState();
    getUserId();
    fetchUsercarts();
  }

  Future<void> fetchUsercarts() async {
    final carts = await _apiUtils.getAllCart();
    final filteredcarts = carts.where((cart) => cart.userId == connId).toList();
    setState(() {
      userCarts = filteredcarts;
    });
    totalPrice = calculateTotalPrice();
    print(userCarts);
  }

  double calculateTotalPrice() {
    totalPrice = 0;
    for (var cart in userCarts) {
      totalPrice += cart.productPrice;
    }

    return totalPrice;
  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    connId = prefs.getInt('connId');

    print(connId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Cart',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF34385A),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 45,
                // color: Colors.red,
                child: ListView.builder(
                    itemCount: userCarts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(),
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Card(
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 10),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                        userCarts[index].image ?? ""),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, left: 08),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userCarts[index].productName,
                                      ),
                                      Text('Breed',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2),
                                      Text(userCarts[index].breed,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2),
                                      Row(
                                        children: [
                                          Text(
                                              'Quantity : ' +
                                                  userCarts[index]
                                                      .quantity
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .subtitle2),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Icon(
                                              FontAwesomeIcons.caretUp,
                                              color: Color(0xFF8F8F8F),
                                              size: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Icon(
                                              FontAwesomeIcons.caretDown,
                                              color: Color(0xFF8F8F8F),
                                              size: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 3),
                                  // color: Colors.yellow,
                                  width:
                                      MediaQuery.of(context).size.width - 300,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _apiUtils.deleteProdFromcart(
                                              userCarts[index].cartId);
                                          fetchUsercarts();
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Color(0xFF8F8F8F),
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'assets/DT.png',
                                              width: 24,
                                              height: 24,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              userCarts[index]
                                                  .productPrice
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline1,
                                            )
                                          ])
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Total Amount',
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    totalPrice.toString(),
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                )
              ],
            ),
            Container(
                // color: Colors.red,
                height: 45,
                padding: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                    onPressed: () {
                      print('Hello');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChekoutScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    },
                    child: Text(
                      "Place Order",
                    ))),
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
}
