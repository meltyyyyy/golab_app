import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:golab/components/mypage/mypage_appbar.dart';
import 'package:golab/components/mypage/mypage_body.dart';
import 'package:golab/const/account_type.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/ui/mypage/student/editing_page_student.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../main.dart';
import '../setting_page.dart';

class StudentPage extends HookWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(studentProvider);

    Widget _body;
    Widget _mypage = CustomScrollView(
      slivers: [
        const StudentAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: StudentBody(),
        )
      ],
    );
    const Widget _progress = Center(
      child: CircularProgressIndicator(
        semanticsLabel: 'Now Loading',
      ),
    );

    switch (state.isLoading) {
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

class StudentAppBar extends HookWidget {
  const StudentAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(studentProvider);
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      actions: <Widget>[
        IconButton(
            onPressed: () => EditingStudentPage.push(context),
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
                child: AppBarComponents.profileColumn(state.university, state.school, state.name, AccountType.student),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 45),
                  child: AppBarComponents.faceIcon(state.avatarImageUrl)
              ),
            ],
          )
      ),
    );
  }
}

class StudentBody extends HookWidget {
  final int listLength = ResearchKeywords.keywords.length;

  StudentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(studentProvider);

    return SliverList(
        delegate: SliverChildListDelegate(
            [
              BodyComponents.tagline(state.tagline),
              const Divider(thickness: 0.5),
              BodyComponents.interests(state.interests),
              const Divider(thickness: 0.5),
              BodyComponents.education(state.university, state.school, state.department, AccountType.student),
            ]
        )
    );
  }
}