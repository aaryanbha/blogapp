import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'WelcomeScreen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    final user = auth.currentUser;
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),
            () {
      if(user!=null){
        Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
      else{
        Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
      }
        });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:AssetImage('assets/images/logo.png'),
              radius: 75,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('BLOGIFY',style: TextStyle(color: Colors.black,fontSize: 56,fontWeight: FontWeight.bold),),
            ),
            Text('Connecting Writers, Inspiring Readers.',style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      )
    );
  }
}