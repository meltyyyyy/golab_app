import 'package:flutter/material.dart';

class DisplayDiscoverWidget extends StatelessWidget {
  const DisplayDiscoverWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          height: 15,
          width: 15,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.topRight
            ),
          ),
        ),
        const Text('Discover',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
      ],
    );
  }
}