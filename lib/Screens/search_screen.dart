import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _stringValue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
          child: TextField(
              onChanged: (value) {
                setState(() {
                  _stringValue = value;
                });
              },
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    if (_stringValue == "") {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _stringValue = "";
                      });
                    }
                  },
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () async {
                    // try {
                    //   searchedAddress = await locationFromAddress(_stringValue);
                    //   print("the searched address is $searchedAddress[0]");
                    //   addMarkers(searchedAddress[0]);
                    // } catch (e) {
                    //   print('error while fetching coordinates $e');
                    // }
                  },
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
                fillColor: Colors.grey[300],
                filled: true,
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                ),
              ))),
    );
  }
}
