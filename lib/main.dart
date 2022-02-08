import 'package:basic_app/Screens/biometrics_screen.dart';
import "package:flutter/material.dart";
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
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // Dio().interceptors.add(
  //     DioCacheManager(CacheConfig(baseUrl: "https://api.themoviedb.org/3/"))
  //         .interceptor);
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('loggedInValue') ?? false;
  print('logged in value is ${prefs.getBool('loggedInValue') ?? false}');
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool? isLoggedIn;
  const MyApp({
    Key? key,
    this.isLoggedIn,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Home(),
      // ondark mode this can be used along with darktheme
      // themeMode: ThemeMode.light,

      //to remove debugging banner in app screen
      debugShowCheckedModeBanner: false,

      theme: Themes.lightThemeValue(),

      home:
          // const LocationScreen(),
          widget.isLoggedIn ?? false
              ? const Home()
              : const AuthenticationScreen(),

      routes: <String, WidgetBuilder>{
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
        RoutesAvailable.biometricsRoute: (context) => const BiometricsScreen(),
      },
    );
  }
}

class LoginRoutes extends StatelessWidget {
  const LoginRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        RoutesAvailable.authenticationRoute: (context) =>
            const AuthenticationScreen(),
        RoutesAvailable.loginRoute: (context) => const LoginScreen(),
        RoutesAvailable.registrationRoute: (context) =>
            const RegistrationScreen(),
      },
    );
  }
}

class HomeRoutes extends StatelessWidget {
  const HomeRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
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
