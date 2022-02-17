import 'package:flutter/material.dart';
import 'package:golab/const/account_type.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/components/general/inputbox.dart';

import '../general/keyword.dart';

class BodyComponents {

  static Widget tagline(String tagline) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Tagline',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        Text(tagline, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget education(String university, String school, String department,AccountType accountType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Education',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        Text(university, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
        Text(school, style: const TextStyle(fontSize: 12)),
        if(accountType == AccountType.student) ...[
          Text(department, style: const TextStyle(fontSize: 12)),
        ],
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget interests(List<dynamic> keywords) {
    final listLength = ResearchKeywords.keywords.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Keywords',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20.0,
            runSpacing: 15.0,
            children: <Widget>[
              for(int i = 0; i < listLength; i++)
                if(keywords[i]) KeywordWidget(keyword: ResearchKeywords.keywords[i]),
            ]
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget updateInterests(Function()? _onPressed, List<dynamic> interests) {
    final listLength = ResearchKeywords.keywords.length;
    final keywordsList = ResearchKeywords.keywords;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: <Widget>[
            const Text('Interests',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
            const SizedBox(width: 10),
            IconButton(
                onPressed: _onPressed,
                icon: const Icon(Icons.add)
            )
          ],
        ),
        const SizedBox(height: 15),
        Wrap(
            direction: Axis.horizontal,
            spacing: 20.0,
            runSpacing: 15.0,
            children: <Widget>[
              for(int i = 0;i < listLength;i++)
                if(interests[i]) KeywordWidget(keyword: keywordsList[i]),
            ]
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget editProfile(String title, Function update) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        InputBoxWidget(
            boxTitle: title,
            getInput: update,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}