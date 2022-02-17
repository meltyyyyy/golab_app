import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golab/model/model_student.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:golab/repository/repository_auth.dart';
import 'dart:io';
import 'package:path/path.dart';

class StudentRepository {
  static final collection = FirebaseFirestore.instance.collection('students');

  static Future<Student> fetchStudentData() async {
    final docId = AuthRepository.auth.currentUser!.uid;

    final studentDoc = await FirebaseFirestore
        .instance
        .collection('students')
        .doc(docId)
        .get();

    final Student student = Student.fromDocumentSnapshot(studentDoc);

    print(studentDoc.data());

    return student;
  }

  static void updateStudentData(Student user) {
    final docId = AuthRepository.auth.currentUser!.uid;
    final Map<String,dynamic> data = {
      'name': user.name,
      'university': user.university,
      'school': user.school,
      'department': user.department,
      'interests': user.interests,
      'tagline': user.tagline
    };

    print('start updating');
    FirebaseFirestore
        .instance
        .collection('students')
        .doc(docId)
        .update(data);
    print('update is done');
  }

  static Future<String> uploadImage(String path,File file) async {
    final String imageUrl;
    final storageRef = FirebaseStorage.instance.ref(path + basename(file.path));

    print('start uploading');
    try{
      await storageRef.putFile(file);
      print('file uploaded');
    }catch(e){
      print(e);
    }

    imageUrl = await storageRef.getDownloadURL();
    return imageUrl;
  }
}