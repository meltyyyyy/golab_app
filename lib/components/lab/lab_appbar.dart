import 'package:flutter/material.dart';

class LabAppBarComponent {

  static Widget researchImage(BuildContext context, String researchImageUrl) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.network(researchImageUrl, fit: BoxFit.cover)
    );
  }

  static Widget updateResearchImage(Function()? _onTap) {
    return InkWell(
      onTap: _onTap,
      child: SizedBox(
        height: 250,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.camera_alt_outlined,color: Colors.white,size: 24),
            SizedBox(width: 25),
            Text('Upload Research Image',style: TextStyle(color: Colors.white,fontSize: 18))
          ],
        ),
      ),
    );
  }

  static Widget backgroundFilter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 200)),
    );
  }
}