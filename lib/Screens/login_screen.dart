import 'package:basic_app/components/button.dart';
import 'package:basic_app/components/text_field.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailAddress = "";
  String password = "";

  bool showPassword = false;
  bool setLoading = false;
  bool enableBiometricsValue = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    datafromHiveBox();
  }

  Future<void> datafromHiveBox() async {
    var box = await Hive.openBox('mainBox');
    setState(() {
      enableBiometricsValue = box.get('biometricsValue') ?? false;
    });
  }

  onTapLoginButton() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        setLoading = true;
      });
      try {
        // User? userDetails = FirebaseAuth.instance.currentUser;
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emailAddress, password: password)
            .then((signedInUser) async {
          setState(() {
            setLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Successfully Logged In",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('loggedInValue', true);

          Navigator.pushNamedAndRemoveUntil(context, RoutesAvailable.homeRoute,
              (Route<dynamic> route) => false);
        });
        //.catchError((onError) {
        //     setState(() {
        //       setLoading = false;
        //     });
        //     print("Error occurred while authenticating $onError");
        //   });
        // } on PlatformException catch (e) {
        //   setState(() {
        //     setLoading = false;
        //   });
        //   print('platform exception while signing with email and password $e');
      } catch (e) {
        setState(() {
          setLoading = false;
        });
        Fluttertoast.showToast(
            msg: "$e",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Error occurred while logging $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/login_image.jpg',
                      fit: BoxFit.contain,
                      height: 250,
                      // width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFieldComponent(
                            onChanged: (value) {
                              setState(() {
                                emailAddress = value;
                              });
                            },
                            labelText: 'Email Address',
                            hintText: 'Enter Email Address',
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.person_fill),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldComponent(
                            obscureText: !showPassword,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            labelText: "Password",
                            hintText: "Enter Password",
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.lock_shield,
                                color: Colors.red,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                showPassword = !showPassword;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ButtonComponent(
                      loading: setLoading,
                      onTap: onTapLoginButton,
                      height: 40,
                      buttonColor: Colors.red,
                      buttonText: "Login",
                      fontSize: 18,
                      fontColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    enableBiometricsValue
                        ? InkWell(
                            onTap: () async {
                              bool isBiometricsSupported =
                                  await LocalAuthentication()
                                      .canCheckBiometrics;
                              print(isBiometricsSupported);
                              try {
                                var isAuthenticated =
                                    await LocalAuthentication().authenticate(
                                        localizedReason:
                                            'Authenticate with your biometrics',
                                        useErrorDialogs: true,
                                        stickyAuth: true,
                                        biometricOnly: true);
                                if (isAuthenticated) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('loggedInValue', true);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RoutesAvailable.homeRoute,
                                      (Route<dynamic> route) => false);
                                }
                              } on PlatformException catch (e) {
                                // display this error if you want
                                print(e.message);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.fingerprint,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Tap to Login with Biometrics",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Forgot password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonComponent(
                      onTap: () => Navigator.pushNamed(
                          context, RoutesAvailable.registrationRoute),
                      height: 40,
                      buttonColor: Colors.deepPurple,
                      buttonText: "Register",
                      fontSize: 18,
                      fontColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
