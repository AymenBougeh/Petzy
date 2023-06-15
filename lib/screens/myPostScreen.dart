import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/baseRoute.dart';
import 'package:pet_user_app/models/entites/posts.dart';
import 'package:shared_preferences/shared_preferences.dart';

var connId;
var userPosts = [];

class MyPostScreen extends BaseRoute {
  // MyPostScreen() : super();
  MyPostScreen({a, o}) : super(a: a, o: o, r: 'MyPostScreen');
  @override
  _MyPostScreenState createState() => new _MyPostScreenState();
}

class _MyPostScreenState extends BaseRouteState {
  _MyPostScreenState() : super();
  ApiUtils _apiUtils = ApiUtils();
  List<Posts> post;
  @override
  void initState() {
    super.initState();
    getconnId();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final post = await _apiUtils.getAllPosts();
    final filteredPosts = post.where((e) => e.postid == connId).toList();
    setState(() {
      userPosts = filteredPosts;
    });
  }

  void getconnId() async {
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
            'My Posts',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: userPosts.isEmpty
              ? Center(
                  child: Text(
                    'No moments yet',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: userPosts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                height: 365,
                                width: MediaQuery.of(context).size.width,
                                // color: Colors.red,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        radius: 25,
                                                        child: CircleAvatar(
                                                          radius: 24,
                                                          child: Icon(
                                                              FontAwesomeIcons
                                                                  .user),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        child: Text(
                                                          userPosts[index]
                                                              .title,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .headline1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child:
                                          Text(userPosts[index].content ?? ""),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: MediaQuery.of(context).size.width,
                                      height: 220,
                                      decoration: BoxDecoration(
                                          //  color: Colors.red,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  userPosts[index].image ??
                                                      ""))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 5, right: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            width: 70,
                                            // color: Colors.red,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons.heart),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5, top: 5),
                                                      child: Text('5'),
                                                    )
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             CommentScreen(
                                                    //               a: widget.analytics,
                                                    //               o: widget.observer,
                                                    //             )));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.message),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                top: 5),
                                                        child: Text('0'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(FontAwesomeIcons.share),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, top: 0, right: 10),
                                                child: Text('Share'),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                height: 365,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                radius: 25,
                                                child: CircleAvatar(
                                                  radius: 24,
                                                  child: Icon(
                                                      FontAwesomeIcons.user),
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                child: Text(
                                                  'Shivam Patel',
                                                  style: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline1,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text('This is my favorite'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: MediaQuery.of(context).size.width,
                                      height: 220,
                                      decoration: BoxDecoration(
                                          //  color: Colors.red,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/catimage3.png'))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 5, right: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            width: 70,
                                            // color: Colors.red,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons.heart),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5, top: 5),
                                                      child: Text('5'),
                                                    )
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             CommentScreen(
                                                    //               a: widget.analytics,
                                                    //               o: widget.observer,
                                                    //             )));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.message),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                top: 5),
                                                        child: Text('0'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(FontAwesomeIcons.share),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, top: 0, right: 10),
                                                child: Text('Share'),
                                              )
                                            ],
                                          )
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
                    );
                  }),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
