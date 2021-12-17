import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/pages/restaurant_detail_page.dart';
import 'package:app/pages/restaurant_page.dart';
import 'package:app/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var initialRoute = LoginPage.route;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JAEN RESTAURANT GUIDE',
      theme: ThemeData(
          primaryColor: Colors.white,
          secondaryHeaderColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white),
      routes: {
        HomePage.route: (context) => const HomePage(),
        UserProfilePage.route: (context) => const UserProfilePage(),
        RestaurantPage.route: (context) => const RestaurantPage(),
        RestaurantDetailPage.route: (context) => RestaurantDetailPage(),
        RegisterPage.route: (context) => RegisterPage()
      },
      home: LoginPage(),
    );
  }
}
