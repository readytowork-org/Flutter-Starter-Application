import 'dart:convert';

import 'package:basic_app/models/movies_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic> detailsData = {};
  @override
  void initState() {
    super.initState();
    encodeData();
  }

  encodeData() async {
    // print(detailsData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringValue = prefs.getString('detailsList');
    Map<String, dynamic> mapValue = jsonDecode(stringValue!);

    print('the value is ${mapValue['poster_path']}');

    // List<Results> list = List.from(mapValue).map<Results>((e) {
    //   print('the value is $e');
    //   return Results.fromJson(e);
    // }).toList();
    detailsData = mapValue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // these all styling in appbar can be done from main.dart using ThemeData

        // backgroundColor: Colors.white,
        // elevation: 0,
        // iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Movie Details',
          // style: TextStyle(color: Colors.black),
        ),
      ),
      body: detailsData.isEmpty
          ? const Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  detailsData['poster_path'] == null
                      ? Hero(
                          tag: 'assets/images/imagenotfound.png',
                          child: Image.asset(
                            "assets/images/imagenotfound.png",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 500,
                          ),
                        )
                      : Hero(
                          tag: detailsData['poster_path'],
                          child: Image.network(
                            detailsData['poster_path'],
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 500,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      detailsData['original_title'] != ""
                          ? detailsData['original_title']
                          : detailsData['name'],
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      detailsData['overview'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
