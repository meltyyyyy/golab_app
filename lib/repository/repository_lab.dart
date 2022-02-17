import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/repository/repository_auth.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LabRepository{
  static final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('laboratories');

  static Future<Lab> fetchLabData() async {
    final labId = AuthRepository.auth.currentUser!.uid;
    final labDoc = await collectionReference.doc(labId).get();

    print(labDoc.data());

    final Lab lab = Lab.fromDocumentSnapshot(labDoc);

    return lab;
  }

  static Future<String> setLabPage(Lab lab) async {
    final labId = AuthRepository.auth.currentUser!.uid;
    final labDoc = collectionReference.doc(labId);
    await labDoc.set({
      'application': lab.application,
      'avatarImageUrl': lab.avatarImageUrl,
      'description': lab.description,
      'features': lab.features,
      'field': lab.field,
      'keywords': lab.keywords,
      'labName': lab.labName,
      'link': lab.link,
      'location': lab.location,
      'researchImageUrl': lab.researchImageUrl,
      'tagline': lab.tagline,
      'university': lab.university,
      'ownerId': lab.ownerId,
      'email': lab.email
    });
    return labDoc.id;
  }

  static Future<bool> checkAlreadyHasPage() async {
    final userId = AuthRepository.auth.currentUser!.uid;
    final withdrawPage = await collectionReference.doc(userId).get();

    return withdrawPage.exists;
  }

  static Future<void> updateLabData(Lab lab) async {
    final labId = AuthRepository.auth.currentUser!.uid;
    final Map<String,dynamic> data = {
      'application': lab.application,
      'avatarImageUrl': lab.avatarImageUrl,
      'description': lab.description,
      'features': lab.features,
      'field': lab.field,
      'keywords': lab.keywords,
      'labName': lab.labName,
      'link': lab.link,
      'location': lab.location,
      'researchImageUrl': lab.researchImageUrl,
      'tagline': lab.tagline,
      'university': lab.university,
      'ownerId': lab.ownerId,
      'email': lab.email
    };
    print('start updating');
    await collectionReference.doc(labId).update(data);
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