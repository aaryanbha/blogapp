import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class SignIn extends StatefulWidget{
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email="",password="";
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Create Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,),),
            backgroundColor: Colors.black,
            toolbarHeight: 75,
          ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                   top: 10,

                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         prefixIcon: Icon(Icons.email,color: Colors.black),
                         hintText: 'Email',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25),
                         )
                       ),
                        onChanged: (String value) {
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Email' : null;
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock,color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )
                        ),
                        onChanged: (String value){
                          password = value;
                        },
                        validator: (value){
                          return  value!.isEmpty ? 'Enter Password' : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.account_box_outlined,color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone,color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Profession',
                            prefixIcon: Icon(Icons.work,color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Country',
                            prefixIcon: Icon(Icons.flag,color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Education',
                            prefixIcon: Icon(Icons.book,color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top:30,
                      ),
                      child: InkWell(
                        onTap: () async {
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              showSpinner = true;
                            });
                             try{
                               final user = await _auth.createUserWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                               if(user!=null){
                                 print('success');
                                 toastMessage('User Successfully Registered');
                                 setState(() {
                                   showSpinner = false;
                                 });
                               }
                             }catch(e){
                               print(e.toString());
                               toastMessage(e.toString());
                               setState(() {
                                 showSpinner = false;
                               });
                             }
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(child: Text('Register Me!!',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ]
          ),
        ),
      ),
    );
  }
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
