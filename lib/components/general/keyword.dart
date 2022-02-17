import 'package:flutter/material.dart';

class KeywordWidget extends StatelessWidget {
  final String keyword;

  const KeywordWidget({Key? key, required this.keyword}) : super(key: key);

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
      child: Text(keyword,style: const TextStyle(color: Colors.white)),
    );
  }
}