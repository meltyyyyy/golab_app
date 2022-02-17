import 'package:flutter/material.dart';
import 'package:golab/components/general/flexible_inputbox.dart';
import 'package:golab/widget/mypage_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

class GetDescription extends HookWidget {
  const GetDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final notifier = useProvider(labProvider.notifier);

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
                    onTap: () => Navigator.pop(context),
                    child: const CustomButton(title: 'Done')),
              ),
              const SizedBox(height: 20),
              const Text(
                'Research Description',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              FlexibleInputBoxWidget(
                  getInput: (String input) { notifier.updateDescription(input); }
              )
            ],
          ),
        ),
      ),
    );
  }
}