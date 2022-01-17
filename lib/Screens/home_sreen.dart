import 'dart:convert';

import 'package:basic_app/components/list_items.dart';
import 'package:basic_app/models/movies_model.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:basic_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  List<Results> data = [];
  String name = "";
  int pageValue = 1;
  bool getMoreData = false;
  bool moreDataAvailable = false;

  @override
  void initState() {
    super.initState();
    print("called on statefulwidget st homescreen");
    popularMovies();
    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        popularMovies();
      }
    });
    // getAsyncStorageValue();
    // futureAlbum = fetchAlbum();
  }

  //dispose method use to release the memory allocated to variables when state object is removed
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // Future<void> getAsyncStorageValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // String finalName = prefs.getString('counter');
  //   setState(() {
  //     print(prefs.getString('counter')!);
  //   });
  // }

  Future<void> popularMovies() async {
    // Fetching data from local json file
    // 1. Load the string using rootBundle.loadString(source)
    // 2. decode the loaded file using jsonDecode(source)
    // 3. select the required data and load into the list

    // final popularMoviesList =
    //     await rootBundle.loadString("assets/apidata/popular_movies.json");
    // final decodedPopularMovies = jsonDecode(popularMoviesList);

    // var decodedPopularMoviesResults = decodedPopularMovies['results'];
    // print(decodedPopularMoviesResults);

    // List<Results> list = List.from(decodedPopularMoviesResults)
    //     .map<Results>((e) => Results.fromJson(e))
    //     .toList();

    // setState(() {
    //   data = list;
    // });

    print('the page value is $pageValue');

    getMoreData = true;

    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=278fa03b46b62d7205f7078755eef745&language=en-US&page=$pageValue'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Accept': 'application/json',
          // 'Authorization':
          //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNzhmYTAzYjQ2YjYyZDcyMDVmNzA3ODc1NWVlZjc0NSIsInN1YiI6IjYxZDcwOWI1YmIyNjAyMDA1YjljMGU1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.R8CYVLUkqVreDKEyVmfw084UZ7Ftov_XSm6CxmBFJzA',
        });
    // print('call garepaxi ko response $response');
    if (response.statusCode == 200) {
      final decodedPopularMovies = jsonDecode(response.body);

      var decodedPopularMoviesResults = decodedPopularMovies['results'];
      print(decodedPopularMoviesResults);

      List<Results> list =
          List.from(decodedPopularMoviesResults).map<Results>((e) {
        e['poster_path'] = e['poster_path'] != ""
            ? "https://image.tmdb.org/t/p/w500" + e['poster_path']
            : "";
        return Results.fromJson(e);
      }).toList();
      data.addAll(list);
      setState(() {});
      pageValue++;
      getMoreData = false;
    }
    // .then((value) => print('value $value'))
    // .catchError((onError) => print('onError $onError'));
  }

  @override
  Widget build(BuildContext context) {
    // final dummyList = List.generate(100, (index) => MovieModal().results);
    // var name = "Pratik Adhikari";
    // var currentDays = 30;
    return Scaffold(
      appBar: AppBar(
        // these all styling in appbar can be done from main.dart using ThemeData

        // backgroundColor: Colors.white,
        // elevation: 0,
        // iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Movies',
          // style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              // Navigator.pushNamed(context, RoutesAvailable.searchRoute),
            },
            icon: const Icon(Icons.search),
            padding: const EdgeInsets.only(right: 15),
          )
        ],
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
                          controller: _scrollController,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            // if (getMoreData == true) {
                            //   print('$index ${data.length}');
                            //   return const Padding(
                            //     padding: EdgeInsets.only(bottom: 20),
                            //     child:
                            //         Center(child: CupertinoActivityIndicator()),
                            //   );
                            // }
                            return ListItems(
                                onPress: () async {
                                  print('Container pressed  ${data[index]}');

                                  final String encodedString =
                                      json.encode(data[index]);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('detailsList', encodedString);
                                  Navigator.pushNamed(
                                      context, RoutesAvailable.detailsRoute);
                                },
                                imagePath: data[index].posterPath.toString(),
                                movieName: data[index].originalTitle.toString(),
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
      // child: data.isEmpty
      //     ? const Center(child: CircularProgressIndicator())
      //     :
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
      drawer: DrawerList(),
    );
  }
}

class MoviesHeader extends StatelessWidget {
  const MoviesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10, left: 25),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Text("Movies", style: TextStyle(fontSize: 32)),
        Text("Popular", style: TextStyle(fontSize: 20)),
      ]),
    );
  }
}
