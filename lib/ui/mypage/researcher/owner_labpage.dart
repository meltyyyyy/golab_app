import 'package:flutter/material.dart';
import 'package:golab/components/lab/lab_appbar.dart';
import 'package:golab/components/lab/lab_body.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../main.dart';
import 'editing_page_lab.dart';

class OwningPage extends HookWidget {
  const OwningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(labProvider);

    return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                actions: <Widget>
                [
                  IconButton(
                    onPressed: () => EditLabPage.push(context),
                    icon: const Icon(Icons.edit),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        LabAppBarComponent.researchImage(context, state.researchImageUrl),
                        LabAppBarComponent.backgroundFilter(context),
                      ],
                    )
                ),
              ),
              SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate(
                          [
                            LabBodyComponent.keywords(state.keywords),
                            const Divider(thickness: 2),
                            LabBodyComponent.location(state.university, state.labName),
                            const Divider(thickness: 2),
                            LabBodyComponent.article(state.description, 'Description'),
                            const Divider(thickness: 2),
                            LabBodyComponent.article(state.application, 'Application')
                          ]
                      )
                  ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    decoration: const BoxDecoration(color: Color.fromRGBO(230, 230, 230, 100)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(state.labName, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          LabBodyComponent.information(Icons.location_on, state.location),
                          const SizedBox(height: 4),
                          LabBodyComponent.displayLink(state.link),
                          const SizedBox(height: 4),
                          LabBodyComponent.information(Icons.flag, state.field),
                          const SizedBox(height: 4),
                          LabBodyComponent.displayFeatures(state.features),
                          const SizedBox(height: 4),
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
        )
    );
  }
}
