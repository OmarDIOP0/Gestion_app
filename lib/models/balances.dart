import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/screens/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/components/custom_text_form_field.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);


  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Depot Page',),
        centerTitle: true,
        backgroundColor: Colors.cyan,),
      body: Column(
        children: [
          CustomTextFormField(
            comment: 'Saisir le montant du depot',
            icon: Icons.monetization_on_rounded,
            controller: amountController,
          )
          ,
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                getBalance();
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

  TextEditingController amountController = TextEditingController();

  getBalance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map list = {
      'amount': amountController.text
    };
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/addBalance';
    var response = await http.post(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      if (jsonResponse != null) {
        print(response.statusCode);
      }
    }
    // return balances;
  }
}




class Balance{
  int amount;
  Balance(this.amount);
}