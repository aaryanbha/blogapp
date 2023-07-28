
import 'package:backend/AddBlogs.dart';
import 'package:backend/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbref = FirebaseDatabase.instance.ref().child('Posts');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('NEW BLOGS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,),)),
         backgroundColor: Colors.black,
         toolbarHeight: 75,
         automaticallyImplyLeading: false,
         actions: [
           InkWell(
             onTap:(){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> AddBlogs()));
             } ,
               child: Icon(Icons.add,color: Colors.white,)
           ),
           SizedBox(
             width: 20,
           ),
           InkWell(
               onTap:(){
                 auth.signOut().then((value){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginIn()));
                 });
               } ,
               child: Icon(Icons.logout,color: Colors.white,)
           ),
           SizedBox(
             width: 20,
           ),
         ],
       ),
       body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: dbref.child('Posts Lists'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                      top: 12.0
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/logo.png',
                              image: snapshot.child('pImage').value.toString(),
                            width: MediaQuery.of(context).size.width*1,
                            height: MediaQuery.of(context).size.height*0.25,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          SizedBox(
                            height: 10,
                          ),
                        Text(snapshot.child('pTitle').value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                          ),
                          child: Text(snapshot.child('pDescription').value.toString(),style: TextStyle(fontSize: 15),),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
              },

            ),
          )
        ],
    ),
    );
  }
}
