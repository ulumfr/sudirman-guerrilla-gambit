import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class TextFieldAuth extends StatelessWidget {
  const TextFieldAuth({
    Key? key,
    required this.hintText,
    required this.obsecureText,
    this.controller,
  }) : super(key: key);

  final String hintText;
  final bool obsecureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Global.bgGoldGame),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Global.gray2Color),
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Global.bgwhiteColor,
          fontSize: 14.5,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        
      ),
      style: const TextStyle(color: Global.whiteColor),
    );
  }
}
