import 'package:backend/ForgotPassword.dart';
import 'package:backend/HomeScreen.dart';
import 'package:backend/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginIn extends StatefulWidget{
  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
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
          title: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,),),
          automaticallyImplyLeading: false,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 14,
                                  top: 10,
                                ),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Create Account',style: TextStyle(fontSize: 15,),)),
                              ),
                            ),
                            InkWell(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 12,
                                  top: 10,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                    child: Text('Forgot Password ?',style: TextStyle(fontSize: 15,),)),
                              ),
                            ),
                          ],
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
                                  final user = await _auth.signInWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                                  if(user!=null){
                                    print('success');
                                    toastMessage('User Successfully Logined');
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
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
                              child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),)),
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