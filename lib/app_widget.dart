import 'package:flutter/material.dart';
import 'package:marvel_heroes/heroes_list.dart';
import 'package:marvel_heroes/screen_login.dart';
import 'package:marvel_heroes/screen_register.dart';
import 'package:marvel_heroes/screen_resetpasswd.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/heroes': (context) => const HeroesList(),
        '/register': (context) => const Register(),
        '/resetpasswd': (context) => const resetPassWd()
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.red))),
    );
  }
}
