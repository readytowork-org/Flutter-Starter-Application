import 'package:basic_app/utilities/routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  _onTap() async {
    if (_formKey.currentState!.validate()) {
      print('Button is pressed $changeButton ');
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, RoutesAvailable.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/login_image.jpg',
                fit: BoxFit.contain,
                height: 250,
                // width: 200,
              ),
              Container(
                // padding: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 8),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: Text(
                  'Welcome $name',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'User Name', hintText: 'Enter User Name'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password', hintText: 'Enter Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "Password length must be at least six characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    // ElevatedButton(
                    //     // In general
                    //     // style: ElevatedButton.styleFrom(
                    //     //   primary: Colors.red, // background
                    //     //   onPrimary: Colors.yellow, // foreground
                    //     // ),
                    //     style: ButtonStyle(
                    //       minimumSize:
                    //           MaterialStateProperty.all<Size>(const Size(150, 50)),
                    //       // padding: MaterialStateProperty.all<EdgeInsets>(
                    //       //     EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
                    //       //   backgroundColor:
                    //       //       MaterialStateProperty.all<Color>(Colors.red),
                    //     ),
                    //     onPressed: () {
                    //       print('Button is pressed');
                    //       Navigator.pushNamed(context, RoutesAvailable.homeRoute);
                    //     },
                    //     child: const Text(
                    //       "Login",
                    //       style:
                    //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    //     ))

                    //          OR

                    Material(
                      borderRadius:
                          BorderRadius.circular(changeButton ? 25 : 5),
                      color: Colors.red,
                      child: InkWell(
                        // splashColor will not work perfectly because it needs to be wrapped in material
                        // so we will wrap Inkwell using material in this case
                        splashColor: Colors.white24,
                        onTap: () => _onTap(),
                        child: AnimatedContainer(
                            height: 50,
                            width: changeButton ? 50 : 150,
                            // color: Colors.red, /*either here or inside decoration*/
                            alignment: Alignment.center,

                            // commenting this because borderRadius should be provided to main cwidget i.e. material
                            // decoration: BoxDecoration(
                            //     color: Colors.red,
                            //     borderRadius:
                            //         BorderRadius.circular(changeButton ? 25 : 5)),
                            duration: const Duration(seconds: 1),
                            child: changeButton
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : const Text('Login',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
