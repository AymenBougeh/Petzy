import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/worker.dart';
import 'package:pet_user_app/screens/reviewBookingScreen.dart';
import 'package:pet_user_app/screens/veterinaryReviewBookingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var workerId;
var vetDet = [];

class VeterinaryDetailScreen extends BaseRoute {
  // VeterinaryDetailScreen() : super();
  VeterinaryDetailScreen({a, o})
      : super(a: a, o: o, r: 'VeterinaryDetailScreen');
  @override
  _VeterinaryDetailScreenState createState() =>
      new _VeterinaryDetailScreenState();
}

class _VeterinaryDetailScreenState extends BaseRouteState {
  _VeterinaryDetailScreenState() : super();
  ApiUtils _apiUtils = ApiUtils();
  List<Worker> vet;

  @override
  void initState() {
    super.initState();
    getWorkerId();
    fetchVetdet();
  }

  void getWorkerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    workerId = prefs.getInt('workerId');
    print(workerId);
  }

  Future<void> fetchVetdet() async {
    final vet = await _apiUtils.getAllWorker();
    final filteredVet = vet.where((det) => det.workerId == workerId).toList();
    setState(() {
      vetDet = filteredVet;
    });
  }

  void openGoogleMapsDirections(
      double destinationLatitude, double destinationLongitude) {
    MapsLauncher.launchCoordinates(destinationLatitude, destinationLongitude);
  }

  double ratingVal = 0.0;
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
          'Vet Details',
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
          itemCount: vetDet.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
                child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      NetworkImage(vetDet[index].image ?? "")),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 0,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ),
                              radius: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.verified, color: Color(0xfff0900c)),
                              Text(
                                vetDet[index].yearsOfExperience.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFF0900C),
                                ),
                              ),
                              Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFF0900C),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                '5.0',
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: ratingVal,
                                      minRating: 0,
                                      // direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      ignoreGestures: true,
                                      updateOnDrag: false,
                                      onRatingUpdate: (val) {},
                                    ),
                                  ],
                                ),
                              ),
                              Text('')
                            ],
                          ),
                        ),
                        // Container(
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         '23',
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        //       Text('Pets'),
                        //       Text('Treated')
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            vetDet[index].name,
                            style: Theme.of(context).primaryTextTheme.headline1,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vetDet[index].description ?? "",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Avilabe for",
                            style: Theme.of(context).primaryTextTheme.headline1,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 0),
                          child: Row(
                            children: [
                              Container(
                                  child: Icon(
                                Icons.apartment,
                                color: Color(0xFF8f8f8f),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  'Visite in clinic',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 0),
                          child: Row(
                            children: [
                              Container(
                                  child: Icon(
                                Icons.phone,
                                color: Color(0xFF8f8f8f),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  'Phone Consultation',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 0),
                          child: Row(
                            children: [
                              Container(
                                  child: Icon(
                                Icons.video_call,
                                color: Color(0xFF8f8f8f),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  'Video Consultation',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0, top: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "What " +
                                      vetDet[index].name +
                                      " would like to know about your pet ",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText1,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0, top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    vetDet[index].aboutPet ?? "",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 215, right: 20, top: 50),
                          child: Row(
                            children: [
                              Icon(Icons.directions),
                              GestureDetector(
                                  onTap: () {
                                    openGoogleMapsDirections(
                                        vetDet[index].latitude,
                                        vetDet[index].longitude);
                                  },
                                  child: Text('Get Directions',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      )))
                            ],
                          ),
                        )
                        //
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 25, right: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text('Reviews',
                        //           style: Theme.of(context)
                        //               .primaryTextTheme
                        //               .bodyText1),
                        //       Text(
                        //         'View All',
                        //         style: Theme.of(context)
                        //             .primaryTextTheme
                        //             .headline6,
                        //       )
                        //     ],
                        //   ),
                        // ),

                        // Container(
                        //     height: 150,
                        //     child: Stack(children: [
                        //       Card(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(10.0)),
                        //         elevation: 5,
                        //         child: Container(
                        //             padding: EdgeInsets.all(10),
                        //             width: MediaQuery.of(context).size.width,
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 140,
                        //                   child: Column(
                        //                     children: [
                        //                       Container(
                        //                         child: Padding(
                        //                           padding:
                        //                               const EdgeInsets.only(
                        //                                   right: 0),
                        //                           child: CircleAvatar(
                        //                               radius: 40,
                        //                               // backgroundColor: Colors.red,
                        //                               backgroundImage: AssetImage(
                        //                                   'assets/home4.png')),
                        //                         ),
                        //                       ),
                        //                       Container(
                        //                         padding: EdgeInsets.only(
                        //                             top: 2,
                        //                             bottom: 2,
                        //                             left: 7,
                        //                             right: 7),
                        //                         margin: EdgeInsets.only(top: 3),
                        //                         child: Text('verified visit',
                        //                             style: Theme.of(context)
                        //                                 .primaryTextTheme
                        //                                 .headline6),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Container(
                        //                     margin: EdgeInsets.only(left: 10),
                        //                     // color: Colors.green,
                        //                     width: MediaQuery.of(context)
                        //                             .size
                        //                             .width -
                        //                         150,
                        //                     height: 120,
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         Row(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment
                        //                                   .spaceBetween,
                        //                           children: [
                        //                             Text('name',
                        //                                 style: Theme.of(context)
                        //                                     .primaryTextTheme
                        //                                     .bodyText1),
                        //                           ],
                        //                         ),
                        //                         Expanded(
                        //                           child: Text(
                        //                             'desc ',
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             style: Theme.of(context)
                        //                                 .primaryTextTheme
                        //                                 .subtitle2,
                        //                             maxLines: 4,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ))
                        //               ],
                        //             )),
                        //       ),
                        //       Positioned(
                        //         right: 10,
                        //         top: 5,
                        //         child: Container(
                        //           child: Row(
                        //             children: [
                        //               RatingBar.builder(
                        //                 initialRating: ratingVal,
                        //                 minRating: 0,
                        //                 // direction: Axis.horizontal,
                        //                 allowHalfRating: true,
                        //                 itemCount: 5,
                        //                 itemSize: 15,
                        //                 itemPadding:
                        //                     EdgeInsets.symmetric(horizontal: 0),
                        //                 itemBuilder: (context, _) => Icon(
                        //                   Icons.star,
                        //                   color: Colors.amber,
                        //                 ),
                        //                 ignoreGestures: true,
                        //                 updateOnDrag: true,
                        //                 onRatingUpdate: (val) {},
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     ])),
                      ],
                    ),
                  ),
                ],
              ),
            ));
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
