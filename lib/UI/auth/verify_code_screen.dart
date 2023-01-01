import 'package:firebase/UI/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/rounded_btn.dart';
import '../../utils/utils.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verifycontroller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verifycontroller,
              decoration: InputDecoration(
                  hintText: "6 digit code"
              ),
            ),
            SizedBox(height: 80,),

            RoundedButton(title: "Verify",loading: loading, onPress: () async{
              setState((){
                loading = true;
              });
             final credintal = PhoneAuthProvider.credential(
                 verificationId: widget.verificationId,
                 smsCode: verifycontroller.text.toString());

             try{
               await auth.signInWithCredential(credintal);
               Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreen()));
             }catch(e){
                setState((){
                  Utils().toastMessage(e.toString());
                  loading = false;
                });
             }

            })
          ],
        ),
      ),
    );
  }
}
