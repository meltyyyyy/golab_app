import 'package:flutter/material.dart';
import 'package:golab/ui/mypage/researcher/create_labpage.dart';
import 'package:golab/ui/mypage/researcher/owner_labpage.dart';

class ResearcherComponents {
  static Widget imageBoxForOwningPage(BuildContext context, String researchImageUrl) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OwningPage()
            ));
      },
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(researchImageUrl),
                    fit: BoxFit.cover
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))
            ),
          ),
          Container(
            height: 150,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 200),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
          )
        ],
      ),
    );
  }

  static Widget emptyBoxToAddPage(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateLabPage())
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(230, 230, 230, 100),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Icon(Icons.add_circle_outline, size: 18,),
            SizedBox(width: 10),
            Text('Add Laboratory Page')
          ],
        ),
      ),
    );
  }
}