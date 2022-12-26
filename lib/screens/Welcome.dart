import 'package:flutter/material.dart';
import 'package:gestion_app/methode/apiMethode.dart';
import 'package:gestion_app/models/budget.dart';
import 'package:gestion_app/models/deposits.dart';
import 'package:gestion_app/models/item_categories.dart';
import 'package:gestion_app/models/items.dart';
import 'package:gestion_app/models/lenders.dart';
import 'package:gestion_app/models/loans.dart';
import 'package:gestion_app/screens/Login.dart';
import 'package:gestion_app/screens/WelcomeScreen.dart';
import 'package:gestion_app/screens/historique_depense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gestion_app/models/balances.dart';

import '../models/history_deposit.dart';
import '../models/item_units.dart';
import '../models/payment_methods.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
 late SharedPreferences sharedPreferences;

  @override
  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) =>DefaultTabController(
      length:2,
     child:Scaffold(
      appBar: AppBar(title: FutureBuilder(
              future: viewBalance(),
              builder:(context,snapshot){
                if(snapshot.data==null){
                  return CircularProgressIndicator();
                }
                return Text('Balance: ${snapshot.data} FCFA');
              }
          ),
        centerTitle: true,
         backgroundColor: Colors.cyan,
         toolbarHeight: 80,
      ),
      body:SafeArea(
        child:Column(
          children: [
                 TabBar(
                     indicatorColor: Colors.cyan,
                     labelColor: Colors.cyan,
                     unselectedLabelColor: Colors.black,
                     tabs:[
                       Tab(text: 'History Deposits'),
                       Tab(text:'History Expenses'),
                     ]
                 ),
                Expanded(
                    child:TabBarView(
                      children: [
                        HistoryDeposit(),
                        HistoriqueDepense(),
                      ],
                    )
                )

          ],
        ),
      ),

      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DepositScreen()));
        },
        child:const Icon(Icons.add,size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        backgroundColor: Colors.cyan,
        width:MediaQuery.of(context).size.width*0.5,
        child: ListView(
          children: [
               DrawerHeader(decoration: const BoxDecoration(color: Colors.cyan),
                duration:const Duration(milliseconds: 100),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Column(
                      children: [
                        FutureBuilder(
                            future: getProfile(),
                            builder: (context,snapshot){
                              if(snapshot.data==null){
                                return CircularProgressIndicator();
                              }
                              else{
                                return Text(snapshot.data,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),);
                              }
                            }
                        ),
                        FutureBuilder(
                            future: getEmail(),
                            builder: (context,snapshot){
                              if(snapshot.data==null){
                                return CircularProgressIndicator();
                              }
                              else{
                                return Text(snapshot.data);
                              }
                            }
                        ),
                      ],
                    )
                  ],
                )),
            ListTile(
                title:const Text('Lender'),
                leading:const Icon(Icons.person),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LenderScreen()));
                }
            ),
            ListTile(
                title:const Text('Categorie'),
                leading:const Icon(Icons.category),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ItemCategoryScreen()));
                }
            ),
            ListTile(
                title:const Text('ItemUnits'),
                leading:const Icon(Icons.ac_unit),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ItemUnitsScreen()));
                }
            ),
            ListTile(
                title:const Text('PaymentMethod'),
                leading:const Icon(Icons.local_atm),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PaymentMethodScreen.PaymentMethod()));
                }
            ),
            ListTile(
                title:const Text('Budget'),
                leading:const Icon(Icons.monetization_on),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const BudgetScreen()));
                }
            ),
             ListTile(
              title:const Text('Logout'),
              leading:const Icon(Icons.logout),
               onTap: (){
               // sharedPreferences.clear();
               // sharedPreferences.commit();
                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false);
               }
            )
          ],
        ),
      ),
     ),
    );
}
