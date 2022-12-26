import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';
import 'package:gestion_app/models/lenders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../screens/api.dart';

class Loan extends StatefulWidget {
  const Loan({Key? key}) : super(key: key);

  @override
  State<Loan> createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  //TextEditingController idController = TextEditingController();
  var id;
   var _lenderid;
   bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: const Icon(Icons.monetization_on_sharp),
      ),
      body: SingleChildScrollView(
        child: _isLoading? CircularProgressIndicator():Column(children: [
          const SizedBox(height: 10),
          FutureBuilder(
              future: getLender(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();

                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return DropdownButton<String>(
                      hint:const Text('Select Lender'),
                        dropdownColor: Colors.cyan,
                        onChanged: (value) {
                          setState(() {
                            _lenderid = value!;
                          });
                        },
                         value: _lenderid,
                        items: snapshot.data
                            .map<DropdownMenuItem<String>>((lender) {
                          var name = lender['name'].toString();
                            id = lender['id'].toString();
                          return DropdownMenuItem<String>(
                            value: id.toString(),
                            child: Text(name),
                          );
                        }).toList()
                    );
                  }
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
                  controller: dateController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Payed at ?',
                      icon: Icon(Icons.date_range)),
                   onTap: () async{
                    DateTime? pickedate= await showDatePicker(
                        context: context,
                        initialDate:DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate:DateTime(2100),
                    );
                    if(pickedate!=null){
                      setState(() {
                        dateController.text=pickedate.toString();
                      });
                    }
                   },
                  ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(

              onPressed: () {
                setState(() {
                  _isLoading=true;
                });
               addLoan(amountController.text,_lenderid,dateController.text);
                amountController.clear();
                _lenderid.clear();
                dateController.clear();
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
        ]),
      ),
    );
  }
  addLoan(String amount,lenders_id, payed_at) async {
    Map data = {'amount': amount, 'lenders_id': lenders_id, 'payed_at': payed_at};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = await getToken();
    var url = 'http://10.7.150.48:8000/api/addLoan';
    var response = await http.post(Uri.parse(url),
        body: data, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        _isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Successful add Loan'),
            backgroundColor: Colors.green,
          ));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Error add Loan')
          ));
      setState(() {
        _isLoading=false;
      });
    }
    }
  }

class Loans {
  int amount,lenders_id;
  String payed_at;

  Loans(this.amount,this.lenders_id,this.payed_at);
}

