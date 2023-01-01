import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Widgets/rounded_btn.dart';
import 'package:firebase/firestore/firestoredataScreen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:flutter/material.dart';

class AddFireStoreData extends StatefulWidget {
  const AddFireStoreData({Key? key}) : super(key: key);

  @override
  State<AddFireStoreData> createState() => _AddFireStoreDataState();
}

class _AddFireStoreDataState extends State<AddFireStoreData> {
  final firestore  = FirebaseFirestore.instance.collection('Users');
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data"), centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind",
                border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 50,),
          RoundedButton(title: "Add", onPress: (){
            final id = DateTime.now().millisecondsSinceEpoch.toString();
                firestore.doc().set({
                  'title' : postcontroller.text.toString(),
                  id : id
                }).then((value){
                  Utils().toastMessage("Post Successfully");
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
          })
        ],
      ),
    );
  }
}
