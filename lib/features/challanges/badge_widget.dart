import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {

  final List<String> badges;

  const BadgeWidget({
    super.key,
    required this.badges,
  });

  @override
  Widget build(BuildContext context) {

    return Wrap(

      spacing: 10,

      children: badges.map((badge){

        return Chip(

          label: Text(badge),

          backgroundColor: Colors.green.shade100,

        );

      }).toList(),
    );
  }
}