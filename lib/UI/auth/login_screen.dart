import 'package:firebase/UI/auth/login_with_phone_number.dart';
import 'package:firebase/UI/auth/signup_screen.dart';
import 'package:firebase/UI/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Widgets/rounded_btn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
   bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController;
    passwordController;
  }

void login(){
    setState((){
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreen()));
          setState((){
            loading = false;
          });
          
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
        Utils().toastMessage(error.toString());
      setState((){
        loading = false ;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Login"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formkey,
                      child:
                  Column(
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
                      const SizedBox(height: 60,)
                    ],
                  )
                  ),

                   RoundedButton(onPress: () {

                     if(_formkey.currentState!.validate()){
                       login();
                     }
                   },
                     loading: loading,
                     title: 'Login',

                   ),
                  const SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                      }, child: Text("Sign Up", style: TextStyle(color: Colors.deepPurple),))
                    ],
                  ),
                  SizedBox(height: 50,),
                  InkWell(
                    onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginWithPhoneNumber()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black
                        )
                      ),
                      child: Center(
                        child: Text("Login With Phone Number"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
