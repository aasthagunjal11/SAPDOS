import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;

  const HeaderSection({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(213, 4, 49, 116),
          ),
        ),
        SizedBox(height: 16),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 4, 48, 116),
          ),
        ),
        SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(161, 0, 0, 0),
          ),
        ),
      ],
    );
  }
}
