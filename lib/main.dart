import 'package:flutter/material.dart';
import 'package:gestion_app/models/item_categories.dart';
import 'package:gestion_app/screens/Loading.dart';
import 'package:gestion_app/screens/Welcome.dart';
import 'package:gestion_app/screens/splashScreen.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion_App',
     // home: Loading(),
      home:SplashScreen(),
    );
  }
}





