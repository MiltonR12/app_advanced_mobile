import 'dart:io';

import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: Image.file(File(product.imageUrl ?? '')).image,
      width: 40,
      height: 40,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (product.category == ProductCategory.frutas) {
          return const Icon(Icons.apple, size: 40);
        } else if (product.category == ProductCategory.verduras) {
          return const Icon(Icons.grass, size: 40);
        } else if (product.category == ProductCategory.carnes) {
          return const Icon(Icons.set_meal, size: 40);
        } else if (product.category == ProductCategory.lacteos) {
          return const Icon(Icons.icecream, size: 40);
        } else if (product.category == ProductCategory.bebidas) {
          return const Icon(Icons.local_drink, size: 40);
        } else {
          return const Icon(Icons.image_not_supported, size: 40);
        }
      },
    );
  }
}
