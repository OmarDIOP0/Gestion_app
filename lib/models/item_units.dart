import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screens/api.dart';

class ItemUnitsScreen extends StatefulWidget {
  const ItemUnitsScreen({Key? key}) : super(key: key);

  @override
  State<ItemUnitsScreen> createState() => _ItemUnitsScreenState();
}

class _ItemUnitsScreenState extends State<ItemUnitsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Unite'),centerTitle: true,backgroundColor: Colors.cyan,),
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
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Unité',
                      icon: Icon(Icons.ac_unit))),
            ),
          ),
          const SizedBox(height: 10,),
          // Second
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
                controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      icon: Icon(Icons.description))),
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () {
                addItemUnits(nameController.text, descController.text);
                nameController.clear();
                descController.clear();
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
  addItemUnits(String name_units, description) async {
    Map data = {'name_units': name_units, 'description': description};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/addItemUnits';
    var response = await http.post(Uri.parse(url),
        body: data, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successful add ItemUnits'),
            backgroundColor: Colors.green,
          ));
    }
  }
}


class ItemUnits{
  String name,description;
  ItemUnits(this.name,this.description);
}