import 'package:flutter/material.dart';

class LeftImageSection extends StatelessWidget {
  final String imagePath;

  const LeftImageSection({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color.fromARGB(255, 234, 244, 251),
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
