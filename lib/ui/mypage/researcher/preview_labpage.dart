import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/components/general/keyword.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../main.dart';

class PreviewLabPage extends StatelessWidget {
  final Lab lab;
  const PreviewLabPage({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBarWidget(lab: lab),
              SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverListWidget(lab: lab)
              ),
              SliverContainerWidget(lab: lab)
            ],
          ),
        )
    );
  }
}

class SliverAppBarWidget extends HookWidget {
  final Lab lab;
  const SliverAppBarWidget({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      actions: <Widget>[ _buildCreateTextButton(context) ],
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              _buildBackgroundImageContainer(context),
              _buildBackgroundFilter(context),
            ],
          )
      ),
    );
  }

  SizedBox _buildBackgroundImageContainer(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.network(lab.researchImageUrl, fit: BoxFit.cover)
    );
  }

  Container _buildBackgroundFilter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 200)),
    );
  }

  TextButton _buildCreateTextButton(BuildContext context) {
    final researcherNotifier = useProvider(researcherProvider.notifier);

    return TextButton(
      onPressed: () async {
        int count = 0;
        await researcherNotifier.createLabPage(lab);
        Navigator.popUntil(context, (_) => count++ >= 3);
      },
      child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}

class SliverListWidget extends StatelessWidget {
  final Lab lab;
  const SliverListWidget({Key? key,required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(
            [
              _buildKeywordsContainer(),
              const Divider(thickness: 2),
              _buildLocationContainer(),
              const Divider(thickness: 2),
              _buildDescriptionColumn(),
              const Divider(thickness: 2),
              _buildApplicationColumn()
            ]
        )
    );
  }

  Column _buildApplicationColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Application',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        Text(lab.application),
        const SizedBox(height: 15),
      ],
    );
  }

  Column _buildDescriptionColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        Text(lab.description),
        const SizedBox(height: 30),
      ],
    );
  }

  Column _buildKeywordsContainer() {
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
                if(lab.keywords[i])
                  KeywordWidget(keyword: ResearchKeywords.keywords[i]),
            ]
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Container _buildLocationContainer() {
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
              Text(lab.university)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.build_outlined),
              Text(lab.labName)
            ],
          )
        ],
      ),
    );
  }
}

class SliverContainerWidget extends StatelessWidget {
  final Lab lab;
  const SliverContainerWidget({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(230, 230, 230, 100)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(lab.labName, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 10),
                        Text(lab.location)
                      ],
                    )
                ),
                const SizedBox(height: 4),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.link),
                        const SizedBox(width: 10),
                        Linkify(
                          text: lab.link,
                          onOpen: _onOpen,
                        )
                      ],
                    )
                ),
                const SizedBox(height: 4),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.flag),
                        const SizedBox(width: 10),
                        Text(lab.field),
                      ],
                    )
                ),
                const SizedBox(height: 4),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.star),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Wrap(
                              direction: Axis.horizontal,
                              children: lab.features.map((feature) => Text(feature + ' / ')).toList()
                          ),
                        )
                      ],
                    )
                ),
                const SizedBox(height: 4),
              ],
            ),
          )
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if(await canLaunch(link.url)){
      await launch(link.url);
    }else{
      throw 'Could not launch $link';
    }
  }
}