import 'package:flutter/material.dart';
import 'package:golab/components/lab/lab_appbar.dart';
import 'package:golab/components/lab/lab_body.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/plugin/url_launcher.dart';

class LabPage extends StatelessWidget {
  final Lab lab;
  const LabPage({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        LabAppBarComponent.researchImage(context, lab.researchImageUrl),
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
                          LabBodyComponent.keywords(lab.keywords),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.location(lab.university, lab.labName),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.article(lab.description, 'Description'),
                          const Divider(thickness: 0.5),
                          LabBodyComponent.article(lab.application, 'Application'),
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
                          Text(lab.labName, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          LabBodyComponent.information(Icons.location_on, lab.location),
                          const SizedBox(height: 4),
                          LabBodyComponent.displayLink(lab.link),
                          const SizedBox(height: 4),
                          LabBodyComponent.information(Icons.flag, lab.field),
                          const SizedBox(height: 4),
                          LabBodyComponent.displayFeatures(lab.features),
                          const SizedBox(height: 50),
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      floatingActionButton: InkWell(
        onTap: () => UrlLauncher.openEmail(toEmail: lab.email, subject: '', body: ''),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight
                ),
                borderRadius: BorderRadius.circular(25)
            ),
            child: const Text('Want to Visit', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}