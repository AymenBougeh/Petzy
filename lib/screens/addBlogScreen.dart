import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';

class AddBlogScreen extends BaseRoute {
  AddBlogScreen({a, o}) : super(a: a, o: o, r: 'AddBlogScreen');
  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends BaseRouteState {
  File imageFile;
  File _tImage;
  String _category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Blog"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              child: Column(
                children: [
                  Card(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "title",
                        hintText: "title",
                      ),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Description",
                        hintText: "Description",
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Text(
                          "Add image",
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _showCupertinoModalSheet();
                          },
                          child: DottedBorder(
                            color: Theme.of(context)
                                .primaryColor, //color of dotted/dash line
                            strokeWidth: 1, //thickness of dash/dots
                            dashPattern: const [10, 6],
                            child: _tImage == null
                                ? GestureDetector(
                                    onTap: () {
                                      _showCupertinoModalSheet();
                                    },
                                    child: SizedBox(
                                      //inner container
                                      height: 250, //height of inner container
                                      width: double
                                          .infinity, //width to 100% match to parent container.
                                      child: Center(
                                          child: Text(
                                        "+",
                                        style: Theme.of(context)
                                            .inputDecorationTheme
                                            .labelStyle,
                                      )),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _removeCupertinoModalSheet();
                                    },
                                    child: SizedBox(
                                      height: 250,
                                      width: double.infinity,
                                      child: Image.file(
                                        _tImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
            height: 45,
            padding: const EdgeInsets.only(left: 15, right: 15),
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Bottomnavigationbar()),
                  // );
                },
                child: Text(
                  "Add",
                ))));
  }

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
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
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
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
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
}
