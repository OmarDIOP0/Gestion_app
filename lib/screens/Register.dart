import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/screens/Login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  bool _isVisible=false;

  _register() async {
    Map data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmpasswordController.text
    };

    var res = await http.post(Uri.parse('http://10.0.117.244:8000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successful Register'),
        backgroundColor: Colors.green,
      ));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Login()));
    } else {
      print('Error to register');
      print(res.statusCode);
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 25),
            const Text(
              'Hello',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 22),
            const Text(
              'Welcome ! Register screen ',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 22),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                          icon: Icon(Icons.person))),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          icon: Icon(Icons.email))),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                      controller: passwordController,
                      obscureText: !_isVisible,
                      decoration:  InputDecoration(
                        suffixIcon: IconButton(
                            onPressed:(){
                              setState(() {
                                _isVisible=!_isVisible;
                              });
                            },
                            icon:_isVisible?const Icon(Icons.visibility):const Icon(Icons.visibility_off)
                        ),
                          border: InputBorder.none,
                          hintText: 'Password',
                          icon:const Icon(Icons.lock))),
                )),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                      controller: confirmpasswordController,
                      obscureText: !_isVisible,
                      decoration:  InputDecoration(
                          suffixIcon: IconButton(
                              onPressed:(){
                                setState(() {
                                  _isVisible=!_isVisible;
                                });
                              },
                              icon:_isVisible?const Icon(Icons.visibility):const Icon(Icons.visibility_off) ),
                          border: InputBorder.none,
                          hintText: 'Confirm_Password',
                          icon:const Icon(Icons.lock))),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _register,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ))),
                child: const Text('Register !',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 12),
          ]),
        ),
      ),
    );
  }
}
