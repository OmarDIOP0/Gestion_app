import 'package:flutter/material.dart';
import 'package:gestion_app/models/expenses.dart';
import 'package:gestion_app/models/items.dart';
import 'package:gestion_app/screens/Welcome.dart';

import '../models/item_categories.dart';
import '../models/item_units.dart';
import '../models/loans.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState(){
    super.initState();
  }
  int _currentindex = 0;
  final List children =[
    const Welcome(),
    const ItemScreen(),
    const ExpendScreen(),
    const Loan(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: children[_currentindex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan,
        currentIndex:_currentindex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.home),label:'Home',backgroundColor: Colors.cyan),
          BottomNavigationBarItem(icon:Icon(Icons.category),label:'Category',backgroundColor: Colors.cyan),
          BottomNavigationBarItem(icon:Icon(Icons.expand),label:'Expenses',backgroundColor: Colors.cyan),
          BottomNavigationBarItem(icon:Icon(Icons.monetization_on_rounded),label:'Loan',backgroundColor: Colors.cyan),
        ],
        onTap: (index){
          setState(() {
            _currentindex=index;
          });
        },
      ),
    );
  }
}
