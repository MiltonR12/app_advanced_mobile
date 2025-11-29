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
    this.initialValue,
  });

  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;
  final String? initialValue;

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
      initialValue: controller == null ? initialValue : null,
    );
  }
}
