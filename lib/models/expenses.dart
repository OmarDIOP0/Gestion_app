import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';
import 'package:gestion_app/screens/historique_depense.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/api.dart';
import '../ui/components/custom_text_form_field.dart';

class ExpendScreen extends StatefulWidget {
  const ExpendScreen({Key? key}) : super(key: key);

  @override
  State<ExpendScreen> createState() => _ExpendScreenState();
}

class _ExpendScreenState extends State<ExpendScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  var _unitsid;
  var idUnit;
  var _itemid;
  var idItem;
  var _itemCategory;
  var idItemCategory;
  var _paymentid;
  var idPayment;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depenses'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: const Icon(Icons.expand),
      ),
      body: SingleChildScrollView(
        //child:Expanded(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  FutureBuilder(
                      future: getItemCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return CircularProgressIndicator();
                        } else {
                          return DropdownButton<String>(
                              hint: const Text('Select Item Category'),
                              dropdownColor: Colors.cyan,
                              onChanged: (value) {
                                setState(() {
                                  _itemCategory = value!;
                                });
                              },
                              value: _itemCategory,
                              items: snapshot.data
                                  .map<DropdownMenuItem<String>>((unit) {
                                var name =
                                    unit['name_item_categories'].toString();
                                idItemCategory = unit['id'].toString();
                                return DropdownMenuItem<String>(
                                  value: idItemCategory.toString(),
                                  child: Text(name),
                                );
                              }).toList());
                        }
                      }),
                  FutureBuilder(
                      future: getItem(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return CircularProgressIndicator();
                        } else {
                          return DropdownButton<String>(
                              hint: const Text('Select Item'),
                              dropdownColor: Colors.cyan,
                              onChanged: (value) {
                                setState(() {
                                  _itemid = value!;
                                });
                              },
                              value: _itemid,
                              items: snapshot.data
                                  .map<DropdownMenuItem<String>>((unit) {
                                var name = unit['name_items'].toString();
                                idItem = unit['id'].toString();
                                return DropdownMenuItem<String>(
                                  value: idItem.toString(),
                                  child: Text(name),
                                );
                              }).toList());
                        }
                      }),
                  CustomTextFormField(
                    comment: 'Quantity',
                    icon: Icons.production_quantity_limits,
                    controller: quantityController,
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
                                hint: const Text('Select Units'),
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
                                }).toList());
                          }
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                          controller: unitPriceController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Prix unitaire',
                              icon: Icon(Icons.monetization_on_sharp))),
                    ),
                  ),
                  FutureBuilder(
                      future: getPaymentMethod(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return DropdownButton<String>(
                                hint: const Text('Select Payment'),
                                dropdownColor: Colors.cyan,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentid = value!;
                                  });
                                },
                                value: _paymentid,
                                items: snapshot.data
                                    .map<DropdownMenuItem<String>>((unit) {
                                  var name = unit['name_payment'].toString();
                                  idPayment = unit['id'].toString();
                                  return DropdownMenuItem<String>(
                                    value: idPayment.toString(),
                                    child: Text(name),
                                  );
                                }).toList());
                          }
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                          controller: commentController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Commentaire',
                              icon: Icon(Icons.comment))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        addExpend(
                            amountController.text,
                            quantityController.text,
                            unitPriceController.text,
                            commentController.text,
                            _itemid,
                            _paymentid,
                            _itemCategory,
                            _unitsid);
                        amountController.clear();
                        quantityController.clear();
                        unitPriceController.clear();
                        commentController.clear();
                        _itemCategory.clear();
                        _itemid.clear();
                        _paymentid.clear();
                        _unitsid.clear();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ))),
                      child: const Text(
                        'Valider',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
        //),
      ),
    );
  }

  addExpend(String amount, quantity, unit_price, comments, items_id,
      payment_methods_id, item__categories_id, item_units_id) async {
    Map data = {
      'amount': amount,
      'quantity': quantity,
      'unit_price': unit_price,
      'comments': comments,
      'items_id': items_id,
      'payment_methods_id': payment_methods_id,
      'item__categories_id': item__categories_id,
      'item_units_id': item_units_id
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = await getToken();
    var url = 'http://110.7.150.48:8000/api/addExpenses';
    var response = await http.post(Uri.parse(url),
        body: data, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successful add Expense'),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error add Expense')));
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class Expenses {
  String amount,
      quantity,
      unit_price,
      comments,
      items_id,
      payment_methods_id,
      item_units_id,
      item__categories_id;

  Expenses(
      this.amount,
      this.comments,
      this.quantity,
      this.unit_price,
      this.items_id,
      this.payment_methods_id,
      this.item_units_id,
      this.item__categories_id);
}
