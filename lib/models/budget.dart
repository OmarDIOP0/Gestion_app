import 'dart:convert';

import 'package:flutter/material.dart';

import '../methode/apiMethode.dart';
import '../screens/api.dart';
import 'item_categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  TextEditingController amountController = TextEditingController();
  var _itemCategory;
  var idItemCategory;
bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child:_isLoading?CircularProgressIndicator():Column(children: [
          const SizedBox(height: 10),
          FutureBuilder(
              future: getItemCategory(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                } else {
                  return DropdownButton<String>(
                      hint:const Text('Select Item Category'),
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
          const SizedBox(
            height: 10,
          ),
          // Second
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
                  controller: amountController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Saisir le montant',
                      icon: Icon(Icons.monetization_on_sharp))),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading=true;
                });
                addBudget(amountController.text, _itemCategory);
                amountController.clear();
                _itemCategory.clear();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ))),
              child: const Text(
                'Valider',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 30),
        Text('Budget Categorie'),
        const SizedBox(height: 5),
        Container(
        width: MediaQuery.of(context).size.width*1,
          child: FutureBuilder(
              future: getBudget(),
              builder: (context, snapshot) {
                print('Display Snapshot');
                print(snapshot.data);
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                else {
                    return DataTable(
                        columns:[
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Amount')),
                        ],
                        rows: snapshot.data.map<DataRow>((data){
                           var name = data['name_item_categories'].toString();
                           var amount = data['amount'].toString();

                          return DataRow(
                            cells: [
                              DataCell(Text(name)),
                              DataCell(Text(amount)),
                            ]
                          );
                        }).toList()
                    );
                  }
              }),
        )
        ]),
        
     ),
    );
  }
  addBudget(String amount,item__category_id) async {
    Map data = {
      'amount': amount,
      'item__category_id':item__category_id,
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/addBudget';
    var response = await http.post(Uri.parse(url),
        body: data, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successful add Budget'),
            backgroundColor: Colors.green,
          ));
      setState(() {
        _isLoading=false;
      });
    }
  }
}


class Budget{
  String amount,item__category_id;
  Budget(this.amount,this.item__category_id);
}