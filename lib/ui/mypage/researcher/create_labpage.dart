import 'package:flutter/material.dart';
import 'package:golab/const/feature_list.dart';
import 'package:golab/main.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/repository/repository_auth.dart';
import 'package:golab/repository/repository_lab.dart';
import 'package:golab/ui/mypage/researcher/preview_labpage.dart';
import 'package:golab/components/general/flexible_inputbox.dart';
import 'package:golab/components/general/inputbox.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/widget/mypage_button.dart';
import 'package:golab/components/general/wrap_toggle_buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final linkProvider = StateProvider.autoDispose((ref) => '');
final universityProvider = StateProvider.autoDispose((ref) => '');
final descriptionProvider = StateProvider.autoDispose((ref) => '');
final applicationProvider = StateProvider.autoDispose((ref) => '');
final locationProvider = StateProvider.autoDispose((ref) => '');
final labNameProvider = StateProvider.autoDispose((ref) => '');
final researchImageUrlProvider = StateProvider.autoDispose((ref) => 'https://firebasestorage.googleapis.com/v0/b/golab-73336.appspot.com/o/laboratory%2Ffreddie-marriage-vSchPA-YA_A-unsplash.jpg?alt=media&token=3f8e420e-abc6-4e0a-a8d6-011c0839a67c');
final taglineProvider = StateProvider.autoDispose((ref) => '');
final fieldProvider = StateProvider.autoDispose((ref) => '');
final featuresProvider = StateProvider.autoDispose((ref) => []);
final isCheckedProvider = StateProvider.autoDispose((ref) => List.filled(LabFeatures.features.length, false));

class CreateLabPage extends HookWidget {
  const CreateLabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final link = useProvider(linkProvider);
    final university = useProvider(universityProvider);
    final description = useProvider(descriptionProvider);
    final application = useProvider(applicationProvider);
    final location = useProvider(locationProvider);
    final labName = useProvider(labNameProvider);
    final researchImageUrl = useProvider(researchImageUrlProvider);
    final tagline = useProvider(taglineProvider);
    final researcherState = useProvider(researcherProvider);
    final field = useProvider(fieldProvider);
    final features = useProvider(featuresProvider);

