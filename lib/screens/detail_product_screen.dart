import 'dart:io';
import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/providers/product_provider.dart';
import 'package:app_advanced_mobile/widgets/alert_message.dart';
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

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.product.quantity.toString(),
    );
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProductProvider>();

    provider.updateProduct(
      widget.product.id,
      quantity: int.parse(_quantityController.text),
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
                enabled: false,
                controller: TextEditingController(
                  text: widget.product.price.toString(),
                ),
              ),

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
