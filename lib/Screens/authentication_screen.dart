import 'dart:convert';

import 'package:basic_app/components/login_card.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  Future<void> signInFB() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: [
          'public_profile',
          'email',
        ],
      ); // by default we request the email and the public profile
      // or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        // you are logged

        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        //storing data in firebase
        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        // print('success result $accessToken');
      } else {
        print('error result $result');
      }
    } catch (e) {
      print('Facebook login error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Select one of the options",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  ),
                ),
                LoginCard(
                  onPress: () {
                    print('object sssdsdsd');
                    Navigator.pushNamed(context, RoutesAvailable.loginRoute);
                  },
                  image: 'assets/images/email.png',
                  textValue: "Login using Email",
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginCard(
                    onPress: signInFB,
                    image: 'assets/images/facebook.jpg',
                    textValue: "Login using Facebook"),
                const SizedBox(
                  height: 20,
                ),
                LoginCard(
                  image: 'assets/images/gmail.jpg',
                  textValue: "Login using Gmail",
                  onPress: () {
                    print('object');
                    Navigator.pushNamed(context, RoutesAvailable.loginRoute);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
