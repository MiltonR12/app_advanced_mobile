import 'dart:io';
import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/screens/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.index, required this.product});

  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: product.isSelected,
            onChanged: (bool? value) {
              productProvider.toggleSelectionStatus(product.id, value ?? false);
            },
          ),
          Image(
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
          ),
        ],
      ),
      title: Text(
        product.name.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Precio: ${product.price.toStringAsFixed(2)} Bs'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_red_eye_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProductScreen(product: product),
                ),
              );
            }, // próximamente
          ),
          IconButton(
            icon: Icon(
              product.isFavorite ? Icons.star : Icons.star_outline,
              color: Colors.yellow,
            ),
            onPressed: () {
              productProvider.toggleFavoriteStatus(product.id);
            }, // próximamente
          ),
        ],
      ),
    );
  }
}
