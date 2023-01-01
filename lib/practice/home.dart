import 'package:firebase/practice/login.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _value = 1;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),
        automaticallyImplyLeading: false,
        actions: [

          InkWell(
            onTap: (){
              _auth.signOut().then((value){
                Utils().toastMessage("Logout");
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
            },
              child: Icon(Icons.exit_to_app)),
          SizedBox(width: 40,),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (int? value){
                    setState((){
                      _value = value!;
                    });
                  }
              ),
              const SizedBox(width: 10,),

              "Male".text.size(16).make(),
              const SizedBox(height: 10,),

              Radio(
                  value: 2,
                  groupValue: _value,
                  onChanged: (int? value){
                    setState((){
                      _value = value!;
                    });
                  }
              ),
              const SizedBox(width: 10,),

              "Female".text.size(16).make()
            ],
          ),
        ],
      ),
    );
  }
}
