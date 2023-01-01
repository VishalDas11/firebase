import 'dart:async';


import 'package:firebase/UI/auth/login_screen.dart';
import 'package:firebase/UI/posts/post_screen.dart';
import 'package:firebase/UI/upload_image.dart';
import 'package:firebase/firestore/firestoredataScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const UploadImage()));
      });
    }
    else{
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
      });
    }


  }
}