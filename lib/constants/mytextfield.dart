import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  bool ObscureText;
  String HintText;
  Text LabelText;
  TextEditingController Controller;
  TextInputType KeyBoardType;

  MyTextField({
    super.key,
    required this.HintText,
    required this.Controller,
    required this.LabelText,
    required this.ObscureText,
    required this.KeyBoardType,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.Controller,
      obscureText: widget.ObscureText,
      keyboardType: widget.KeyBoardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        hintText: widget.HintText,
        //hintStyle: GoogleFonts.monoton(),
        label: widget.LabelText,
        //labelStyle: GoogleFonts.alegreya()
      ),
    );
  }
}
