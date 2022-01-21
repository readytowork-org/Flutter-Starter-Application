import 'package:basic_app/utilities/routes.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String firstName = "";
  String lastName = "";
  String userName = "";
  String password = "";
  String confirmPassword = "";
  String emailAddress = "";
  String address = "";
  late DateTime dateOfBirth;

  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  _onTap() async {
    if (_formKey.currentState!.validate()) {
      print('Button is pressed $changeButton ');

      print({
        firstName,
        lastName,
        userName,
        password,
        confirmPassword,
        emailAddress,
        address,
        dateOfBirth
      });

      setState(() {
        changeButton = true;
      });

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('counter', firstName);

      await Future.delayed(const Duration(seconds: 1));

      await Navigator.pushNamed(context, RoutesAvailable.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  onDatePickerTapped() async {
    showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    ) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        dateOfBirth = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter First Name'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'Last Name', hintText: 'Enter Last Name'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          userName = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'User Name', hintText: 'Enter User Name'),
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else if (value.length < 6) {
                          return "Password length must be at least six characters";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'Password', hintText: 'Required'),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password', hintText: 'Required'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else if (value.length < 6) {
                          return "Password length must be at least six characters";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          emailAddress = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'Email', hintText: 'Enter Email Address'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'Address', hintText: 'Enter User Address'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                child: const Text('Add Date'), onPressed: onDatePickerTapped),
            const SizedBox(
              height: 30,
            ),
            Material(
              borderRadius: BorderRadius.circular(changeButton ? 25 : 5),
              color: Colors.red,
              child: InkWell(
                splashColor: Colors.white24,
                onTap: () => _onTap(),
                child: AnimatedContainer(
                    height: 50,
                    width: changeButton ? 50 : 150,
                    alignment: Alignment.center,
                    duration: const Duration(seconds: 1),
                    child: changeButton
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : const Text('Login',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
