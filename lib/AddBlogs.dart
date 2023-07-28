
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class AddBlogs extends StatefulWidget{
  @override
  State<AddBlogs> createState() => _AddBlogsState();
}

class _AddBlogsState extends State<AddBlogs> {
  bool showSpinner = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final postRef = FirebaseDatabase.instance.ref().child('Posts');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _image;
  final _formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final picker = ImagePicker();
  Future getImagefromGallery() async{
     final pickedimage = await picker.pickImage(source: ImageSource.gallery);
     setState(() {
       if(pickedimage!=null){
         _image = File(pickedimage.path);
       }
       else{
         print('No Image Selected');
       }
     });
  }
  Future getImagefromCamera() async{
    final pickedimage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedimage!=null){
        _image = File(pickedimage.path);
      }
      else{
        print('No Image Selected');
      }
    });
  }
  // this would contain the address of the image
  void dialog(context){
    showDialog(
        context: context,
        builder: (BuildContext){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
             actions: [
               Container(
                 child: Column(
                   children: [
                     InkWell(
                       onTap: (){
                        getImagefromCamera();
                        Navigator.pop(context);
                       },
                       child: ListTile(
                         leading: Icon(Icons.camera_alt),
                         title: Text('Camera'),
                       ),
                     ),
                     InkWell(
                       onTap:(){
                        getImagefromGallery();
                        Navigator.pop(context);
                       },
                       child: ListTile(
                         leading: Icon(Icons.photo_library),
                         title: Text('Gallery'),
                       ),
                     ),
                   ],
                 ),
               )
             ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('UPLOAD BLOGS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,),)),
          backgroundColor: Colors.black,
          toolbarHeight: 75,
        ),
        body: SingleChildScrollView(
          child: InkWell(
            onTap: (){
               dialog(context);
            },
            child: Center(
              child: Column(
                children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: MediaQuery.of(context).size.height*.2,
                     width: MediaQuery.of(context).size.width*0.9,
                     child: _image != null ?ClipRect(
                       child: Image.file(
                         _image!.absolute,
                         width: 100,
                         height: 100,
                         fit: BoxFit.cover,
                       ),
                     ):Container(
                       width: 100,
                       height: 100,
                       child: Center(child: Icon(Icons.camera_alt)),
                       decoration: BoxDecoration(
                         color: Colors.grey.shade200,
                       ),
                     ),
                   ),
                 ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: Colors.black,
                                controller: title,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black,),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  labelText: 'Title',
                                  hintText: 'Title',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    labelStyle: TextStyle(color: Colors.black),
                                ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                               controller: description,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              minLines: 2,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelText: 'Description',
                                hintText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            InkWell(
                              onTap: () async{
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  int date = DateTime.now().microsecondsSinceEpoch;
                                  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/dumyy$date');
                                  UploadTask uploadtask = ref.putFile(_image!.absolute);
                                  await Future.value(uploadtask);
                                  var newurl = await ref.getDownloadURL();
                                  final User? user = _auth.currentUser;
                                  postRef.child('Posts Lists').child(date.toString()).set(
                                      {
                                             'PId': date.toString(),
                                             'pTime': date.toString(),
                                             'pImage': newurl.toString(),
                                             'pTitle': title.text.toString(),
                                             'pDescription': description.text.toString(),
                                             'userEmail': user!.email.toString(),
                                             'userId':user!.uid,
                                      }).then((value){
                                        toastMessage('Blog Published');
                                            setState(() {
                                              showSpinner = false;
                                            });
                                  }).onError((error, stackTrace){
                                    print(error.toString());
                                        toastMessage(error.toString());
                                        setState(() {
                                          showSpinner = false;
                                        });
                                  });
                                }catch(e){
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  toastMessage(e.toString());
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 50,
                                ),
                                child: Container(
                                  height: 50,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(child: Text('Upload ',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        ) ,
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
