import 'package:flutter/material.dart';

class SearchItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  SearchItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });
}