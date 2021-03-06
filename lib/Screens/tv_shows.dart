import 'dart:convert';

import 'package:basic_app/components/list_items.dart';
import 'package:basic_app/models/movies_model.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PopularTvShows extends StatefulWidget {
  const PopularTvShows({Key? key}) : super(key: key);

  @override
  State<PopularTvShows> createState() => _PopularTvShowsState();
}

class _PopularTvShowsState extends State<PopularTvShows> {
  List<Results> data = [];
  bool getMoreData = false;
  int pageValue = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    popularTVShows();
    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        popularTVShows();
      }
    });
  }

  //dispose method use to release the memory allocated to variables when state object is removed
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> popularTVShows() async {
    // Fetching data from local json file
    // 1. Load the string using rootBundle.loadString(source)
    // 2. decode the loaded file using jsonDecode(source)
    // 3. select the required data and load into the list

    // final tvshowslist =
    //     await rootBundle.loadString('assets/apidata/popular_tvShows.json');
    // final decodedTvShows = jsonDecode(tvshowslist)['results'];
    // print(decodedTvShows);

    // List<Results> list = List.from(decodedTvShows)
    //     .map<Results>((e) => Results.fromJson(e))
    //     .toList();
    // print('the list is $list');
    // setState(() {
    //   data = list;
    // });

    getMoreData = true;

    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?api_key=278fa03b46b62d7205f7078755eef745&language=en-US&page=$pageValue'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Accept': 'application/json',
          // 'Authorization':
          //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNzhmYTAzYjQ2YjYyZDcyMDVmNzA3ODc1NWVlZjc0NSIsInN1YiI6IjYxZDcwOWI1YmIyNjAyMDA1YjljMGU1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.R8CYVLUkqVreDKEyVmfw084UZ7Ftov_XSm6CxmBFJzA',
        });
    // print('call garepaxi ko response $response');
    if (response.statusCode == 200) {
      try {
        final decodedPopularTvShows = jsonDecode(response.body);

        var decodedPopularTvShowsResults = decodedPopularTvShows['results'];
        print(decodedPopularTvShowsResults);

        List<Results> list =
            List.from(decodedPopularTvShowsResults).map<Results>((e) {
          e['poster_path'] = e['poster_path'] != ""
              ? "https://image.tmdb.org/t/p/w500" + e['poster_path']
              : "";
          return Results.fromJson(e);
        }).toList();
        data.addAll(list);
        setState(() {});
        pageValue++;
        getMoreData = false;
      } catch (e) {
        print("Network error $e");
      }
    }
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
              child: data.isEmpty
                  ? const Center(child: CupertinoActivityIndicator())
                  : Scrollbar(
                      thickness: 4,
                      hoverThickness: 7,
                      interactive: true,
                      isAlwaysShown: true,
                      controller: _scrollController,
                      child: ListView.builder(
                          itemCount: data.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return ListItems(
                                onPress: () async {
                                  final String encodedString =
                                      json.encode(data[index]);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('detailsList', encodedString);
                                  Navigator.pushNamed(
                                      context, RoutesAvailable.detailsRoute);
                                },
                                imagePath: data[index].posterPath.toString(),
                                movieName: data[index].originalName.toString(),
                                movieDetails: data[index].overview.toString(),
                                movieRating: data[index].voteAverage.toString(),
                                movieLanguage: data[index]
                                    .originalLanguage
                                    .toString()
                                    .toUpperCase());
                          }),
                    ),
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
