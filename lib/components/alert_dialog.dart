import 'package:flutter/material.dart';

class ShowDialogBox {
  // const DialogBoxes(
  //     {required this.alertTitle,
  //     required this.alertMessage,
  //     required this.onPressYesButton,
  //     required this.onPressNoButton});

  // final String alertTitle;
  // final String alertMessage;
  // final Function onPressYesButton;
  // final Function onPressNoButton;

  static Future dialogBoxes(
      BuildContext context,
      String alertTitle,
      String alertMessage,
      Function onPressYesButton,
      Function onPressNoButton) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(alertTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(alertMessage)],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  onPressYesButton();
                },
              ),
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  onPressYesButton();
                },
              ),
            ],
          );
        });
  }
}
