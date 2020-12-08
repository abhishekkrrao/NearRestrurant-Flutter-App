import 'package:eshop/src/pages/Home.dart';
import 'package:eshop/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/themes/theme.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      title: 'E-Commerce ',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,

        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => Home(),
      },
    );
  }
}
// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  bool isAuth = false;
  Future<bool> _getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("email= "+prefs.getString("email"));
    isAuth = (prefs.getString("email") != null ? true : false);
    await isAuth;
    return isAuth;
  }
  @override
  Widget build(BuildContext context) {
    _getValue().then((success) {
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
