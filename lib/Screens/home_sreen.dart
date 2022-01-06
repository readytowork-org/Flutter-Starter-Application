import 'package:basic_app/utilities/Drawer.dart';
import "package:flutter/material.dart";

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = "Pratik Adhikari";
    var currentDays = 30;
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Center(
        child: Container(
            child: Text(
                "Hello, Welcome $name. \nYou will master flutter in $currentDays days")),
      ),
      drawer: DrawerList(),
    );
  }
}
