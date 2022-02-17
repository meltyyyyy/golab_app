class SearchResult {
  final int index;
  final List<String> fields;
  final List<String> features;

  SearchResult({
    required this.index,
    required this.fields,
    required this.features
  });
}