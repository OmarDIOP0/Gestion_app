import 'package:flutter/material.dart';
import 'package:gestion_app/screens/Login.dart';
import 'package:flare_flutter/flare_actor.dart';
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Gestion_App'),centerTitle: true,backgroundColor: Colors.cyan,),
      body:SafeArea(
      child:Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:   [
              const Icon(Icons.add_business,size: 100,),
              const SizedBox(height: 55),
              const Text('Hello ',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 24),),
              const SizedBox(height: 22),
              const Text('Welcome ! Gestion_App',style: TextStyle(fontSize: 20),),
              const SizedBox(height: 22),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));},style:ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Colors.cyan),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ))
              ), child:const Text('Get Started !',style: TextStyle(fontSize:20,color: Colors.white),)),
         Container(
           height: 100,
           width: 100,
           child:const FlareActor('assets/Check.flr',alignment: Alignment.center,fit: BoxFit.contain,),
         ),
      ]
      ),
      ),
      ),
    );
  }
}
