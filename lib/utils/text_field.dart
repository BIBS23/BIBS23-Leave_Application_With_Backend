import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String hint;
  final int maxlines;
  final TextEditingController myController;
  final double fieldheight;
  const TextFields(
      {super.key,
      required this.maxlines,
      required this.myController,
      required this.hint,
      required this.fieldheight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: fieldheight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          maxLines: maxlines,
          controller: myController,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.only(left: 10),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
