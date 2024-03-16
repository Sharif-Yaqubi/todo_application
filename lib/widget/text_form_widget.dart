import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String hintText;
  final int maxLine;
  final TextEditingController controller;
  const TextFormWidget(
      {super.key,
      required this.hintText,
      required this.maxLine,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
        maxLines: maxLine,
      ),
    );
  }
}
