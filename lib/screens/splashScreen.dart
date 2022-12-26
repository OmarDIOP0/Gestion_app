import 'package:flutter/material.dart';
import 'package:gestion_app/screens/Welcome.dart';
import 'package:gestion_app/screens/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences sharedPreferences;
  @override

  void initState(){
    super.initState();
    checkLoginStatus();
  }

   checkLoginStatus() async{
        sharedPreferences = await SharedPreferences.getInstance();
        if(sharedPreferences.getString("token")==null){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false);
        }
    else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const WelcomeScreen()));
    }
  }
  Widget build(BuildContext context) {
    return Container();
  }
}
