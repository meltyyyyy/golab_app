import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:golab/const/keyword_list.dart';

class AuthRepository {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static User? getCurrentUser() {
    return auth.currentUser;
  }

  static Future<User?> signIn(email, password) async {
    final UserCredential authResult = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    return authResult.user;
  }

  static Future<List<String>> checkIsAlreadyUser(email) async {
    final checkList = await auth.fetchSignInMethodsForEmail(email);
    return checkList;
  }

  static Future<bool> isStudent() async {
    final userId = auth.currentUser;
    if(userId == null){
      return false;
    } else {
      final withdrawUser = await firebaseFirestore.collection('students').doc(userId.uid).get();
      return withdrawUser.exists;
    }
  }

  static Future<bool> isResearcher() async {
    final userId = auth.currentUser;
    if(userId == null){
      return false;
    } else {
      final withdrawUser = await firebaseFirestore.collection('researchers').doc(userId.uid).get();
      return withdrawUser.exists;
    }
  }

  static Future<User?> signUp(email, password) async {
    final UserCredential authResult = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    return authResult.user;
  }

  static Future<void> setUser(
      User user, bool type, String name,
      String university, String school, String department,
      String graduateSchool
      ) async {
    if(type){
      await firebaseFirestore.collection('students').doc(user.uid).set({
        'email': user.email,
        'name': name,
        'university': university,
        'school': school,
        'department': department,
        'avatarImageUrl': 'https://firebasestorage.googleapis.com/v0/b/golab-73336.appspot.com/o/user%2Favatar%2FLearning-bro.png?alt=media&token=cc81aaaf-8282-4b0b-be6e-2f54e517e928',
        'backgroundImageUrl': 'https://firebasestorage.googleapis.com/v0/b/golab-73336.appspot.com/o/user%2Fbackground_image%2Fgreen-chameleon-s9CC2SKySJM-unsplash.jpg?alt=media&token=303debae-c7bd-47ed-a8a6-3e927e270d5f',
        'interests': List.filled(ResearchKeywords.keywords.length, false),
        'tagline': '',
      });
    } else {
      await firebaseFirestore.collection('researchers').doc(user.uid).set({
        'email': user.email,
        'name': name,
        'university': university,
        'graduateSchool': graduateSchool,
        'avatarImageUrl': 'https://firebasestorage.googleapis.com/v0/b/golab-73336.appspot.com/o/user%2Favatar%2FLaboratory-rafiki.png?alt=media&token=888c61b7-8422-4859-91c0-c47911605c8f',
        'backgroundImageUrl': 'https://firebasestorage.googleapis.com/v0/b/golab-73336.appspot.com/o/user%2Fbackground_image%2Fmarvin-meyer-SYTO3xs06fU-unsplash.jpg?alt=media&token=75d2f1b9-91bd-47d8-ae38-2f558f417fd3',
        'labId': '',
        'labName': '',
        'hasPage': false,
        'keywords': List.filled(ResearchKeywords.keywords.length, false),
        'tagline': ''
      });
    }
  }
}