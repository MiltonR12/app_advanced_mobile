import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    required this.labelText,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.enabled,
    this.controller,
  });

  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      enabled: enabled,
    );
  }
}
