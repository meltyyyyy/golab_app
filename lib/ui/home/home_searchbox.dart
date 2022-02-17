import 'package:flutter/material.dart';
import 'package:golab/const/feature_list.dart';
import 'package:golab/const/field_of_study.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/main.dart';
import 'package:golab/model/model_search_result.dart';
import 'package:golab/ui/home/custom_search_delegate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchBoxWidget extends HookWidget {
  const SearchBoxWidget({Key? key,}) : super(key: key);

  void transitionToSearchPage(context) async {
    SearchResult? result
    = await showCustomSearch(context: context, delegate: LabSearch());
  }

  @override
  Widget build(BuildContext context) {
    final notifier = useProvider(labListProvider.notifier);
    return GestureDetector(
      onTap: () async {
        SearchResult? result =
        await showCustomSearch(context: context, delegate: LabSearch());
        notifier.search(result!);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 100),borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SizedBox(width: 10),
            Icon(Icons.search,color: Color.fromRGBO(150, 150, 150, 100)),
            SizedBox(width: 5),
            Flexible(
                child: TextField(
                    enabled: false,
                    decoration: InputDecoration(hintText: 'Search...',border: InputBorder.none)
                )
            )
          ],
        ),
      ),
    );
  }
}

class LabSearch extends CustomSearchDelegate<SearchResult> {
  final List<String> _keywords = ResearchKeywords.keywords;
  final List<String> _history = ['AI','VR','Machine Learning'];
  final List<String> _features = LabFeatures.features;
  List<bool> featureChecked = List.filled(LabFeatures.features.length, false);
  final List<String> _fields = FieldsOfStudy.fields;
  List<bool> fieldChecked = List.filled(FieldsOfStudy.fields.length, false);

  @override
  Widget buildCustomBackButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        final int index = _keywords.indexOf(query);
        final List<String> fields = [];
        final List<String> features = [];
        for(int i = 0; i < _fields.length; i++){
          if(fieldChecked[i]){
            fields.add(_fields[i]);
          }
        }
        for(int i = 0; i < _features.length; i++){
          if(featureChecked[i]){
            features.add(_features[i]);
          }
        }
        final SearchResult result =
        SearchResult(index: index, fields: fields, features: features);
        close(context,result);
      },
      icon: const Icon(Icons.search_outlined),
    );
  }

  @override
  Widget buildCustomSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? _history
        : _keywords.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
          onTap: (){ query = _keywords[index]; },
          leading: const Icon(Icons.search_outlined),
          title: Text(_keywords[index]),
        )
    );
  }

  @override
  Widget buildFeatures(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _features.length,
            itemBuilder: (context, index) =>
                ListTile(
                  leading: Checkbox(
                      value: featureChecked[index],
                      onChanged: (bool? value) {
                        setState(() => featureChecked[index] = !featureChecked[index]);
                      }),
                  title: Text(_features[index]),
                ),
          );
        }
    );
  }


    @override
    Widget buildFieldsOfStudy(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return ListView.builder(
              shrinkWrap:
              true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _fields.length,
              itemBuilder: (context, index) => ListTile(
                leading: Checkbox(
                  onChanged: (bool? value) {
                    setState(() => fieldChecked[index] = !fieldChecked[index]);
                  },
                  value: fieldChecked[index],
                ),
                title: Text(_fields[index]),
              )
          );
        }
    );
  }
}