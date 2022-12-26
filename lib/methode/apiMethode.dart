import 'dart:convert';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_app/models/item_categories.dart';
import 'package:gestion_app/models/item_units.dart';
import 'package:gestion_app/models/items.dart';
import 'package:gestion_app/models/lenders.dart';
import 'package:gestion_app/models/payment_methods.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/api.dart';


Future viewBalance() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/viewBalance';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonResponse;
  if (response.statusCode == 200) {
     jsonResponse = jsonDecode(response.body);

  }
  return jsonResponse['montant'];
}

Future getBudget() async {
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getBudget';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
  }
  return jsonData['budget'];
}
///
Future getDeposit() async {
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getDeposit';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
  }
  return jsonData['depot'];
}
///// GETLENDER///
Future getLender() async {
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getLenders';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
     jsonData = jsonDecode(response.body);
  }
  return jsonData['lenders'];
}
/////ITEMCATEGORY////
Future getItemCategory() async {
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getItemCategory';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
     jsonData = jsonDecode(response.body);
  }
  return jsonData['categories'];
}
//////
Future getProfile() async {
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/profile';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
  }
  return jsonData['user'];
}
Future getEmail() async {
  String token = await getToken();
  var url = 'http://110.7.150.48:8000/api/profile';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
  }
  return jsonData['email'];
}
///
Future getItem() async {
  List<Items> listItems = [];
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getItems';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
     jsonData = jsonDecode(response.body);
  }
  return jsonData['items'];
}
////////////
Future getUnits() async {
  List<ItemUnits> listUnits = [];
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getItemUnits';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
     jsonData = jsonDecode(response.body);
  }
  return jsonData['units'];
}
//////////////////
Future getPaymentMethod() async {
  List<PaymentMethods> listPayment = [];
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getPaymentMethod';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
  }
  return jsonData['payment'];
}
////
Future getExpense() async {
  String token = await getToken();
  var url = 'http://10.7.150.48:8000/api/getExpense';
  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  var jsonData;
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
  }
  return jsonData['expense'];
}

