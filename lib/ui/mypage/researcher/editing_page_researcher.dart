import 'package:flutter/material.dart';
import 'package:golab/components/general/select_keywords.dart';
import 'package:golab/components/mypage/mypage_appbar.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:golab/components/mypage/mypage_body.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/components/general/inputbox.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../main.dart';

class EditingResearcherPage extends StatelessWidget {
  const EditingResearcherPage({Key? key}) : super(key: key);

  static Future push(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditingResearcherPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            EditingResearcherAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: EditingResearcherBody(),
            )
          ],
        ),
      ),
    );
  }
}


class EditingResearcherAppBar extends HookWidget {
  const EditingResearcherAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(researcherProvider);
    final notifier = useProvider(researcherProvider.notifier);

    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          notifier.getResearcherData();
          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              notifier.updateResearcherData();
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16))
        )
      ],
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              AppBarComponents.backgroundImage(context, state.backgroundImageUrl),
              AppBarComponents.backgroundFilter(context),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: AppBarComponents.updateBackgroundImage(notifier.updateBackgroundImage),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 45),
                  child: AppBarComponents.updateFaceIcon(
                      state.avatarImageUrl,
                      notifier.updateAvatarImage
                  )
              ),
            ],
          )
      ),
    );
  }
}

class EditingResearcherBody extends HookWidget {
  final List<String> list = ResearchKeywords.keywords;
  final int listLength = ResearchKeywords.keywords.length;

  EditingResearcherBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(researcherProvider);
    final notifier = useProvider(researcherProvider.notifier);

    return SliverList(
        delegate: SliverChildListDelegate(
            [
              BodyComponents.editProfile('Name', (String title) { notifier.updateName(title); }),
              const Divider(thickness: 0.5),
              BodyComponents.editProfile('Tagline',(String title) { notifier.updateTagline(title); }),
              const Divider(thickness: 0.5),
              BodyComponents.updateInterests(
                      () async {
                    final newKeywords = await SelectKeywords.push(context, state.keywords);
                    notifier.updateKeywords(newKeywords);
                  },
                  state.keywords
              ),
              const Divider(thickness: 0.5),
              _buildEducationInputBoxes(context),
            ]
        )
    );
  }

  Column _buildEducationInputBoxes(BuildContext context) {
    final notifier = useProvider(researcherProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Education',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        InputBoxWidget(
            boxTitle: 'University',
            getInput: (String university)  { notifier.updateUniversity(university); }
        ),
        const SizedBox(height: 10),
        InputBoxWidget(
          boxTitle: 'Graduate School',
          getInput: (String school) { notifier.updateGraduateSchool(school); },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}


