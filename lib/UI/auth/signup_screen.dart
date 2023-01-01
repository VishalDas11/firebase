import 'package:firebase/UI/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/rounded_btn.dart';
import '../../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController;
    passwordController;
  }

  void signup(){
    if(_formkey.currentState!.validate()){
      setState((){
        loading = true;
      });
      auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value) {
        setState((){
          loading = false;
        });
      }).onError((error, stackTrace) {
        setState((){
          loading = false;
        });
        Utils().toastMessage(error.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SignUp"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        key: _formkey,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email_outlined, color: Colors.blueAccent,),
                                  helperText: "Enter email e.g @gmail.com"
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please Enter Email";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 30,),
                            TextFormField(

                              keyboardType: TextInputType.text,
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock, color: Colors.blueAccent,),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please Enter Password";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 60,),
                            RoundedButton(
                              loading: loading,
                              onPress: () {
                                signup();
                              },
                              title: 'Sign up',

                            ),
                            const SizedBox(height: 30,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                                }, child: Text("Login", style: TextStyle(color: Colors.deepPurple),))
                              ],
                            )
                          ],
                        )
                    ),

                  ],
                ),
              ),
            )
        ),
    );
  }
}
