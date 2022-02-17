import 'package:flutter/material.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/widget/mypage_button.dart';
import 'package:golab/components/general/wrap_toggle_buttons.dart';


class SelectKeywords extends StatefulWidget {
  final List<dynamic> keywords;

  SelectKeywords({Key? key, required this.keywords,}) : super(key: key);

  static Future push(BuildContext context, List<dynamic> keywords) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectKeywords(keywords: keywords)
        )
    );
  }

  @override
  _SelectKeywordsState createState() => _SelectKeywordsState();
}

class _SelectKeywordsState extends State<SelectKeywords> {
  late List<dynamic> _isSelected = widget.keywords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () => Navigator.pop(context, _isSelected),
                      child: const CustomButton(title: 'Done')),
                ),
                const SizedBox(height: 20),
                const Text('Select Keywords',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                WrapToggleTextButtons(
                  textList: ResearchKeywords.keywords,
                  isSelected: _isSelected,
                  onTap: (int index) {
                    setState(() {
                      _isSelected[index] = !_isSelected[index];
                    });
                  },
                ),
              ],
            ),
          )
      ),
    );
  }
}