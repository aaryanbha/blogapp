import 'package:backend/login.dart';
import 'package:backend/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget{
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {
  var kprimary = Colors.white;
  var curr_select = [0,0,0,0,0,0];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // left menu bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                 Icon(Icons.list_outlined,color: Colors.black),
              ],
            ),
          ),
          SizedBox(
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.only(
               left: 12
            ),
            child: Container(
              // color: Colors.blue,
              height: MediaQuery.of( context).size.height/2,
              width: MediaQuery.of( context).size.width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text('Get Started',style: TextStyle(color: Colors.grey,fontSize: 23),),
                  SizedBox(
                    height: 21,
                  ),
                  Text('Publish Your',style: TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.bold),),
                  Text('Passion in Own Way',style: TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.bold),),
                  Text('Its Free',style: TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 7,
                    ),
                    child: Container(
                      width: 150,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                                   height: 7,
                                   width: 40,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: Colors.black,
                                     border: Border(),
                                   ),
                                 ),
                          Container(
                                   height: 7,
                                   width: 40,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: Colors.grey,
                                     border: Border.all(),
                                   ),
                                 ),
                          Container(
                                   height: 7,
                                   width: 40,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: Colors.grey,
                                     border: Border.all(),
                                   ),
                                 ),
                        ],
                      ),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.only(
                       top:30,
                       left: 5,
                       right: 7,
                       bottom: 30,
                     ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(),
                              ),
                              child: Center(child: Text('Register',style: TextStyle(color: Colors.black,fontSize: 23,),)),
                              width: 150,
                              height: 50,
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
                            },
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginIn()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(),
                              ),
                              child: Center(child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 23,),)),
                              width: 150,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       CircleAvatar(
                         backgroundColor: Colors.black,
                         radius: 24,
                         child: CircleAvatar(
                           child: Center(
                             child: Icon(
                               Icons.phone,
                               color: Colors.black,
                             ),
                           ),
                           radius: 23,
                           backgroundColor: Colors.white,

                         ),
                       ),
                       Text('Continue with ',style: TextStyle(color: Colors.black,fontSize: 23),),
                       Text('Phone no.',style:TextStyle(color:Colors.black,fontSize: 23,fontWeight: FontWeight.bold)),
                     ],
                   )
                ],
              ),
            ),
          ),
          Row(
          children: [

                    ],
    )
        ],
      ),
    );
  }
}