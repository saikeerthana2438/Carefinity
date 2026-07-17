import '../models/search_item.dart';

class SearchService {
  List<SearchItem> search(
    String query,
    List<SearchItem> items,
  ) {
    if (query.isEmpty) {
      return items;
    }

    return items.where((item) {
      return item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.subtitle.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}