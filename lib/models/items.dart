import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screens/api.dart';
import 'item_units.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var _itemCategory;
  var idItemCategory;
  var _unitsid;
  var idUnit;
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Items'),centerTitle: true,backgroundColor: Colors.cyan,leading: Icon(Icons.calendar_view_month),),
      body: _isLoading? CircularProgressIndicator():Column(
        children: [
          FutureBuilder(
              future: getItemCategory(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                } else {
                  return DropdownButton<String>(
                      hint:const Text('Select Item'),
                      dropdownColor: Colors.cyan,
                      onChanged: (value) {
                        setState(() {
                          _itemCategory = value!;
                        });
                      },
                      value: _itemCategory,
                      items: snapshot.data
                          .map<DropdownMenuItem<String>>((unit) {
                        var name = unit['name_item_categories'].toString();
                        idItemCategory = unit['id'].toString();
                        return DropdownMenuItem<String>(
                          value: idItemCategory.toString(),
                          child: Text(name),
                        );
                      }).toList()
                  );
                }
              }),
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
                      hintText: 'Nom du categorie',
                      icon: Icon(Icons.category))),
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
              future: getUnits(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return DropdownButton<String>(
                        hint:const Text('Select Units'),
                        dropdownColor: Colors.cyan,
                        onChanged: (value) {
                          setState(() {
                            _unitsid = value!;
                          });
                        },
                        value: _unitsid,
                        items: snapshot.data
                            .map<DropdownMenuItem<String>>((unit) {
                          var name = unit['name_units'].toString();
                          idUnit = unit['id'].toString();
                          return DropdownMenuItem<String>(
                            value: idUnit.toString(),
                            child: Text(name),
                          );
                        }).toList()
                    );
                  }
                }
              }),
          const SizedBox(height: 10),
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
                controller: descriptionController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      icon: Icon(Icons.comment))),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading=true;
                });
                addItem(nameController.text, descriptionController.text, _itemCategory, _unitsid);
                nameController.clear();
                descriptionController.clear();
                _itemCategory.clear();
                _unitsid.clear();
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
  addItem(String name_items, description,item__category_id,item_units_id,) async {
    Map data = {
      'name_items': name_items,
      'description': description,
      'item__category_id':item__category_id,
      'item_units_id':item_units_id
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/addItems';
    var response = await http.post(Uri.parse(url),
        body: data, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        _isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successful add Items'),
            backgroundColor: Colors.green,
          ));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Error add Items')
          ));
      setState(() {
        _isLoading=false;
      });
    }
  }
}

class Items{
  String name,description,item__category_id,item_units_id;
  Items(this.name,this.description,this.item__category_id,this.item_units_id);
}