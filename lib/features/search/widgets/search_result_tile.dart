import 'package:flutter/material.dart';
import '../models/search_item.dart';

class SearchResultTile extends StatelessWidget {
  final SearchItem item;

  const SearchResultTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(item.icon),
      ),
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: item.onTap,
    );
  }
}