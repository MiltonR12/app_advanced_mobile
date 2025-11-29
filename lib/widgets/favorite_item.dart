import 'dart:io';

import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.index, required this.product});

  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: Image.file(File(product.imageUrl ?? '')).image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image_not_supported, size: 50);
        },
      ),
      title: Text(
        product.name.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Cantidad: ${product.quantity} \nPrecio: ${product.price.toStringAsFixed(2)} Bs',
      ),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          print("Editar producto: ${product.name}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(initialProduct: product),
            ),
          );
        }, // próximamente
      ),
    );
  }
}
