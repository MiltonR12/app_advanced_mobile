import 'package:flutter/material.dart';

class DropDownButtonCustom<T> extends StatelessWidget {
  const DropDownButtonCustom({
    super.key,
    required this.items,
    this.onChanged,
    this.validator,
    this.enableFeedback = true,
    this.initialValue,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged? onChanged;
  final FormFieldValidator? validator;
  final bool enableFeedback;
  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: 'Categoría',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 189, 189, 189),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      style: TextStyle(color: Colors.grey.shade800), // texto gris
      dropdownColor: Colors.grey.shade100, // menú desplegable gris
      items: items,
      onChanged: onChanged,
      initialValue: initialValue,
    );
  }
}
