import 'package:basic_app/Screens/home_sreen.dart';
import 'package:basic_app/Screens/login_screen.dart';
import 'package:basic_app/utilities/routes.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
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
      // debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: GoogleFonts.lato().fontFamily,
        // primaryTextTheme: GoogleFonts.latoTextTheme()
      ),
      //initial route to display, same as react-native
      initialRoute: RoutesAvailable.homeRoute,
      // darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        // route '/' means Home or main page, either put home: Home() or route '/'
        RoutesAvailable.loginRoute: (context) => LoginScreen(),
        RoutesAvailable.homeRoute: (context) => Home(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
