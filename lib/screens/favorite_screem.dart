import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreem extends StatelessWidget {
  const FavoriteScreem({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = context.watch<ProductProvider>().favoriteProducts;

    return ListView.builder(
      itemCount: favoriteProducts.length,
      itemBuilder: (context, index) {
        final product = favoriteProducts[index];
        return ProductItem(index: index, product: product);
      },
    );
  }
}
