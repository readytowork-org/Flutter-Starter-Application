import 'dart:convert';
import 'package:basic_app/models/movies_model.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:basic_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MoviesModal> data = [];
  String name = "";

  @override
  void initState() {
    super.initState();
    print("called on statefulwidget st homescreen");
    popularMovies();
    // getAsyncStorageValue();
    // futureAlbum = fetchAlbum();
  }

  // Future<void> getAsyncStorageValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // String finalName = prefs.getString('counter');
  //   setState(() {
  //     print(prefs.getString('counter')!);
  //   });
  // }

  Future<void> popularMovies() async {
    final popularMoviesList =
        await rootBundle.loadString("assets/apidata/popular_movies.json");
    final decodedPopularMovies = jsonDecode(popularMoviesList);

    var decodedPopularMoviesResults = decodedPopularMovies['results'];
    print(decodedPopularMoviesResults);

    List<MoviesModal> list = List.from(decodedPopularMoviesResults)
        .map<MoviesModal>((e) => MoviesModal.fromJson(e))
        .toList();

    setState(() {
      data = list;
    });

    // final response = await http.get(Uri.https('api.themoviedb.org',
    //     '/3/movie/popular?api_key=278fa03b46b62d7205f7078755eef745&language=en-US&page=1'));
    // headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    // });
    // print('call garepaxi ko response $response');
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
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
                child: const Text("Popular",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Flexible(
                  child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () => print("Container pressed"),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.network(
                                        data[index].posterPath.toString(),
                                        height: 150,
                                        width: 130,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].originalTitle ?? "",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          // textDirection: TextDirection.rtl,
                                          // textAlign: TextAlign.left
                                          // style: TextStyle
                                        ),
                                        Text(
                                          data[index].overview ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          // textAlign: TextAlign.left
                                          // style: TextStyle
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // const SizedBox(height: 20),
                                            Text(
                                              "Rating:  " +
                                                  data[index]
                                                      .voteAverage
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.deepOrange,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data[index]
                                              .originalLanguage
                                              .toString()
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ))
            ],
          ),
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
