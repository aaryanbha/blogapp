import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPasswordScreen extends StatefulWidget{
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  String email="";
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot PassWord ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,),),
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
                                   _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                                     setState(() {
                                       showSpinner = false;
                                     });
                                      toastMessage('Please Check Your Email ');
                                   }
                                   ).onError((error, stackTrace){
                                     setState(() {
                                       showSpinner = false;
                                     });
                                     toastMessage(error.toString());
                                   });
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
                              child: Center(child: Text('Recover Password',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),)),
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

