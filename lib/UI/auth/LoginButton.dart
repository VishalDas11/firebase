// import 'package:firebase/UI/auth/login_screen.dart';
// import 'package:firebase/UI/auth/login_with_phone_number.dart';
// import 'package:firebase/Widgets/rounded_btn.dart';
// import 'package:flutter/material.dart';
//
// class LoginButton extends StatefulWidget {
//   const LoginButton({Key? key}) : super(key: key);
//
//   @override
//   State<LoginButton> createState() => _LoginButtonState();
// }
//
// class _LoginButtonState extends State<LoginButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             RoundedButton(title: "Login With Email",
//                 onPress:(){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
//                 }),
//             SizedBox(height: 50,),
//             RoundedButton(title: "Login With Phone Number", onPress: (){
//               Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginWithPhoneNumber()));
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
