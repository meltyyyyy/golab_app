import 'package:cloud_firestore/cloud_firestore.dart';

class Student{
  final String id;
  final String name;
  final String university;
  final String school;
  final String department;
  final String backgroundImageUrl;
  final String avatarImageUrl;
  final String tagline;
  final List<dynamic> interests;

  Student({
    required this.id,
    required this.name,
    required this.university,
    required this.school,
    required this.department,
    required this.interests,
    required this.backgroundImageUrl,
    required this.avatarImageUrl,
    required this.tagline
  });

  factory Student.fromDocumentSnapshot(DocumentSnapshot doc) => Student(
    id: doc.id,
    name: doc['name'] ?? '',
    university: doc['university'] ?? '',
    school: doc['school'] ?? '',
    department: doc['department'] ?? '',
    interests: doc['interests'] ?? [],
    backgroundImageUrl: doc['backgroundImageUrl'] ?? '',
    avatarImageUrl: doc['avatarImageUrl'] ?? '',
    tagline: doc['tagline'] ?? '',
  );
}