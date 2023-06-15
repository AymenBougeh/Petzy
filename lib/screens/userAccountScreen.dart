import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

var fullname;
var imagePro;
File imageFile;
File _tImage;
String imagePath;
final name = TextEditingController();
final email = TextEditingController();
final image = TextEditingController();
var phone;
var connId;

class UserAccountScreen extends BaseRoute {
  // UserAccountScreen() : super();
  UserAccountScreen({a, o}) : super(a: a, o: o, r: 'UserAccountScreen');
  @override
  _UserAccountScreenState createState() => new _UserAccountScreenState();
}

class _UserAccountScreenState extends BaseRouteState {
  _UserAccountScreenState() : super();
  ApiUtils _apiUtils = ApiUtils();
  final phonec = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool loading = true, error = false;
  final ImagePicker _picker = ImagePicker();
  PickedFile _image;

  File image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    _image = PickedFile(image.path);
    setState(() => this.image = imageTemp);
    print(_image);
    print(imageTemp);
    print("sssssssssssssssss");
    print(image);
  }

  getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        error = false;
        loading = true;
        fullname = prefs.getString("name");
        imagePro = prefs.getString("image");
        connId = prefs.getInt("connId");

        imagePath = imagePro == null
            ? imagePro
            : 'https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg';
      });
    } catch (e) {
      setState(() {
        error = true;
        loading = false;
      });
    }
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
          'Account Settings',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: loading
              ? Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.height * 0.19,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    width: MediaQuery.of(context).size.height *
                                        0.17,
                                    alignment: Alignment.center,
                                    child: image == null
                                        ? Image.asset(
                                            "assets/alertdialogimage.png")
                                        : Image.file(image),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              Positioned(
                                  top: 86,
                                  right: 15,
                                  child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        _showCupertinoModalSheet();
                                        print("ssss");
                                      },
                                      icon: Container(
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(34)),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ))))
                            ],
                          ),
                        ),
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          fullname,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                      )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: Text(
                              'Name',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )),
                      Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: TextFormField(
                            controller: name,
                            // controller: _cForgotEmail,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              // prefixIcon: Icon(Icons.mail),

                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: Text(
                              'Email',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )),
                      Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: TextFormField(
                            controller: email,
                            // controller: _cForgotEmail,
                            decoration: InputDecoration(
                              hintText: 'Email address',
                              // prefixIcon: Icon(Icons.mail),

                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: Text(
                              'Mobile Number',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )),
                      Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: TextFormField(
                            controller: phonec,
                            // controller: _cForgotEmail,
                            decoration: InputDecoration(
                              hintText: 'Mobile number',
                              // prefixIcon: Icon(Icons.mail),

                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                            ),
                            onChanged: (v) {
                              phone = v;
                            },
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: Text(
                              'Change Password',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )),
                      Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: Text(
                              'Confirm Password',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )),
                      Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: EdgeInsets.only(top: 5, left: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator())),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
            // color: Colors.red,
            height: 45,
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                onPressed: () {
                  var user = {
                    "id": connId,
                    "name": name.text,
                    "email": email.text,
                    "phone": phonec.text,
                  };

                  if (user.isNotEmpty) {
                    _apiUtils.updateUser(user);
                  }
                  print(user);
                  print(user["id"]);
                },
                child: Text(
                  "Save",
                ))),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
  _showCupertinoModalSheet() {
    try {
      FocusScope.of(context).unfocus();
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Actions'),
          actions: [
            CupertinoActionSheetAction(
              child: Text('Take Picture',
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                print('Image Path : ${_tImage.path}');
                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Choose from gallery',
                  style: TextStyle(color: Color.fromRGBO(23, 29, 44, 1))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                //  _tImage = await br.selectImageFromGallery();
                pickImage();
                hideLoader();
                print('Image Path : ${_tImage.path}');
                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel', style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - addServicesScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }

  _removeCupertinoModalSheet() {
    try {
      FocusScope.of(context).unfocus();
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Actions'),
          actions: [
            CupertinoActionSheetAction(
              child: Text('Remove', style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                //  Navigator.pop(context);
                // showOnlyLoaderDialog();
                _tImage = null;
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Take Picture',
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                setState(() async {
                  Navigator.pop(context);
                  showOnlyLoaderDialog();
                  _tImage = await br.openCamera();
                  hideLoader();

                  print('Image Path : ${_tImage.path}');
                  print(_tImage.toString());
                });
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Choose from gallery',
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                setState(() async {
                  Navigator.pop(context);
                  showOnlyLoaderDialog();
                  // _tImage = await br.selectImageFromGallery();
                  pickImage();
                  hideLoader();
                  print('Image Path : ${_tImage.path}');
                  print("ssssssss");
                  print(_tImage.toString());
                });
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel', style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - addServicesScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }
}
