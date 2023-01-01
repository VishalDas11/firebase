import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  const RoundedButton({Key? key, required this.title,this.loading= false, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: loading ? CircularProgressIndicator(color: Colors.white,) :
        Text(title, style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}
