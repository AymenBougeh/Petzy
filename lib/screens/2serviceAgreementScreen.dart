import 'package:flutter/material.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/2serviceListScreen.dart';

class ServiceAgreementScreen extends BaseRoute {
  ServiceAgreementScreen({a, o})
      : super(a: a, o: o, r: 'ServiceAgreementScreen');
  @override
  _ServiceAgreementScreenState createState() => _ServiceAgreementScreenState();
}

class _ServiceAgreementScreenState extends BaseRouteState {
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("agreement"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "terms and conditon",
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                ),
                Container(
                  // padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Service Standards: You agree to provide professional and reliable pet boarding or dog walking services, ensuring the safety and well-being of the pets under your care.',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Liability: You understand and accept responsibility for any loss, injury, or damage that may occur during the provision of services.',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Amendments: We reserve the right to update or modify these terms and conditions, with notice of any material changes.',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    agree = !agree;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value;
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          "i have read and accept terms and conditions",
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      )
                    ],
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: agree
            ? Container(
                // color: Colors.red,
                height: 45,
                padding: const EdgeInsets.only(left: 15, right: 15),
                margin: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: agree ? _doSomething : null,
                    child: Text(
                      "Next",
                    )))
            : const SizedBox(),
      ),
    );
  }

  void _doSomething() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ServiceListScreen()),
    );
  }
}
