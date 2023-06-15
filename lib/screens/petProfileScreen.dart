import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/pets.dart';
import 'package:shared_preferences/shared_preferences.dart';

var petId;
var onePet;

class PetProfileScreen extends BaseRoute {
  // PetProfileScreen() : super();
  PetProfileScreen({a, o}) : super(a: a, o: o, r: 'PetProfileScreen');
  @override
  _PetProfileScreenState createState() => new _PetProfileScreenState();
}

class _PetProfileScreenState extends BaseRouteState {
  int selectedValue = 0;
  _PetProfileScreenState() : super();
  ApiUtils _apiUtils = ApiUtils();
  List<Pets> pet;
  @override
  void initState() {
    super.initState();
    getPetId();
    fetchPetdet();
  }

  Future<void> fetchPetdet() async {
    final pet = await _apiUtils.getAllPets();
    final filteredPet = pet.where((det) => det.petId == petId).toList();
    setState(() {
      onePet = filteredPet;
    });
  }

  void getPetId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    petId = prefs.getInt('petId');
    print(petId);
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
            'pet Profile',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
              itemCount: onePet.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      // color: Colors.red,
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    NetworkImage(onePet[index].image)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      onePet[index].name,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.venus,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: Text(
                                    onePet[index].age.toString(),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  width: 85,
                                  height: 30,
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      // padding: const EdgeInsets.
                    ),
                    Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(bottom: 10, top: 35),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Icon(
                                    FontAwesomeIcons.briefcaseMedical,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Blood Presure',
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Text(
                                      '124/130mnhn',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      color: Color(0xFF8F8F8F)),
                                ],
                              ),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Icon(
                                    FontAwesomeIcons.bone,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Bone Density',
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Text(
                                      '3.5 u/mg',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      color: Color(0xFF8F8F8F)),
                                ],
                              ),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Icon(
                                    FontAwesomeIcons.weight,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Weight',
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Text(
                                      '20 kg',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      color: Color(0xFF8F8F8F)),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ));
              }),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
