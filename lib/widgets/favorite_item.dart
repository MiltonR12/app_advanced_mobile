import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/screens/add_product_screen.dart';
import 'package:app_advanced_mobile/widgets/icon_card.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.index, required this.product});

  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconCard(product: product),
      title: Text(
        product.name.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Precio: ${product.price.toStringAsFixed(2)} Bs'),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(initialProduct: product),
            ),
          );
        },
      ),
    );
  }
}