    return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectLabKeywords(
                                link: link.state,
                                application: application.state,
                                labName: labName.state,
                                tagline: tagline.state,
                                university: university.state,
                                location: location.state,
                                description: description.state,
                                researchImageUrl:
                                researchImageUrl.state,
                                avatarImageUrl: researcherState.avatarImageUrl,
                                features: features.state,
                                field: field.state,
                                ownerId: researcherState.id,
                              )
                          )
                      );
                    },
                    child: const Text('Proceed', style: TextStyle(color: Colors.white, fontSize: 14))
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      _buildBackgroundImageContainer(context),
                      _buildBackgroundFilter(context),
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: _buildUploadImageContainer(),
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
                            _buildInputBox('Tagline', (text) { tagline.state = text; }),
                            const Divider(thickness: 0.5),
                            _buildInputBox('Field of Study', (text) { field.state = text; } ),
                            const Divider(thickness: 0.5),
                            _buildRadioButton(),
                            const Divider(thickness: 0.5),
                            _buildInputBox('University', (text) { university.state = text; }),
                            const Divider(thickness: 0.5),
                            _buildInputBox('Laboratory Name', (text) { labName.state = text; }),
                            const Divider(thickness: 0.5),
                            _buildFlexibleInputBox('Description', (text) { description.state = text; }),
                            const Divider(thickness: 0.5),
                            _buildFlexibleInputBox('Application', (text) { application.state = text; }),
                            const Divider(thickness: 0.5),
                            _buildInputBox('Location', (text) { location.state = text; }),
                            const Divider(thickness: 0.5),
                            _buildInputBox('Link', (text) { link.state = text; })
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
    final features = useProvider(featuresProvider);
    final isChecked = useProvider(isCheckedProvider);
    final featureList = LabFeatures.features;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Features',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        StatefulBuilder(builder: (BuildContext context, StateSetter setState){
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: LabFeatures.features.length,
              itemBuilder: (context, index) =>
                  ListTile(
                    leading: Checkbox(
                      value: isChecked.state[index],
                      onChanged: (bool? value) {
                        setState(() {
                          if(isChecked.state[index]){
                            features.state.remove(featureList[index]);
                            isChecked.state[index] = !isChecked.state[index];
                          } else {
                            features.state.add(featureList[index]);
                            isChecked.state[index] = !isChecked.state[index];
                          }
                        });
                      },
                    ),
                    title: Text(featureList[index]),
                  )
          );
        }),
        const SizedBox(height: 10),
      ],
    );
  }

  InkWell _buildUploadImageContainer() {
    final researchImageUrl = useProvider(researchImageUrlProvider);

    return InkWell(
      onTap: () async {
        final picker = ImagePicker();
        final String newResearchImageUrl;
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if(pickedFile != null){
          final file = File(pickedFile.path);
          newResearchImageUrl = await LabRepository.uploadImage('user/background_image/', file);
          researchImageUrl.state = newResearchImageUrl;
        }
      },
      child: SizedBox(
        height: 250,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.camera_alt_outlined,color: Colors.white,size: 24),
            SizedBox(width: 25),
            Text('Upload Research Image',style: TextStyle(color: Colors.white,fontSize: 18))
          ],
        ),
      ),
    );
  }

  SizedBox _buildBackgroundImageContainer(BuildContext context) {
    final researchImageUrl = useProvider(researchImageUrlProvider);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.network(researchImageUrl.state, fit: BoxFit.cover)
    );
  }

  Container _buildBackgroundFilter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 200)),
    );
  }

  Column _buildFlexibleInputBox(String title, Function _getInput){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        FlexibleInputBoxWidget(getInput: _getInput),
        const SizedBox(height: 10),
      ],
    );
  }

  Column _buildInputBox(String title, Function _getInput){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 1.5)),
        const SizedBox(height: 15),
        InputBoxWidget(boxTitle: title, getInput: _getInput),
        const SizedBox(height: 10)
      ],
    );
  }
}

class SelectLabKeywords extends StatefulWidget {
  final String tagline;
  final String university;
  final String labName;
  final String description;
  final String application;
  final String location;
  final String link;
  final String researchImageUrl;
  final String avatarImageUrl;
  final String field;
  final String ownerId;
  final List<dynamic> features;

  const SelectLabKeywords({
    Key? key,
    required this.tagline,
    required this.university,
    required this.labName,
    required this.description,
    required this.application,
    required this.location,
    required this.link,
    required this.researchImageUrl,
    required this.avatarImageUrl,
    required this.features,
    required this.field,
    required this.ownerId
  }) : super(key: key);

  @override
  State<SelectLabKeywords> createState() => _SelectLabKeywordsState();
}

class _SelectLabKeywordsState extends State<SelectLabKeywords> {
  List<bool> isSelected = List.filled(ResearchKeywords.keywords.length, false);

  void _onTap(int index){
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  void preview(List<bool> _isSelected){
    final user = AuthRepository.getCurrentUser();
    final Lab lab = Lab(
      tagline: widget.tagline,
      application: widget.application,
      link: widget.link,
      labName: widget.labName,
      location: widget.labName,
      avatarImageUrl: widget.avatarImageUrl,
      field: widget.field,
      researchImageUrl: widget.researchImageUrl,
      university: widget.university,
      keywords: _isSelected,
      description: widget.description,
      features: widget.features,
      ownerId: widget.ownerId,
      email: user!.email as String,
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreviewLabPage(lab: lab)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () { Navigator.pop(context); },
                        icon: const Icon(Icons.arrow_back, color: Colors.black54,)
                    ),
                    InkWell(
                        onTap: () { preview(isSelected); },
                        child: const CustomButton(title: 'Proceed')),
                  ]
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Research Keywords',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                WrapToggleTextButtons(
                  textList: ResearchKeywords.keywords,
                  isSelected: isSelected,
                  onTap: (int index) { _onTap(index); },
                ),
              ],
            ),
          )
      ),
    );
  }
}

