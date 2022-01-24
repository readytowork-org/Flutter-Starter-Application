import 'package:basic_app/Screens/authentication_screen.dart';
import 'package:basic_app/Screens/detail_screen.dart';
import 'package:basic_app/Screens/home_sreen.dart';
import 'package:basic_app/Screens/location.dart';
import 'package:basic_app/Screens/login_screen.dart';
import 'package:basic_app/Screens/registration_screen.dart';
import 'package:basic_app/Screens/search_screen.dart';
import 'package:basic_app/Screens/tv_shows.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:basic_app/widgets/themes.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Home(),
      // ondark mode this can be used along with darktheme
      // themeMode: ThemeMode.light,

      //to remove debugging banner in app screen
      debugShowCheckedModeBanner: false,

      theme: Themes.lightThemeValue(),
      //initial route to display, same as react-native
      initialRoute: RoutesAvailable.authenticationRoute,
      // darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        // route '/' means Home or main page, either put home: Home() or route '/'.
        RoutesAvailable.authenticationRoute: (context) =>
            const AuthenticationScreen(),
        RoutesAvailable.loginRoute: (context) => const LoginScreen(),
        RoutesAvailable.registrationRoute: (context) =>
            const RegistrationScreen(),

        RoutesAvailable.homeRoute: (context) => const Home(),
        RoutesAvailable.searchRoute: (context) => const SearchScreen(),
        RoutesAvailable.populatTvShowsRoute: (context) =>
            const PopularTvShows(),
        RoutesAvailable.detailsRoute: (context) => const DetailScreen(),
        RoutesAvailable.locationRoute: (context) => const LocationScreen(),
      },
    );
  }
}
