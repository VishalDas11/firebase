import 'package:firebase/Widgets/rounded_btn.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final databseref = FirebaseDatabase.instance.ref('Post');
  final addpostcontroller = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 50,),
              TextFormField(
                controller: addpostcontroller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Add description",
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 50,),
              RoundedButton(title: "Add Post", onPress: (){
                setState((){
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databseref.child(id).set({
                  'title' : addpostcontroller.text,
                  'id' : id
                }).then((value) {
                   setState((){
                     loading = false;
                   });
                   Utils().toastMessage("Add successfully");
                }).onError((error, stackTrace){
                  setState((){
                    loading= false;
                  });
                    Utils().toastMessage(error.toString());
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}
