import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  const OtpInputField({super.key, required this.controller, this.hintText, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        validator: validator,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r' ')),
        ],
        onChanged: onChanged
        );
  }
}
