import 'package:basic_app/components/alert_dialog.dart';
import 'package:basic_app/components/login_card.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        //storing data in firebase
        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential)
            .then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("loggedInUsing", "Facebook");
          prefs.setBool('loggedInValue', true);
          print('facebook email stored in firebase $value');
          Navigator.pushNamedAndRemoveUntil(context, RoutesAvailable.homeRoute,
              (Route<dynamic> route) => false);
        }).catchError((onError) async {
          print("error on saving facebook email in firebase $onError");
          ShowDialogBox.dialogBoxes(
            context: context,
            textOption1: "OK",
            textOption2: "Cancel",
            alertTitle: "Error Logging using facebook",
            alertMessage:
                "An account already exists with the same email address but different sign-in credentials.\nPlease login with Google account instead.",
            onPressYesButton: () async {
              Navigator.pop(context);
              signInWithGoogle();
            },
            onPressNoButton: () {
              Navigator.pop(context);
            },
          );
        });
      } else {
        print('error result $result');
      }
    } catch (e) {
      print('Facebook login error $e');
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleSignIn?.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print("user credential is $credential");

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("loggedInUsing", "Google");
        prefs.setBool('loggedInValue', true);

        Navigator.pushNamedAndRemoveUntil(context, RoutesAvailable.homeRoute,
            (Route<dynamic> route) => false);

        print(
            "successfully stored value in firebase $value['user']['displayName']");
      }).catchError((onError) {
        print("error storing value in firebase $onError");
      });
    } on PlatformException catch (e) {
      print('PlatformException error while logging with google account $e');
    } catch (e) {
      print('error while logging with google account $e');
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
                  onPress: signInWithGoogle,
                )
              ],
            ),
          ),
        ));
  }
}
