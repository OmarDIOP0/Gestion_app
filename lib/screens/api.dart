import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async{
  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
  return sharedPreferences.getString('token')?? '';
}
Future<int> getUserId() async{
  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
  return sharedPreferences.getInt('user_id')?? 0;
}