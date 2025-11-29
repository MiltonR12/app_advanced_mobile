import 'package:flutter/material.dart';

class DropDownButtonCustom<T> extends StatelessWidget {
  const DropDownButtonCustom({
    super.key,
    required this.items,
    this.onChanged,
    this.validator,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged? onChanged;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: const InputDecoration(
        labelText: 'Categoría',
        border: OutlineInputBorder(),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
