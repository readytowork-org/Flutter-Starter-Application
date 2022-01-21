import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Select one of the options",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            Card(
              elevation: 5,
              child: InkWell(
                onTap: () {},
                splashColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/email.png',
                    ),
                    title: const Text(
                      "Login using Gmail",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: InkWell(
                splashColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/facebook.jpg',
                    ),
                    title: const Text(
                      "Login using Facebook",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: InkWell(
                splashColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/gmail.jpg',
                    ),
                    title: const Text(
                      "Login using Google",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
