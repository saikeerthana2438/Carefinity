import 'package:flutter/material.dart';

import '../models/search_item.dart';
import '../services/search_service.dart';
import '../widgets/search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  final List<SearchItem> items;

  const SearchScreen({
    super.key,
    required this.items,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final SearchService _searchService = SearchService();

  late List<SearchItem> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _onSearch(String value) {
    setState(() {
      filteredItems = _searchService.search(value, widget.items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: _onSearch,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search Carefinity...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _onSearch("");
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text("No results found"),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return SearchResultTile(
                        item: filteredItems[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}