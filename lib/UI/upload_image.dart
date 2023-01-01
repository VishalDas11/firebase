import 'package:firebase/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase/Widgets/rounded_btn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseref = FirebaseDatabase.instance.ref('Post');
  File? _image;

  final imagepicker  = ImagePicker();
  Future PickedGalleryImage() async{
    final picker = await imagepicker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState((){
      if(picker != null){
        _image = File(picker.path);
      }
      else{
        print("No image picked");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image"), centerTitle: true, backgroundColor: Colors.purple,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                PickedGalleryImage();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
                child: _image != null ? Image.file(_image!.absolute,  fit: BoxFit.contain,): Icon(Icons.image),
              ),
            ),
            SizedBox(height: 20,),
            RoundedButton(title: "Upload", onPress: ()async{
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/Vishal/'+ DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

               Future.value(uploadTask).then((value) async{
                var newurl = await ref.getDownloadURL();

                databaseref.child('id').set({
                  'id' : '1212',
                  'title' : newurl.toString()
                }).then((value){
                  Utils().toastMessage("Upload Image");
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });


            })
          ],
        ),
      ),
    );
  }
}
