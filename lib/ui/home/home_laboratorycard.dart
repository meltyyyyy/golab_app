import 'package:flutter/material.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/ui/lab/lab.dart';

class LabCardWidget extends StatelessWidget {
  final Lab lab;

  const LabCardWidget({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LabPage(lab: lab)
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCardImage(),
            _buildCardDescription(),
            _buildCardOwner()
          ],
        ),
      ),
    );
  }

  Container _buildCardOwner() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(radius: 20,backgroundImage: NetworkImage(lab.avatarImageUrl)),
          const SizedBox(width: 15),
          Text(lab.labName,style: const TextStyle(fontSize: 15),)
        ],
      ),
    );
  }

  Container _buildCardDescription() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(lab.university,style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 10),
          Text(lab.tagline,style: const TextStyle(fontSize: 20))
        ],
      ),
    );
  }

  Stack _buildCardImage() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Ink.image(height:200,image: NetworkImage(lab.researchImageUrl),fit: BoxFit.fitWidth,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              alignment: Alignment.center,
              height: 20,
              width: 80,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1.0),
              ),
              child: Text(
                  lab.field,
                  style: const TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                  )
              )
          ),
        ),
      ],
    );
  }
}