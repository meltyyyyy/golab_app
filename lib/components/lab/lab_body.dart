import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/plugin/url_launcher.dart';
import 'package:golab/components/general/flexible_inputbox.dart';
import 'package:golab/components/general/inputbox.dart';

import '../general/keyword.dart';

class LabBodyComponent {

  static Widget flexibleInputBox(String title, Function _getInput) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        FlexibleInputBoxWidget(getInput: _getInput),
        const SizedBox(height: 10),
      ],
    );
  }

  static inputBox(String title, Function _getInput){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        InputBoxWidget(boxTitle: title, getInput: _getInput),
        const SizedBox(height: 10)
      ],
    );
  }

  static Widget keywords(List<dynamic> keywords) {
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
              for(int i = 0; i < ResearchKeywords.keywords.length; i++)
                if(keywords[i])
                  KeywordWidget(keyword: ResearchKeywords.keywords[i]),
            ]
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget updateKeywords(List<dynamic> keywords, Function()? _onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: <Widget>[
            const Text('Keywords',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
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
              for(int i = 0;i < ResearchKeywords.keywords.length;i++)
                if(keywords[i]) KeywordWidget(keyword: ResearchKeywords.keywords[i]),
            ]
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static Widget location(String university, String labName) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.location_on),
              Text(university)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.build_outlined),
              Text(labName)
            ],
          )
        ],
      ),
    );
  }

  static Widget article(String content, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        Text(content),
        const SizedBox(height: 15),
      ],
    );
  }

  static Widget information(IconData iconData, String title) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 10),
            Text(title)
          ],
        )
    );
  }

  static Widget displayLink(String link) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.link),
            const SizedBox(width: 10),
            Linkify(
              text: link,
              onOpen: (LinkableElement url) => UrlLauncher.openLink(url: url.toString()),
            )
          ],
        )
    );
  }

  static Widget displayFeatures(List<dynamic> features) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.star),
            const SizedBox(width: 10),
            Expanded(
              child: Wrap(
                  direction: Axis.horizontal,
                  children: features.map((feature) => Text(feature + ' / ')).toList()
              ),
            )
          ],
        )
    );
  }
}