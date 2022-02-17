import 'package:golab/const/keyword_list.dart';
import 'package:golab/model/model_student.dart';
import 'package:golab/model/model_student_state.dart';
import 'package:golab/repository/repository_student.dart';
import 'package:image_picker/image_picker.dart';
import 'package:state_notifier/state_notifier.dart';
import 'dart:io';

class StudentViewModel extends StateNotifier<StudentState> with LocatorMixin{
  StudentViewModel() : super(const StudentState()) { getStudentData(); }

  StudentRepository get studentRepository => read<StudentRepository>();

  Future<void> getStudentData() async {
    state = state.copyWith(isLoading: true);
    try{
      Student student = await StudentRepository.fetchStudentData();
      state = state.copyWith(
        id: student.id,
        name: student.name,
        university: student.university,
        school: student.school,
        department: student.department,
        avatarImageUrl: student.avatarImageUrl,
        backgroundImageUrl: student.backgroundImageUrl,
        isLoading: false,
        interests: student.interests,
        tagline: student.tagline
      );
    } catch (_){
      print(_);
    }
  }

  void updateStudentData(){
    final Student student = Student(
      id: state.id,
      university: state.university,
      department: state.department,
      school: state.school,
      name: state.name,
      avatarImageUrl: state.avatarImageUrl,
      backgroundImageUrl: state.backgroundImageUrl,
      interests: state.interests,
      tagline: state.tagline
    );
    StudentRepository.updateStudentData(student);
  }

  void updateDepartment(String title){
    state = state.copyWith(department: title);
  }

  void updateUniversity(String title){
    state = state.copyWith(university: title);
  }

  void updateSchool(String title){
    state = state.copyWith(school: title);
  }

  void updateName(String title){
    state = state.copyWith(name: title);
  }

  void updateTagline(String title){
    state = state.copyWith(tagline: title);
  }

  void updateInterests(List<dynamic> newList) {
    state = state.copyWith(interests: newList);
  }

  Future<void> updateAvatarImage() async {
    final picker = ImagePicker();
    final String newAvatarImageUrl;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final file = File(pickedFile.path);
      newAvatarImageUrl = await StudentRepository.uploadImage('user/avatar/', file);
      state = state.copyWith(avatarImageUrl: newAvatarImageUrl);
    }
  }

  Future<void> updateBackgroundImage() async {
    final picker = ImagePicker();
    final String newBackgroundImageUrl;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final file = File(pickedFile.path);
      newBackgroundImageUrl = await StudentRepository.uploadImage('user/background_image/', file);
      state = state.copyWith(backgroundImageUrl: newBackgroundImageUrl);
    }
  }
}