import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNzhmYTAzYjQ2YjYyZDcyMDVmNzA3ODc1NWVlZjc0NSIsInN1YiI6IjYxZDcwOWI1YmIyNjAyMDA1YjljMGU1NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.R8CYVLUkqVreDKEyVmfw084UZ7Ftov_XSm6CxmBFJzA';

  popularMovies() async {
    final response = await http.get(Uri.https('api.themoviedb.org',
        '/3/movie/popular?api_key=278fa03b46b62d7205f7078755eef745&language=en-US&page=1'));
    // headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    // });
    print('call garepaxi ko response $response');
    // .then((value) => print('value $value'))
    // .catchError((onError) => print('onError $onError'));
  }

  @override
  void initState() {
    super.initState();
    print("called on statefulwidget");
    popularMovies();
    // futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
