import 'package:basic_app/components/button.dart';
import 'package:basic_app/components/text_field.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  DateTime dateOfBirth = DateTime.now();

  bool showPassword = false;
  bool showConfirmPassword = false;

  bool setLoading = false;

  final _formKey = GlobalKey<FormState>();

  onRegisterButtonClicked() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        setLoading = true;
      });

      try {
        User? userDetails = FirebaseAuth.instance.currentUser;
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailAddress, password: password)
            .then((value) => FirebaseFirestore.instance
                    .collection("User Details")
                    .doc(userDetails?.uid)
                    .set({
                  "First Name": firstName,
                  "Last Name": lastName,
                  "User Name": userName,
                  "Password": password,
                  "Email Address": emailAddress,
                  "Address": address,
                  "Date of Birth": dateOfBirth,
                }).then((value) {
                  setState(() {
                    setLoading = false;
                  });
                  print("successfully registered");
                }).onError((error, stackTrace) {
                  setState(() {
                    setLoading = false;
                  });
                  print('Error occurred on storing data $error');
                }));
      } catch (e) {
        setState(() {
          setLoading = false;
        });
        print("Error occurred while seting firebase $e");
      }
    }
  }

  onDatePickerTapped() async {
    showDatePicker(
      // initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      print(
          'picked date is  ${pickedDate.year}/${pickedDate.month}/${pickedDate.day}');
      setState(() {
        //for rebuilding the ui
        dateOfBirth = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text(
            "Registration",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          )),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldComponent(
                          onChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                          labelText: "First Name",
                          hintText: "Enter First Name",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                          onChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                          labelText: "Last Name",
                          hintText: "Enter Last Name",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          labelText: "Username",
                          hintText: "Enter Username",
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                          obscureText: !showConfirmPassword,
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {});
                          },
                          labelText: "Confirm Password",
                          hintText: "Enter your password again",
                          suffixIcon: IconButton(
                            icon: Icon(
                              !showConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              showConfirmPassword = !showConfirmPassword;
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                            onChanged: (value) {
                              setState(() {
                                emailAddress = value;
                              });
                            },
                            labelText: "Email Address",
                            hintText: "Enter your email address"),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                            labelText: "Address",
                            hintText: "Enter your address"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                      child: Text(
                        "Date of Birth: ${dateOfBirth.year}-${dateOfBirth.month}-${dateOfBirth.day}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: onDatePickerTapped),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonComponent(
                    onTap: onRegisterButtonClicked,
                    buttonColor: Colors.red,
                    loading: setLoading,
                    buttonText: "Register",
                    fontColor: Colors.white,
                    fontSize: 18,
                    height: 40,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
