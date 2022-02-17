import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;

  const CustomButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.topRight
          ),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Text(title,style: const TextStyle(color: Colors.white)),
    );
  }
}