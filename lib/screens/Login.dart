import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_app/screens/Register.dart';
import 'package:gestion_app/screens/Welcome.dart';
import 'package:gestion_app/screens/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isVisible= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Container(
                child: _isLoading ?
                const Center(child: CircularProgressIndicator()) : ListView(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                const Icon(
                                  Icons.phone_android,
                                  size: 100,
                                ),
                                const SizedBox(height: 55),
                                const Text(
                                  'Hello Again',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                const SizedBox(height: 22),
                                const Text(
                                  'Welcome ! Login screen ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 22),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.cyanAccent,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        controller: emailController,
                                          validator: (val)=>val!.length<6? 'Invalid email address !':null,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Email',
                                              icon: Icon(Icons.email))),
                                    )),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.cyanAccent,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child:TextFormField(
                                        controller: passwordController,
                                          validator: (val)=>val!.length<6? 'Required at least 6chars':null,
                                          obscureText: !_isVisible,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed:(){
                                                  setState(() {
                                                    _isVisible=!_isVisible;
                                                  });
                                                },
                                                icon:_isVisible? Icon(Icons.visibility):Icon(Icons.visibility_off) ),
                                              border: InputBorder.none,
                                              hintText: 'Password',
                                              icon: Icon(Icons.lock))),
                                    )),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      signIn();
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
                                    child: const Text('Sign In !', style:
                                        TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Not a member ?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Register()));
                                        },
                                        child: const Text('Register Now',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                )
                              ]),
                        ],
                      ))),
      ),
    );
  }

  signIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': emailController.text,
      'password':passwordController.text,
    };
    String token =await getToken();
    var jsonResponse;
    var url = 'http://10.7.150.48:8000/api/login';
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Welcome()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successful add Expense'),
          backgroundColor: Colors.green,
        ));
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }
  }

}
