import 'package:cloud_firestore/cloud_firestore.dart';

class Lab {
  final String application;
  final String description;
  final String field;
  final List<dynamic> features;
  final List<dynamic> keywords;
  final String labName;
  final String link;
  final String location;
  final String researchImageUrl;
  final String university;
  final String tagline;
  final String avatarImageUrl;
  final String ownerId;
  final String email;

  Lab({
    required this.keywords,
    required this.university,
    required this.features,
    required this.link,
    required this.location,
    required this.description,
    required this.application,
    required this.field,
    required this.labName,
    required this.researchImageUrl,
    required this.tagline,
    required this.avatarImageUrl,
    required this.ownerId,
    required this.email
  });

  factory Lab.fromDocumentSnapshot(DocumentSnapshot doc) => Lab(
      application: doc['application'] ?? '',
      description: doc['description'] ?? '',
      field: doc['field'] ?? '',
      keywords: doc['keywords'] ?? [],
      features: doc['features'] ?? [],
      labName: doc['labName'] ?? '',
      link: doc['link'] ?? '',
      location: doc['location'] ?? '',
      researchImageUrl: doc['researchImageUrl'] ?? '',
      university: doc['university'] ?? '',
      tagline: doc['tagline'] ?? '',
      ownerId: doc['ownerId'] ?? '',
      email: doc['email'] ?? '',
      avatarImageUrl: doc['avatarImageUrl'] ?? '',
  );
}