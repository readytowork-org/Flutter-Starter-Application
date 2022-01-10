import 'package:basic_app/models/movies_model.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:basic_app/widgets/drawer.dart';
import 'package:basic_app/widgets/items_Widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(100, (index) => MovieModal().items[0]);
    // var name = "Pratik Adhikari";
    // var currentDays = 30;
    return Scaffold(
      appBar: AppBar(
        // these all styling in appbar can be done from main.dart using ThemeData

        // backgroundColor: Colors.white,
        // elevation: 0,
        // iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Popular Movies",
          // style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RoutesAvailable.searchRoute),
            icon: const Icon(Icons.search),
            padding: const EdgeInsets.only(right: 15),
          )
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: dummyList.length,
          itemBuilder: (context, index) {
            return ItemWidget(item: dummyList[index]);
          }),
      // Center(
      //   child: Container(
      //       child: Text(
      //           "Hello, Welcome $name. \nYou will master flutter in $currentDays days")),
      // ),
      drawer: DrawerList(),
    );
  }
}
