import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import '../search_data.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SearchScreen(
              items: SearchData.items(context),
            ),
          ),
        );
      },
      child: const AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search Carefinity...",
            prefixIcon: Icon(Icons.search),
            filled: true,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}