import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/widgets/app_bar_custom.dart';
import 'package:app_advanced_mobile/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreem extends StatelessWidget {
  const FavoriteScreem({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = context.watch<ProductProvider>().favoriteProducts;

    return Scaffold(
      appBar: AppBarCustom(title: 'Productos Favoritos'),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No hay productos favoritos.'))
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return FavoriteItem(index: index, product: product);
              },
            ),
    );
  }
}
