import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.comment,
      required this.icon,
      required this.controller})
      : super(key: key);

  final String comment;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
            color: Colors.cyanAccent,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: comment, icon: Icon(icon))),
      ),
    );
  }
}
