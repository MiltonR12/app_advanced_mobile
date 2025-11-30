import 'dart:io';
import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/widgets/alert_message.dart';
import 'package:app_advanced_mobile/widgets/drop_down_button_custom.dart';
import 'package:app_advanced_mobile/widgets/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatefulWidget {
  final Product product;

  const DetailProductScreen({super.key, required this.product});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _quantityController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.product.quantity.toString(),
    );
    _priceController = TextEditingController(
      text: widget.product.price.toStringAsFixed(2),
    );
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProductProvider>();

    provider.updateProduct(
      widget.product.id,
      quantity: int.parse(_quantityController.text),
      price: double.parse(_priceController.text),
    );

    Navigator.pop(context);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("⚠ Eliminar Producto"),
        content: Text(
          "¿Estás seguro de que deseas eliminar '${widget.product.name}'?",
        ),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
            onPressed: () {
              context.read<ProductProvider>().removeProduct(widget.product.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Producto")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(widget.product.imageUrl ?? ''),
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      color: const Color.fromARGB(255, 231, 231, 231),
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              TextFieldCustom(
                labelText: "Nombre",
                enabled: false,
                controller: TextEditingController(text: widget.product.name),
              ),
              const SizedBox(height: 20),

              TextFieldCustom(
                labelText: "Precio",
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa un precio";
                  }
                  if (double.tryParse(value) == null) return "Precio inválido";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFieldCustom(
                labelText: "Cantidad",
                keyboardType: TextInputType.number,
                controller: _quantityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa una cantidad";
                  }
                  if (int.tryParse(value) == null) return "Cantidad inválida";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropDownButtonCustom<ProductCategory>(
                items: ProductCategory.values
                    .map(
                      (cat) =>
                          DropdownMenuItem(value: cat, child: Text(cat.name)),
                    )
                    .toList(),
                initialValue: widget.product.category,
              ),
              const SizedBox(height: 30),
              AlertMessage(confirmDelete: _confirmDelete),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: const Text("Guardar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
