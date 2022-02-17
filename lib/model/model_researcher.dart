import 'package:cloud_firestore/cloud_firestore.dart';

class Researcher {
  final String id;
  final String avatarImageUrl;
  final String backgroundImageUrl;
  final List<dynamic> keywords;
  final String labName;
  final String tagline;
  final String name;
  final String graduateSchool;
  final String university;
  final bool hasPage;

  Researcher({
    required this.id,
    required this.avatarImageUrl,
    required this.backgroundImageUrl,
    required this.keywords,
    required this.labName,
    required this.tagline,
    required this.name,
    required this.graduateSchool,
    required this.university,
    required this.hasPage,
  });

  factory Researcher.fromDocumentSnapshot(DocumentSnapshot doc) => Researcher(
      id: doc.id,
      avatarImageUrl: doc['avatarImageUrl'] ?? '',
      backgroundImageUrl: doc['backgroundImageUrl'] ?? '',
      keywords: doc['keywords'] ?? [],
      labName: doc['labName'] ?? '',
      tagline: doc['tagline'] ?? '',
      name: doc['name'] ?? '',
      graduateSchool: doc['graduateSchool'] ?? '',
      hasPage: doc['hasPage'],
      university: doc['university'] ?? '',
    );
}