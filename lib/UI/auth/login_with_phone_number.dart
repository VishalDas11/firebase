import 'package:firebase/UI/auth/verify_code_screen.dart';
import 'package:firebase/Widgets/rounded_btn.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumbercontroller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("phone number"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumbercontroller,
              decoration: InputDecoration(
                hintText: "+920000000000"
              ),
            ),
            SizedBox(height: 80,),

            RoundedButton(title: "submit",loading: loading, onPress: (){
              setState((){
                loading = true;
              });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumbercontroller.text,
                    verificationCompleted: (_){
                      setState((){
                        loading = false;
                      });
                    },
                    verificationFailed: (e){
                      setState((){
                        loading = false;
                      });
                    Utils().toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verificationId,)));
                     setState((){
                       loading = false;
                     });
                    },
                    codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                    setState((){
                      loading = false;
                    });
                    });
            })
          ],
        ),
      ),
    );
  }
}
