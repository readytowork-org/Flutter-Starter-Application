import 'dart:convert';

import 'package:basic_app/components/list_items.dart';
import 'package:basic_app/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopularTvShows extends StatefulWidget {
  const PopularTvShows({Key? key}) : super(key: key);

  @override
  State<PopularTvShows> createState() => _PopularTvShowsState();
}

class _PopularTvShowsState extends State<PopularTvShows> {
  List<Results> data = [];

  @override
  void initState() {
    super.initState();
    popularTVShows();
  }

  Future<void> popularTVShows() async {
    // Fetching data from local json file
    // 1. Load the string using rootBundle.loadString(source)
    // 2. decode the loaded file using jsonDecode(source)
    // 3. select the required data and load into the list

    final tvshowslist =
        await rootBundle.loadString('assets/apidata/popular_tvShows.json');
    final decodedTvShows = jsonDecode(tvshowslist)['results'];
    print(decodedTvShows);

    List<Results> list = List.from(decodedTvShows)
        .map<Results>((e) => Results.fromJson(e))
        .toList();
    print('the list is $list');
    setState(() {
      data = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TV Shows',
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
              child: const Text("Popular",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Flexible(
                child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListItems(
                        onPress: () {},
                        imagePath: data[index].posterPath.toString(),
                        movieName: data[index].originalName.toString(),
                        movieDetails: data[index].overview.toString(),
                        movieRating: data[index].voteAverage.toString(),
                        movieLanguage: data[index]
                            .originalLanguage
                            .toString()
                            .toUpperCase());
                  }),
            ))
          ],
        ),
      ),
      // RefreshIndicator(
      //   onRefresh: () async {
      //     setState(() {});
      //   },
      //   child: data.isEmpty
      //       ? const Center(child: CircularProgressIndicator())
      //       :
      //       // Using ListView
      //       //     ListView.builder(
      //       //         padding: const EdgeInsets.all(10),
      //       //         itemCount: data.length,
      //       //         itemBuilder: (context, index) {
      //       //           return ItemWidget(items: data[index]);
      //       //         }),
      //       // Using GridView
      //       GridView.builder(
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 2,
      //             mainAxisSpacing: 10,
      //             crossAxisSpacing: 20,
      //           ),
      //           itemCount: data.length,
      //           itemBuilder: (context, index) {
      //             return Container(
      //               decoration:
      //                   BoxDecoration(borderRadius: BorderRadius.circular(8)),
      //               // child: Container(
      //               //   padding: const EdgeInsets.symmetric(
      //               //       vertical: 10, horizontal: 10),
      //               // decoration: BoxDecoration(),
      //               child: Text((data[index].originalTitle.toString())),
      //             );
      //             // child: Image.network(data[index].posterPath.toString()));
      // }),
      // ),
      // Center(
      //   child: Container(
      //       child: Text(
      //           "Hello, Welcome $name. \nYou will master flutter in $currentDays days")),
      // ),
    );
  }
}
