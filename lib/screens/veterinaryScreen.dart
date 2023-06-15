import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/worker.dart';
import 'package:pet_user_app/screens/veterinaryBookingProcessFilterScreeen.dart';
import 'package:pet_user_app/screens/veterinaryDetailScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maps_launcher/maps_launcher.dart';

var workerId;

class VeterinaryScreen extends BaseRoute {
  // VeterinaryScreen() : super();
  VeterinaryScreen({a, o}) : super(a: a, o: o, r: 'VeterinaryScreen');
  @override
  _VeterinaryScreenState createState() => new _VeterinaryScreenState();
}

class _VeterinaryScreenState extends BaseRouteState {
  _VeterinaryScreenState() : super();

  List<Worker> worker = [];
  var vetWorkers = [];
  ApiUtils _apiUtils = ApiUtils();

  @override
  void initState() {
    super.initState();
    _apiUtils.getAllWorker().then((value) => setState(() => worker = value));

    fetchVetWorkers();
  }

  void openGoogleMapsDirections(
      double destinationLatitude, double destinationLongitude) {
    MapsLauncher.launchCoordinates(destinationLatitude, destinationLongitude);
  }

  TextEditingController controller = new TextEditingController();

  Future<void> fetchVetWorkers() async {
    final workers = await _apiUtils.getAllWorker();
    final filteredWorkers =
        workers.where((worker) => worker.role == 'Vet').toList();
    setState(() {
      vetWorkers = filteredWorkers;
    });
    print(vetWorkers);
  }

  List<Worker> searchWorker = [];

  onSearchTextChanged(String text) async {
    searchWorker.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    worker.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text) ||
          userDetail.name.toUpperCase().contains(text))
        searchWorker.add(userDetail);
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
            ),
          ),
          title: Text(
            'Veterinary',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(children: [
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Veterinary near you...',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    VeterinaryBookingProccessFilterScreen(
                                      a: widget.analytics,
                                      o: widget.observer,
                                    )));
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
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: searchWorker.length != 0 || controller.text.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchWorker.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                height: 175,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    Container(
                                      // color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 38,
                                              backgroundImage: NetworkImage(
                                                  searchWorker[index].image ??
                                                      ""),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    searchWorker[index].name,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Row(
                                                      children: [
                                                        RatingBar.builder(
                                                          initialRating: 4,
                                                          minRating: 0,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: 20,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          ignoreGestures: true,
                                                          updateOnDrag: false,
                                                          onRatingUpdate:
                                                              (rating) {
                                                            // ratingVal= rating;
                                                            // setState(() { });
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 7),
                                                          child: Text(
                                                            '',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Flexible(
                                                      child: Text(
                                                        (searchWorker[index]
                                                                    .description !=
                                                                null)
                                                            ? searchWorker[
                                                                        index]
                                                                    .description
                                                                    .substring(
                                                                        0, 30) +
                                                                "..."
                                                            : '',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 110,
                                              // color: Colors.yellow,
                                              padding: EdgeInsets.only(),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .checkCircle,
                                                        size: 12,
                                                        color:
                                                            Color(0xFFF0900C),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          'Verified',
                                                          style: TextStyle(
                                                            fontSize: 11.5,
                                                            color: Color(
                                                                0xFFF0900C),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/DT.png',
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                4), // Adjust the spacing between the symbol and the text
                                                        Text(
                                                          (searchWorker[index]
                                                                  .price
                                                                  .toString() ??
                                                              ''),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setInt("workerId",
                                                searchWorker[index].workerId);
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  VeterinaryDetailScreen(
                                                a: widget.analytics,
                                                o: widget.observer,
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 15),
                                            width: 125,
                                            height: 36,
                                            child: Center(
                                              child: Text(
                                                'View profile',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            openGoogleMapsDirections(
                                              vetWorkers[index].latitude,
                                              vetWorkers[index].longitude,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            onPrimary: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.directions,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                "Get Directions",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: vetWorkers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                height: 175,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    Container(
                                      // color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 38,
                                              backgroundImage: NetworkImage(
                                                  vetWorkers[index].image ??
                                                      ""),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    vetWorkers[index].name,
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Row(
                                                      children: [
                                                        RatingBar.builder(
                                                          initialRating: 4,
                                                          minRating: 0,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: 20,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          ignoreGestures: true,
                                                          updateOnDrag: false,
                                                          onRatingUpdate:
                                                              (rating) {
                                                            // ratingVal= rating;
                                                            // setState(() { });
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 7),
                                                          child: Text(
                                                            '',
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Flexible(
                                                      child: Text(
                                                        (vetWorkers[index]
                                                                    .description !=
                                                                null)
                                                            ? vetWorkers[index]
                                                                    .description
                                                                    .substring(
                                                                        0, 30) +
                                                                "..."
                                                            : '',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 110,
                                              // color: Colors.yellow,
                                              padding: EdgeInsets.only(),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .checkCircle,
                                                        size: 12,
                                                        color:
                                                            Color(0xFFF0900C),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          'Verified',
                                                          style: TextStyle(
                                                            fontSize: 11.5,
                                                            color: Color(
                                                                0xFFF0900C),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/DT.png',
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                4), // Adjust the spacing between the symbol and the text
                                                        Text(
                                                          (vetWorkers[index]
                                                                  .price
                                                                  .toString() ??
                                                              ''),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setInt("workerId",
                                                  vetWorkers[index].workerId);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VeterinaryDetailScreen(
                                                            a: widget.analytics,
                                                            o: widget.observer,
                                                          )));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 15),
                                              //  padding: EdgeInsets.all(6),
                                              width: 125,
                                              height: 36,
                                              child: Center(
                                                child: Text(
                                                  'View profile',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                            ),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              // color: Colors.red,
                                              height: 36,
                                              // padding: EdgeInsets.only(left: 15, right: 15),
                                              width: 125,
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context)
                                                              .primaryColor),
                                                  textStyle:
                                                      MaterialStateProperty.all(
                                                          TextStyle(
                                                              fontSize: 13)),
                                                ),
                                                onPressed: () {
                                                  openGoogleMapsDirections(
                                                      vetWorkers[index]
                                                          .latitude,
                                                      vetWorkers[index]
                                                          .longitude);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.directions,
                                                        color: Colors
                                                            .white), // Add the icon here
                                                    SizedBox(
                                                        width:
                                                            4), // Add some spacing between the icon and the text
                                                    Text("Get Direction",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
