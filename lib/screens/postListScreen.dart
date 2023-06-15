import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/entites/posts.dart';
import 'package:pet_user_app/screens/addPostScreen.dart';
import 'package:pet_user_app/screens/commentScreen.dart';

class PostListScreen extends BaseRoute {
  // PostListScreen() : super();
  PostListScreen({a, o}) : super(a: a, o: o, r: 'PostListScreen');
  @override
  _PostListScreenState createState() => new _PostListScreenState();
}

class _PostListScreenState extends BaseRouteState {
  _PostListScreenState() : super();
  ApiUtils _apiUtils = ApiUtils();
  List<Posts> posts = [];

  @override
  void initState() {
    super.initState();
    _apiUtils.getAllPosts().then((value) => setState(() => posts = value));
    print(posts);
    for (var i in posts) {
      print(i.dateCreated);
      print(i.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Moments',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPostScreen(
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Text(
                  'Add',
                  style: Theme.of(context).primaryTextTheme.overline,
                ),
              ),
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
                child: Column(children: [
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
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
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
                                    left: 10, right: 10, top: 9),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          radius: 25,
                                          child: CircleAvatar(
                                            radius: 24,
                                            child: Icon(FontAwesomeIcons.user),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            posts[index].title,
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
                                padding: EdgeInsets.only(left: 15, top: 10),
                                child: Text(posts[index].content ?? ""),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                decoration: BoxDecoration(
                                    //  color: Colors.red,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            posts[index].image ?? ""))),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(FontAwesomeIcons.heart),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, top: 5),
                                                child: Text('0'),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CommentScreen(
                                                            a: widget.analytics,
                                                            o: widget.observer,
                                                          )));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.message),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, top: 5),
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
                    );
                  },
                ),
              ),
            ]))));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
