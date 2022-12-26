import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/screens/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../methode/apiMethode.dart';
import '../screens/api.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Depot Page',),
        centerTitle: true,
        backgroundColor: Colors.cyan,),
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
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Saisir le montant du depot',
                      icon: Icon(Icons.monetization_on_rounded))),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                addDeposit(amountController.text);
                amountController.clear();
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Welcome()));
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(
                      Colors.cyan),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                      ))),
              child: const Text('Valider', style:
              TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
  addDeposit(String amount) async {
    Map list = {'amount': amount};
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/addDeposit';
    var response = await http.post(Uri.parse(url), body: list, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successful add Deposits'),
            backgroundColor: Colors.green,
          ));
    }
  }

 }




class Deposits{
  int amount;

  Deposits(this.amount);
}