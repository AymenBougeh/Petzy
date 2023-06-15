import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/apiHelper.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/products.dart';
import 'package:pet_user_app/screens/CartScreen.dart';
import 'package:pet_user_app/screens/productDetailScreen.dart';
import 'package:pet_user_app/screens/productFilterScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';

var connId;
int cartItemCount = 0;

class ProductStoreScreen extends BaseRoute {
  // ProductStoreScreen() : super();
  ProductStoreScreen({a, o}) : super(a: a, o: o, r: 'ProductStoreScreen');
  @override
  _ProductStoreScreenState createState() => new _ProductStoreScreenState();
}

class _ProductStoreScreenState extends BaseRouteState {
  _ProductStoreScreenState() : super();

  List<Products> product = [];
  bool filtre = false;

  ApiUtils _apiUtils = ApiUtils();

  void initState() {
    super.initState();
    getWorkerId();

    _apiUtils.getAllProducts().then((value) => setState(() => product = value));
    print(product);
  }

  List<Products> selectedProduct = [];
  void getWorkerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    connId = prefs.getInt('connId');

    print(connId);
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<Products>(
      context,
      hideSelectedTextCount: true,
      themeData:
          FilterListThemeData(context, headerTheme: HeaderThemeData.light()),
      headlineText: 'Select Product'.toUpperCase(),
      height: 500,
      backgroundColor: Colors.black,
      listData: product,
      selectedListData: selectedProduct,
      choiceChipLabel: (item) => item.name,
      validateSelectedItem: (list, val) => list.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.name.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedProduct = List.from(list);
        });
        Navigator.of(context, rootNavigator: true).pop();
        filtre = true;
        print(filtre);
      },
    );
  }

  TextEditingController controller = new TextEditingController();

  List<Products> _searchResult = [];

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    product.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text) ||
          userDetail.name.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
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
          'Product Store',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(
                    a: widget.analytics,
                    o: widget.observer,
                  ),
                ));
              },
              child: Badge(
                badgeContent: Text(
                  cartItemCount.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                badgeColor: Colors.red,
                position: BadgePosition.topEnd(top: 0, end: 3),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF34385A),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              height: 38,
              width: 1600,
              child: ListTile(
                title: TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 20),
                    hintText: 'Search',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel, size: 20),
                      onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onChanged: onSearchTextChanged,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openFilterDialog();
                        },
                        child: Icon(
                          FontAwesomeIcons.filter,
                          color: Color(0xFF8F8F8F),
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.filter_3_outlined,
                          size: 18,
                          color: Color(0xFF8F8F8F),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                  child: filtre == false
                      ? SizedBox(
                          child:
                              _searchResult.length != 0 ||
                                      controller.text.isNotEmpty
                                  ? AnimationLimiter(
                                      child: GridView.builder(
                                          itemCount: _searchResult.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.57),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                                    columnCount: 2,
                                                    position: index,
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    child: ScaleAnimation(
                                                        child: FadeInAnimation(
                                                            delay: Duration(
                                                                milliseconds:
                                                                    200),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  prefs.setInt(
                                                                      "productid",
                                                                      _searchResult[
                                                                              index]
                                                                          .id);

                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => ProductDetailScreen(
                                                                                a: widget.analytics,
                                                                                o: widget.observer,
                                                                              )));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 285,
                                                                  width: 160,
                                                                  child: Card(
                                                                    elevation:
                                                                        3,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: 45),
                                                                                  height: 125,
                                                                                  width: 180,
                                                                                  child: Image.network(_searchResult[index].image),
                                                                                ),
                                                                                Positioned(
                                                                                    top: 10,
                                                                                    right: 0,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                                                                          margin: EdgeInsets.only(right: 0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
                                                                                                child: Icon(
                                                                                                  Icons.star_outline,
                                                                                                  color: Theme.of(context).primaryColor,
                                                                                                  size: 20,
                                                                                                ),
                                                                                              ),
                                                                                              Text('5'),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Divider(
                                                                              height: 1,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Flexible(
                                                                                    child: Text(
                                                                                  _searchResult[index].name,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                )),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: 5),
                                                                                  child: Icon(
                                                                                    Icons.favorite,
                                                                                    color: Theme.of(context).primaryColor,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: 155,
                                                                                  child: Text(
                                                                                    _searchResult[index].description,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Image.asset(
                                                                                  'assets/DT.png',
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                ),
                                                                                SizedBox(width: 4),
                                                                                /*  Icon(
                                                FontAwesomeIcons.rupeeSign,
                                                size: 15,
                                                color: Colors.black,
                                              ),*/
                                                                                Text(
                                                                                  _searchResult[index].price.toString(),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              // margin: EdgeInsets.only(right: 15),
                                                                              // color: Colors.red,
                                                                              height: 42,
                                                                              // padding: EdgeInsets.only(left: 15, right: 15),
                                                                              width: 200,
                                                                              child: TextButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13))),
                                                                                  onPressed: () async {
                                                                                    var cart = {
                                                                                      "users_id": connId,
                                                                                      "shop_id": product[index].id,
                                                                                      "product_name": product[index].name,
                                                                                      "product_price": product[index].price,
                                                                                      "quantity": 1,
                                                                                      "product_img": product[index].image,
                                                                                      "breed": product[index].breed,
                                                                                    };
                                                                                    await _apiUtils.addToCart(cart);
                                                                                    setState(() {
                                                                                      cartItemCount++; // Increment the cart item count
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Add to Cart",
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))));
                                          }),
                                    )
                                  : AnimationLimiter(
                                      child: GridView.builder(
                                          itemCount: product.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.57),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                                    columnCount: 2,
                                                    position: index,
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    child: ScaleAnimation(
                                                        child: FadeInAnimation(
                                                            delay: Duration(
                                                                milliseconds:
                                                                    200),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  prefs.setInt(
                                                                      "productid",
                                                                      product[index]
                                                                          .id);

                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => ProductDetailScreen(
                                                                                a: widget.analytics,
                                                                                o: widget.observer,
                                                                              )));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 285,
                                                                  width: 160,
                                                                  child: Card(
                                                                    elevation:
                                                                        3,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: 45),
                                                                                  height: 125,
                                                                                  width: 180,
                                                                                  child: Image.network(product[index].image),
                                                                                ),
                                                                                Positioned(
                                                                                    top: 10,
                                                                                    right: 0,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                                                                          margin: EdgeInsets.only(right: 0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
                                                                                                child: Icon(
                                                                                                  Icons.star_outline,
                                                                                                  color: Theme.of(context).primaryColor,
                                                                                                  size: 20,
                                                                                                ),
                                                                                              ),
                                                                                              Text('5'),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Divider(
                                                                              height: 1,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Flexible(
                                                                                    child: Text(
                                                                                  product[index].name,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                )),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: 5),
                                                                                  child: Icon(
                                                                                    Icons.favorite,
                                                                                    color: Theme.of(context).primaryColor,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: 155,
                                                                                  child: Text(
                                                                                    product[index].description,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Image.asset(
                                                                                  'assets/DT.png',
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                ),
                                                                                SizedBox(width: 4),
                                                                                /*  Icon(
                                                FontAwesomeIcons.rupeeSign,
                                                size: 15,
                                                color: Colors.black,
                                              ),*/
                                                                                Text(
                                                                                  product[index].price.toString(),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              // margin: EdgeInsets.only(right: 15),
                                                                              // color: Colors.red,
                                                                              height: 42,
                                                                              // padding: EdgeInsets.only(left: 15, right: 15),
                                                                              width: 200,
                                                                              child: TextButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13))),
                                                                                  onPressed: () async {
                                                                                    var cart = {
                                                                                      "users_id": connId,
                                                                                      "shop_id": product[index].id,
                                                                                      "product_name": product[index].name,
                                                                                      "product_price": product[index].price,
                                                                                      "quantity": 1,
                                                                                      "product_img": product[index].image,
                                                                                      "breed": product[index].breed,
                                                                                    };
                                                                                    await _apiUtils.addToCart(cart);
                                                                                    setState(() {
                                                                                      cartItemCount++; // Increment the cart item count
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Add to Cart",
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))));
                                          }),
                                    ))
                      : SizedBox(
                          child:
                              _searchResult.length != 0 ||
                                      controller.text.isNotEmpty
                                  ? AnimationLimiter(
                                      child: GridView.builder(
                                          itemCount: _searchResult.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.57),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                                    columnCount: 2,
                                                    position: index,
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    child: ScaleAnimation(
                                                        child: FadeInAnimation(
                                                            delay: Duration(
                                                                milliseconds:
                                                                    200),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  prefs.setInt(
                                                                      "productid",
                                                                      _searchResult[
                                                                              index]
                                                                          .id);

                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => ProductDetailScreen(
                                                                                a: widget.analytics,
                                                                                o: widget.observer,
                                                                              )));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 285,
                                                                  width: 160,
                                                                  child: Card(
                                                                    elevation:
                                                                        3,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: 45),
                                                                                  height: 125,
                                                                                  width: 180,
                                                                                  child: Image.network(_searchResult[index].image),
                                                                                ),
                                                                                Positioned(
                                                                                    top: 10,
                                                                                    right: 0,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                                                                          margin: EdgeInsets.only(right: 0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
                                                                                                child: Icon(
                                                                                                  Icons.star_outline,
                                                                                                  color: Theme.of(context).primaryColor,
                                                                                                  size: 20,
                                                                                                ),
                                                                                              ),
                                                                                              Text('5'),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Divider(
                                                                              height: 1,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Flexible(
                                                                                    child: Text(
                                                                                  _searchResult[index].name,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                )),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: 5),
                                                                                  child: Icon(
                                                                                    Icons.favorite,
                                                                                    color: Theme.of(context).primaryColor,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: 155,
                                                                                  child: Text(
                                                                                    _searchResult[index].description,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Image.asset(
                                                                                  'assets/DT.png',
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                ),
                                                                                SizedBox(width: 4),
                                                                                /*  Icon(
                                                FontAwesomeIcons.rupeeSign,
                                                size: 15,
                                                color: Colors.black,
                                              ),*/
                                                                                Text(
                                                                                  _searchResult[index].price.toString(),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              // margin: EdgeInsets.only(right: 15),
                                                                              // color: Colors.red,
                                                                              height: 42,
                                                                              // padding: EdgeInsets.only(left: 15, right: 15),
                                                                              width: 200,
                                                                              child: TextButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13))),
                                                                                  onPressed: () async {
                                                                                    var cart = {
                                                                                      "users_id": connId,
                                                                                      "shop_id": product[index].id,
                                                                                      "product_name": product[index].name,
                                                                                      "product_price": product[index].price,
                                                                                      "quantity": 1,
                                                                                      "product_img": product[index].image,
                                                                                      "breed": product[index].breed,
                                                                                    };
                                                                                    await _apiUtils.addToCart(cart);
                                                                                    setState(() {
                                                                                      cartItemCount++; // Increment the cart item count
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Add to Cart",
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))));
                                          }),
                                    )
                                  : AnimationLimiter(
                                      child: GridView.builder(
                                          itemCount: selectedProduct.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.57),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                                    columnCount: 2,
                                                    position: index,
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    child: ScaleAnimation(
                                                        child: FadeInAnimation(
                                                            delay: Duration(
                                                                milliseconds:
                                                                    200),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  prefs.setInt(
                                                                      "productid",
                                                                      selectedProduct[
                                                                              index]
                                                                          .id);

                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => ProductDetailScreen(
                                                                                a: widget.analytics,
                                                                                o: widget.observer,
                                                                              )));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 285,
                                                                  width: 160,
                                                                  child: Card(
                                                                    elevation:
                                                                        3,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: 45),
                                                                                  height: 125,
                                                                                  width: 180,
                                                                                  child: Image.network(selectedProduct[index].image),
                                                                                ),
                                                                                Positioned(
                                                                                    top: 10,
                                                                                    right: 0,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                                                                          margin: EdgeInsets.only(right: 0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
                                                                                                child: Icon(
                                                                                                  Icons.star_outline,
                                                                                                  color: Theme.of(context).primaryColor,
                                                                                                  size: 20,
                                                                                                ),
                                                                                              ),
                                                                                              Text('5'),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Divider(
                                                                              height: 1,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Flexible(
                                                                                    child: Text(
                                                                                  selectedProduct[index].name,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                )),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: 5),
                                                                                  child: Icon(
                                                                                    Icons.favorite,
                                                                                    color: Theme.of(context).primaryColor,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: 155,
                                                                                  child: Text(
                                                                                    selectedProduct[index].description,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Theme.of(context).primaryTextTheme.subtitle2,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Image.asset(
                                                                                  'assets/DT.png',
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                ),
                                                                                SizedBox(width: 4),
                                                                                /*  Icon(
                                                FontAwesomeIcons.rupeeSign,
                                                size: 15,
                                                color: Colors.black,
                                              ),*/
                                                                                Text(
                                                                                  selectedProduct[index].price.toString(),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              // margin: EdgeInsets.only(right: 15),
                                                                              // color: Colors.red,
                                                                              height: 42,
                                                                              // padding: EdgeInsets.only(left: 15, right: 15),
                                                                              width: 200,
                                                                              child: TextButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor), textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13))),
                                                                                  onPressed: () async {
                                                                                    var cart = {
                                                                                      "users_id": connId,
                                                                                      "shop_id": product[index].id,
                                                                                      "product_name": product[index].name,
                                                                                      "product_price": product[index].price,
                                                                                      "quantity": 1,
                                                                                      "product_img": product[index].image,
                                                                                      "breed": product[index].breed,
                                                                                    };
                                                                                    await _apiUtils.addToCart(cart);
                                                                                    setState(() {
                                                                                      cartItemCount++; // Increment the cart item count
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Add to Cart",
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))));
                                          }),
                                    ),
                        )),
            )
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
