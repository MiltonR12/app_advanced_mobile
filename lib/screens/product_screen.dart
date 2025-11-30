import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/providers/profile_provider.dart';
import 'package:app_advanced_mobile/screens/add_product_screen.dart';
import 'package:app_advanced_mobile/widgets/app_bar_custom.dart';
import 'package:app_advanced_mobile/widgets/product_item.dart';
import 'package:app_advanced_mobile/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ProductCategory { frutas, verduras, carnes, lacteos, bebidas }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  ProductCategory? selectedCategory;

  final Map<ProductCategory, String> categoryLabels = {
    ProductCategory.frutas: "Frutas",
    ProductCategory.verduras: "Verduras",
    ProductCategory.carnes: "Carnes",
    ProductCategory.lacteos: "Lácteos",
    ProductCategory.bebidas: "Bebidas",
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final isExistSelected = context.watch<ProductProvider>().isExistSelected;
    final productProvider = context.read<ProductProvider>();
    final incomeProvider = context.watch<ProfileProvider>();

    final query = _searchController.text.toLowerCase();
    final filteredProducts = products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == null ||
          product.category.toString() == selectedCategory.toString();

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBarCustom(title: 'Lista de Productos'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monto Disponible: \$${incomeProvider.balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            SearchField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("Todos"),
                    selected: selectedCategory == null,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),

                  ...categoryLabels.entries.map((entry) {
                    final category = entry.key;
                    final label = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: selectedCategory == category,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            (isExistSelected)
                ? ElevatedButton(
                    onPressed: () => productProvider.clearSelection(),
                    child: Text(
                      'Tienes productos favoritos',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                : const SizedBox.shrink(),

            const SizedBox(height: 16),

            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text('No se encontraron productos'))
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      padding: const EdgeInsets.only(bottom: 40),
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ProductItem(
                            index: index,
                            product: filteredProducts[index],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
