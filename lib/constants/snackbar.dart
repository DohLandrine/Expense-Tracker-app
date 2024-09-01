import 'package:flutter/material.dart';
import 'package:expense_tracker/constants/theme.dart';

SnackBar customSnackBar(
    {required String content, required IconData icon, required Color colour}) {
  return SnackBar(
    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
    duration: const Duration(milliseconds: 1500),
    backgroundColor: colour,
    content: Row(
      children: [
        Icon(
          icon,
          color: Colour.dark,
          size: 40,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            content,
          ),
        ),
      ],
    ),
  );
}
