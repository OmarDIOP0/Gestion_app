import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screens/api.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen.PaymentMethod({Key? key}) : super(key: key);
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  TextEditingController nameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:const Text('Methode de payement'),centerTitle: true,backgroundColor: Colors.cyan,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 25),
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  border:
                  Border.all(color: Colors.white),
                  borderRadius:
                  BorderRadius.circular(12)),
              child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'payement methode',
                      icon: Icon(Icons.monetization_on_sharp))),
            ),
          ),

          const SizedBox(height: 10,),

          ElevatedButton(
              onPressed: () {
                addPaymentMethod(nameController.text);
                nameController.clear();
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius:
                      BorderRadius.circular(18),))),
              child: const Text('Valider', style:
              TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );;
  }
  addPaymentMethod(String name_payment) async {
    Map data = {
      'name_payment': name_payment,
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/paymentMethod';
    var response = await http.post(Uri.parse(url),
        body: data, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successful add PaymentMethod'),
            backgroundColor: Colors.green,
          ));
    }
  }
}


class PaymentMethods{
  String name;
  PaymentMethods(this.name);
}