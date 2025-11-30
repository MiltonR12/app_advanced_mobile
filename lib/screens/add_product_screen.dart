import 'dart:io';
import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/domain/entities/purchase.dart';
import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/providers/profile_provider.dart';
import 'package:app_advanced_mobile/providers/purchase_provider.dart';
import 'package:app_advanced_mobile/widgets/drop_down_button_custom.dart';
import 'package:app_advanced_mobile/widgets/select_picker_image.dart';
import 'package:app_advanced_mobile/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final Product? initialProduct;
  const AddProductScreen({super.key, this.initialProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;
  ProductCategory? _category;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialProduct != null) {
      final product = widget.initialProduct!;
      _name = product.name;
      _price = product.price;
      _category = product.category;
      if (product.imageUrl != null) {
        _selectedImage = File(product.imageUrl!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final incomeProvider = context.read<ProfileProvider>();
    final purchaseProvider = context.read<PurchaseProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SelectPickerImage(
                pickImage: pickImage,
                selectedImage: _selectedImage,
                initialImageUrl: widget.initialProduct?.imageUrl,
              ),
              const SizedBox(height: 32),
              TextFieldCustom(
                labelText: 'Nombre del producto',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
                initialValue: _name,
              ),
              const SizedBox(height: 16),
              TextFieldCustom(
                labelText: 'Precio',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingresa un precio';
                  if (double.tryParse(value) == null) return 'Precio inválido';
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
                initialValue: _price != 0.0 ? _price.toString() : null,
              ),
              const SizedBox(height: 16),
              DropDownButtonCustom<ProductCategory>(
                items: ProductCategory.values
                    .map(
                      (cat) =>
                          DropdownMenuItem(value: cat, child: Text(cat.name)),
                    )
                    .toList(),
                onChanged: (value) => _category = value,
                validator: (value) =>
                    value == null ? 'Selecciona una categoría' : null,
                initialValue: _category,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newProduct = Product(
                      id: DateTime.now().toString(),
                      name: _name.toLowerCase().trim(),
                      price: _price,
                      imageUrl: _selectedImage?.path,
                      category: _category!,
                      isFavorite: widget.initialProduct?.isFavorite ?? false,
                    );

                    final purchase = Purchase(item: newProduct, amount: _price);

                    if (incomeProvider.balance < purchase.amount) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Saldo insuficiente para esta compra'),
                        ),
                      );
                      return;
                    }

                    productProvider.addProduct(newProduct);
                    incomeProvider.reduceBalance(_price);
                    purchaseProvider.addPurchase(purchase);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
