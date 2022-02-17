import 'package:golab/const/keyword_list.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/model/model_researcher.dart';
import 'package:golab/model/model_researcher_state.dart';
import 'package:golab/repository/repository_lab.dart';
import 'package:golab/repository/repository_researcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:state_notifier/state_notifier.dart';
import 'dart:io';

class ResearcherViewModel extends StateNotifier<ResearcherState> with LocatorMixin{
  ResearcherViewModel() : super(const ResearcherState()) { getResearcherData(); }

  ResearcherRepository get researcherRepository => read<ResearcherRepository>();

  Future<void> getResearcherData() async {
    state = state.copyWith(isLoading: true);
    try{
      final Researcher researcher = await ResearcherRepository.fetchResearcherData();
      state = state.copyWith(
          id: researcher.id,
          name: researcher.name,
          university: researcher.university,
          graduateSchool: researcher.graduateSchool,
          avatarImageUrl: researcher.avatarImageUrl,
          backgroundImageUrl: researcher.backgroundImageUrl,
          labName: researcher.labName,
          isLoading: false,
          keywords: researcher.keywords,
          hasPage: researcher.hasPage,
          tagline: researcher.tagline,
      );
    } catch (_){
      print(_);
    }
  }

  void updateResearcherData(){
    final Researcher researcher = Researcher(
        id: state.id,
        university: state.university,
        graduateSchool: state.graduateSchool,
        name: state.name,
        avatarImageUrl: state.avatarImageUrl,
        backgroundImageUrl: state.backgroundImageUrl,
        keywords: state.keywords,
        labName: state.labName,
        hasPage: state.hasPage,
        tagline: state.tagline
    );
    ResearcherRepository.updateResearcherData(researcher);
  }

  Future<void> createLabPage(Lab lab) async {
    final String labId = await LabRepository.setLabPage(lab);
    await ResearcherRepository.createLabPage(labId, lab.labName);
    await getResearcherData();
  }

  Future<bool> hasPage() async {
    return await LabRepository.checkAlreadyHasPage();
  }

  void updateUniversity(String title){
    state = state.copyWith(university: title);
  }

  void updateHasPage(){
    state = state.copyWith(hasPage: true);
  }

  void updateGraduateSchool(String title){
    state = state.copyWith(graduateSchool: title);
  }

  void updateName(String title){
    state = state.copyWith(name: title);
  }

  void updateLabName(String title){
    state = state.copyWith(labName: title);
  }

  void updateTagline(String title){
    state = state.copyWith(tagline: title);
  }

  void updateKeywords(List<dynamic> newList){
    state = state.copyWith(keywords: newList);
  }

  Future<void> updateAvatarImage() async {
    final picker = ImagePicker();
    final String newAvatarImageUrl;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final file = File(pickedFile.path);
      newAvatarImageUrl = await ResearcherRepository.uploadImage('user/avatar/', file);
      state = state.copyWith(avatarImageUrl: newAvatarImageUrl);
    }
  }

  Future<void> updateBackgroundImage() async {
    final picker = ImagePicker();
    final String newBackgroundImageUrl;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final file = File(pickedFile.path);
      newBackgroundImageUrl = await ResearcherRepository.uploadImage('user/background_image/', file);
      state = state.copyWith(backgroundImageUrl: newBackgroundImageUrl);
    }
  }
}