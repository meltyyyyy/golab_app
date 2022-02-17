import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golab/repository/repository_lab.dart';
import 'package:golab/ui/home/home_laboratorycard.dart';
import 'package:golab/ui/home/home_searchbox.dart';
import 'package:golab/ui/home/home_discover.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../main.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(labListProvider);
    Widget _body;

    switch (state.isLoading){
      case true:
        _body = const Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Now Loading',
          ),
        );
        break;
      case false:
        _body = ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.labList.length + 4,
            itemBuilder: (context, index){
              switch (index){
                case 0:
                  return const DisplayDiscoverWidget();
                case 1:
                  return const SizedBox(height: 15);
                case 2:
                  return const SearchBoxWidget();
                case 3:
                  return const Divider(color: Colors.black12,thickness: 1);
                default:
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      LabCardWidget(lab: state.labList[index - 4]),
                      const SizedBox(height: 15),
                    ],
                  );
              }
            }
        );
        break;
      default:
        _body = const Center(
          child: CircularProgressIndicator( semanticsLabel: 'Now Loading',),
        );
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: _body
      ),
    );
  }
}