import 'package:firebase/Widgets/rounded_btn.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login.dart';

// enum Gender  {Male, Female}


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nc = TextEditingController();
  final ec = TextEditingController();
  final pc =TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  final _userRef = FirebaseDatabase.instance.ref("UserDetail");

  // Gender? gendertype ;
  // int _value =0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("SignUp Form"), backgroundColor: Colors.purple,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nc,
                    decoration:const InputDecoration(
                        hintText: "Enter Name",
                        label: Text("Name"),
                        prefixIcon: Icon(Icons.person)
                    ) ,
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    controller: ec,
                    decoration:const InputDecoration(
                        hintText: "Enter Email",
                        label: Text("Email"),
                        prefixIcon: Icon(Icons.email_outlined)
                    ) ,
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: pc,
                    decoration:const InputDecoration(
                        hintText: "Enter Password",
                        label: Text("Password"),
                        prefixIcon: Icon(Icons.lock_outline)
                    ) ,
                  ),
                  const SizedBox(height: 30,),
                  // Row(
                  //   children: [
                  //     Radio<Gender>(
                  //         value: Gender.Male,
                  //         groupValue: gendertype,
                  //         onChanged: (value){
                  //           setState((){
                  //             gendertype = value;
                  //           });
                  //         }
                  //     ),
                  //     const SizedBox(width: 10,),
                  //
                  //     Gender.Male.name.text.size(16).make(),
                  //     const SizedBox(height: 10,),
                  //
                  //     Radio<Gender>(
                  //         value: Gender.Female,
                  //         groupValue: gendertype,
                  //         onChanged: (value){
                  //           setState((){
                  //             gendertype = value;
                  //           });
                  //         }
                  //     ),
                  //     const SizedBox(width: 10,),
                  //
                  //     "${Gender.Female.name}".text.size(16).make()
                  //   ],
                  // ),
                  RoundedButton(title: "Sign Up", onPress: ()async{
                    UserCredential userCrediential = await _auth.createUserWithEmailAndPassword(
                        email: ec.text,
                        password: pc.text);
                    if(userCrediential.user != null){
                      String uid = userCrediential.user!.uid;
                      _userRef.child(uid).set(
                          {"name" : nc.text, "email" : ec.text,}
                      ).then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                      }).onError((error, stackTrace){
                        Utils().toastMessage(error.toString());
                      });
                    }
                  }),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Dont't have an Account?".text.make(),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                          },
                          child: "Login".text.bold.make())

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
