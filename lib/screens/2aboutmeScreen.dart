import 'package:flutter/material.dart';
import 'package:pet_user_app/models/api_utils.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/2Bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutmeScreen extends BaseRoute {
  AboutmeScreen({a, o}) : super(a: a, o: o, r: 'AboutmeScreen');
  @override
  _AboutmeScreenState createState() => _AboutmeScreenState();
}

class _AboutmeScreenState extends BaseRouteState {
  final desc = TextEditingController();
  final service = TextEditingController();
  final abouPet = TextEditingController();
  final price = TextEditingController();

  var workerId;
  ApiUtils _apiUtils = ApiUtils();
  @override
  void initState() {
    super.initState();

    getWorkerId();
  }

  void getWorkerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    workerId = prefs.getInt('workerId');
    print(workerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("About Me"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    //margin: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Introduce yourself and why you enjoy being with pets',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: TextFormField(
                                    controller: desc,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "e.g. i'm a pet lover and I  love pets as they are absolutely adorable.  ",
                                    ),
                                    maxLines: 5,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'How does your service stand out?',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: TextFormField(
                                    controller: abouPet,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Tell potential customer why they should choose you above others.",
                                    ),
                                    maxLines: 5,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'What do you want to know about pets?',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: TextFormField(
                                    controller: service,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Tell potential customer what kind of pet you want to handle with. ",
                                    ),
                                    maxLines: 5,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'How much does your service cost?',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  child: TextFormField(
                                    controller: price,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "Describe your best prices.",
                                    ),
                                    maxLines: 5,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                //main column
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            // color: Colors.red,
            height: 45,
            padding: const EdgeInsets.only(left: 15, right: 15),
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                onPressed: () {
                  var about = {
                    "id": workerId,
                    "description": desc.text,
                    "aboutPet": abouPet.text,
                    "services": service.text,
                    "price": price.text
                  };
                  print(about);
                  print(about["id"]);

                  _apiUtils.aboutWorker(about);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Bottomnavigationbar(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
                child: Text(
                  "Next",
                ))));
  }
}
