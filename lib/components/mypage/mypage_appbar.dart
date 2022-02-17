import 'package:flutter/material.dart';
import 'package:golab/const/account_type.dart';
import 'package:golab/const/color.dart';

class AppBarComponents {
  static Widget backgroundImage(BuildContext context,String backgroundImageUrl) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Image.network(backgroundImageUrl,fit: BoxFit.cover)
    );
  }

  static Widget updateBackgroundImage(Function updateBackgroundImage) {
    return SizedBox(
      height: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              updateBackgroundImage;
            },
            icon: const Icon(
                Icons.camera_alt_outlined, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 25),
          const Text('Upload Cover Image',
              style: TextStyle(color: Colors.white, fontSize: 18))
        ],
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

  static Widget faceIcon(String avatarImageUrl) {
    return Align(
      alignment: Alignment.centerRight,
      child: CircleAvatar(
          radius: 35,
          backgroundColor: AppColor.background,
          backgroundImage: NetworkImage(avatarImageUrl)
      ),
    );
  }

  static Widget updateFaceIcon(String avatarImageUrl, Function updateAvatarImage) {
    return Align(
      alignment: Alignment.centerRight,
      child: Stack(
          children: <Widget>[
            CircleAvatar(
                radius: 35,
                backgroundColor: AppColor.background,
                backgroundImage: NetworkImage(avatarImageUrl)
            ),
            Positioned(
                left: 11,
                top: 12,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt_outlined,color: Colors.white,size: 24),
                  onPressed: () { updateAvatarImage; },
                )
            ),
          ]
      ),
    );
  }

  static Widget profileColumn(String university, String school, String name, AccountType accountType) {
    final String type;
    if(accountType == AccountType.researcher){
      type = 'RESEARCHER';
    } else {
      type = 'STUDENT';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(type,style: TextStyle(color: Colors.white,letterSpacing: 1.5,fontSize: 14)),
        Text(name,style: const TextStyle(color: Colors.white,letterSpacing: 1.5,fontSize: 28,fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(university,style: const TextStyle(color: Colors.white,letterSpacing: 1.5)),
            const SizedBox(width: 5),
            Text(school,style: const TextStyle(color: Colors.white,letterSpacing: 1.5)),
          ],
        ),
      ],
    );
  }
}