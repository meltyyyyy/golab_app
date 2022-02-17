import 'package:flutter/material.dart';
import 'package:golab/components/general/select_keywords.dart';
import 'package:golab/components/lab/lab_appbar.dart';
import 'package:golab/components/lab/lab_body.dart';
import 'package:golab/const/feature_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../main.dart';

class EditLabPage extends HookWidget {
  const EditLabPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditLabPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useProvider(labProvider);
    final notifier = useProvider(labProvider.notifier);

    return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back), 
                  onPressed: () async {
                    await notifier.getLabData();
                    Navigator.pop(context);
                  },
                ),
                pinned: true,
                actions: [
                  TextButton(
                      onPressed: () async {
                        await notifier.updateLabData();
                        await notifier.getLabData();
                        Navigator.pop(context);
                      },
                      child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 14))
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        LabAppBarComponent.researchImage(context, state.researchImageUrl),
                        LabAppBarComponent.backgroundFilter(context),
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: LabAppBarComponent.
                          updateResearchImage(() async { await notifier.updateResearchImageUrl(); }),
                        ),
                      ],
                    )
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          LabBodyComponent.inputBox('Tagline', (text) { notifier.updateTagline(text); }),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.updateKeywords(
                            state.keywords,
                                  () async {
                              final newKeywords = await SelectKeywords.push(context, state.keywords);
                              notifier.updateKeywords(newKeywords);
                            }
                          ),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.inputBox('Field of Study', (text) { notifier.updateField(text); } ),
                          const Divider(thickness: 0.5),
                          _buildRadioButton(),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.inputBox('University', (text) { notifier.updateUniversity(text); }),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.inputBox('Laboratory Name', (text) { notifier.updateLabName(text); }),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.flexibleInputBox('Description', (text) { notifier.updateDescription(text); }),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.flexibleInputBox('Application', (text) { notifier.updateApplication(text); }),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.inputBox('Location', (text) { notifier.updateLocation(text); }),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.inputBox('Link', (text) { notifier.updateLink(text); })
                        ]
                    )
                ),
              ),
            ],
          ),
        )
    );
  }

  Column _buildRadioButton(){
    final features = LabFeatures.features;
    final labNotifier = useProvider(labProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Features',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            itemBuilder: (context, index) => ListTile(
              leading: Checkbox(
                onChanged: (bool? value) {
                  labNotifier.updateFeatures(features[index]);
                },
                value: labNotifier.isChecked(index),
              ),
              title: Text(features[index]),
            )
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}