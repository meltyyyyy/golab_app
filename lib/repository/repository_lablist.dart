import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golab/model/model_lab.dart';
import 'package:golab/model/model_search_result.dart';

class LabListRepository{
  static Future<List<Lab>> fetchLabList() async {
    final labDocs = await FirebaseFirestore.
    instance.
    collection('laboratories').
    get();

    final List<Lab> labList = labDocs.
    docs.
    map((doc) => Lab.fromDocumentSnapshot(doc)).
    toList();

    return labList;
  }

  static Future<List<Lab>> queryLabList(SearchResult result) async {
    final List<DocumentSnapshot> filteredList = [];
    final QuerySnapshot snapshot = await FirebaseFirestore.
    instance.
    collection('laboratories').
    get();

    //filter by field
    for (String field in result.fields) {
      final docsFilteredByField = snapshot.docs.where((doc) => field == doc['field']);
      filteredList.addAll(docsFilteredByField);
    }

    //filter by feature
    for (String feature in result.features) {
      final docsFilteredByFeature = snapshot.docs.where((doc) {
        final List<dynamic> features = doc['features'];
        if(features.contains(feature)){
          return true;
        } else {
          return false;
        }
      });
      filteredList.addAll(docsFilteredByFeature);
    }

    //filter by keyword
    final docsFilteredByKeyword = snapshot.docs.where((doc) {
      final List<dynamic> keywords = doc['keywords'];
      if(result.index >= 0 && keywords[result.index]){
        return true;
      } else {
        return false;
      }
    });
    filteredList.addAll(docsFilteredByKeyword);

    final List<Lab> labList = filteredList.
    map((doc) => Lab.fromDocumentSnapshot(doc)).
    toList();

    return labList;
  }
}