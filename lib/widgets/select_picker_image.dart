import 'dart:io';
import 'package:flutter/material.dart';

class SelectPickerImage extends StatelessWidget {
  const SelectPickerImage({
    super.key,
    required this.pickImage,
    required this.selectedImage,
  });

  final VoidCallback pickImage;
  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1.5),
          color: Colors.grey.shade200,
        ),
        child: selectedImage == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("Toca para agregar una foto"),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  selectedImage!,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
