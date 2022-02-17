import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:golab/model/model_researcher.dart';
import 'package:golab/repository/repository_auth.dart';
import 'dart:io';
import 'package:path/path.dart';

class ResearcherRepository{
  static final CollectionReference collectionReference = FirebaseFirestore.instance.collection('researchers');

  static Future<Researcher> fetchResearcherData() async {
    final docId = AuthRepository.auth.currentUser!.uid;

    final researcherDoc = await FirebaseFirestore
        .instance
        .collection('researchers')
        .doc(docId)
        .get();

    print(researcherDoc.data());

    final Researcher researcher = Researcher.fromDocumentSnapshot(researcherDoc);

    return researcher;
  }
  
  static Future<void> createLabPage(String labId, String labName) async {
    final docId = AuthRepository.auth.currentUser!.uid;
    await collectionReference.doc(docId).update({'labId': labId, 'labName': labName, 'hasPage': true});
  }

  static void updateResearcherData(Researcher user) {
    final docId = AuthRepository.auth.currentUser!.uid;
    final Map<String,dynamic> data = {
      'name': user.name,
      'university': user.university,
      'graduateSchool': user.graduateSchool,
      'keywords': user.keywords,
      'tagline': user.tagline,
      'labName': user.labName
    };

    print('start updating');
    FirebaseFirestore
        .instance
        .collection('researchers')
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