import 'package:firebase/Widgets/rounded_btn.dart';
import 'package:firebase/practice/home.dart';
import 'package:firebase/practice/sigunp.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ec = TextEditingController();
  final pc = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ec;
    pc;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Form"), backgroundColor: Colors.purple,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: ec,
                  decoration: InputDecoration(
                      hintText: "Enter Email",
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email_outlined)
                  ) ,
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: pc,
                  decoration: InputDecoration(
                      hintText: "Enter PAssword",
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.lock_outline)
                  ) ,
                ),
                const SizedBox(height: 30,),
                RoundedButton(title: "Login", onPress: (){
                  if(_formKey.currentState!.validate()){
                    _auth.signInWithEmailAndPassword(
                        email: ec.text, password: pc.text).then((value){
                          Utils().toastMessage("Login Successfully");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  }
                }),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Dont't have an Account?".text.make(),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                    }, child: Text("SignUp"),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
