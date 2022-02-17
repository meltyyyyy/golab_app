import 'package:golab/const/feature_list.dart';
import 'package:golab/const/keyword_list.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/model/model_lab_state.dart';
import 'package:golab/repository/repository_lab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:state_notifier/state_notifier.dart';
import 'dart:io';

class LabViewModel extends StateNotifier<LabState> {
  LabViewModel() : super(const LabState()) { getLabData(); }

  Future<void> getLabData() async {
    state = state.copyWith(isLoading: true);
    final bool hasPage = await LabRepository.checkAlreadyHasPage();
    if(hasPage){
      try{
        final Lab lab = await LabRepository.fetchLabData();
        state = state.copyWith(
          location: lab.location,
          avatarImageUrl: lab.avatarImageUrl,
          labName: lab.labName,
          ownerId: lab.ownerId,
          link: lab.link,
          email: lab.email,
          application: lab.application,
          university: lab.university,
          researchImageUrl: lab.researchImageUrl,
          field: lab.field,
          keywords: lab.keywords,
          description: lab.description,
          tagline: lab.tagline,
          features: lab.features,
          isLoading: false,
        );
      } catch (_){
        print(_);
      }
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateLabData()async {
    final Lab lab = Lab(
      keywords: state.keywords,
      university: state.university,
      features: state.features,
      link: state.link,
      location: state.location,
      description: state.description,
      application: state.application,
      field: state.field,
      labName: state.labName,
      researchImageUrl: state.researchImageUrl,
      tagline: state.tagline,
      avatarImageUrl: state.avatarImageUrl,
      ownerId: state.ownerId,
      email: state.email,
    );
    await LabRepository.updateLabData(lab);
  }

  void updateUniversity(String title){
    state = state.copyWith(university: title);
  }

  void updateLabName(String title){
    state = state.copyWith(labName: title);
  }

  void updateLocation(String title){
    state = state.copyWith(location: title);
  }

  void updateLink(String title){
    state = state.copyWith(link: title);
  }

  void updateDescription(String title){
    state = state.copyWith(description: title);
  }

  void updateApplication(String title){
    state = state.copyWith(application: title);
  }

  void updateTagline(String title){
    state = state.copyWith(tagline: title);
  }

  void updateField(String title){
    state = state.copyWith(field: title);
  }

  void updateFeatures(String title){
    final newList = state.features;
    final isChecked = newList.contains(title);
    if(isChecked){
      newList.remove(title);
    } else {
      newList.add(title);
    }
    print(newList);
    state = state.copyWith(features: newList);
  }

  bool isChecked(int index){
    final features = LabFeatures.features;
    return state.features.contains(features[index]);
  }

  void updateKeywords(List<dynamic> newList){
    state = state.copyWith(keywords: newList);
  }

  Future<void> updateResearchImageUrl() async {
    final picker = ImagePicker();
    final String newResearchImageUrl;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final file = File(pickedFile.path);
      newResearchImageUrl = await LabRepository.uploadImage('user/background_image/', file);
      state = state.copyWith(researchImageUrl: newResearchImageUrl);
    }
  }
}