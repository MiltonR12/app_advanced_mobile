import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/screens/detail_product_screen.dart';
import 'package:app_advanced_mobile/widgets/icon_card.dart';
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
          IconCard(product: product),
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
            },
          ),
          IconButton(
            icon: Icon(
              product.isFavorite ? Icons.star : Icons.star_outline,
              color: Colors.yellow,
            ),
            onPressed: () {
              productProvider.toggleFavoriteStatus(product.name);
            },
          ),
        ],
      ),
    );
  }
}
