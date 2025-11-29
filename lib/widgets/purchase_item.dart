import 'dart:io';

import 'package:app_advanced_mobile/domain/entities/purchase.dart';
import 'package:flutter/material.dart';

class PurchaseItem extends StatelessWidget {
  const PurchaseItem({super.key, required this.purchase});

  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: Image.file(File(purchase.item.imageUrl ?? '')).image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.image, weight: 50, size: 50);
        },
      ),
      title: Text(purchase.item.name),
      subtitle: Text('Fecha: ${purchase.date.toString().split(' ')[0]}'),
      trailing: Text(
        '- Bs. ${purchase.amount.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    );
  }
}
