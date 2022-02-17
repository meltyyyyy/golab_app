import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:golab/components/mypage/mypage_appbar.dart';
import 'package:golab/components/mypage/mypage_body.dart';
import 'package:golab/components/mypage/researcher/researcher_components.dart';
import 'package:golab/const/account_type.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/ui/mypage/researcher/editing_page_researcher.dart';
import 'package:golab/ui/mypage/setting_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../main.dart';

class ResearcherPage extends HookWidget {
  const ResearcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final researcherState = useProvider(researcherProvider);
    Widget _body;

    //show progress indicator while loading
    const _progress = const Center(
      child: CircularProgressIndicator(
        semanticsLabel: 'Now Loading',
      ),
    );
    Widget _mypage = CustomScrollView(
      slivers: [
        const ResearcherAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: ResearcherBody(),
        )
      ],
    );

    switch (researcherState.isLoading) {
      case true:
        _body = _progress;
        break;
      case false:
        _body = _mypage;
        break;
      default:
        _body = _progress;
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: _body,
      ),
    );
  }
}

class ResearcherAppBar extends HookWidget {
  const ResearcherAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(researcherProvider);

    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      actions: <Widget>[
        IconButton(
            onPressed: () => EditingResearcherPage.push(context),
            icon: const Icon(Icons.edit)
        ),
        IconButton(
            onPressed: () => SettingPage.push(context),
            icon: const Icon(Icons.settings)
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              AppBarComponents.backgroundImage(context, state.backgroundImageUrl),
              AppBarComponents.backgroundFilter(context),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: AppBarComponents.profileColumn(
                    state.university,
                    state.graduateSchool,
                    state.name,
                    AccountType.researcher
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 45),
                child: AppBarComponents.faceIcon(state.avatarImageUrl),
              ),
            ],
          )
      ),
    );
  }
}

class ResearcherBody extends HookWidget {
  final int listLength = ResearchKeywords.keywords.length;
  final state = useProvider(researcherProvider);

  ResearcherBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(
            [
              BodyComponents.tagline(state.tagline),
              const Divider(thickness: 0.5),
              BodyComponents.interests(state.keywords),
              const Divider(thickness: 0.5),
              BodyComponents.education(state.university, state.graduateSchool, '', AccountType.researcher),
              const Divider(thickness: 0.5),
              _buildLabPageColumn(context),
            ]
        )
    );
  }

  Column _buildLabPageColumn(BuildContext context) {
    final researcherState = useProvider(researcherProvider);
    final labState = useProvider(labProvider);

    Widget _body;
    Widget _hasPage;
    final Widget _loaded = ResearcherComponents.imageBoxForOwningPage(context, labState.researchImageUrl);
    final Widget _addPage = ResearcherComponents.emptyBoxToAddPage(context);
    final Widget _loading = Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 200),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );

    switch(labState.researchImageUrl == ''){
      case true:
        _hasPage = _loading;
        break;
      case false:
        _hasPage = _loaded;
        break;
      default:
        _hasPage = _loading;
        break;
    }

    if(researcherState.hasPage){
      _body = _hasPage;
    } else {
      _body = _addPage;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Laboratory Page', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        _body,
        const SizedBox(height: 10),
      ],
    );
  }
}

