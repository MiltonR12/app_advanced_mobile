import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({
    super.key,
    this.message = "Esta acción eliminará el producto permanentemente.",
    required void Function() confirmDelete,
  }) : _confirmDelete = confirmDelete;

  final void Function() _confirmDelete;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: _confirmDelete,
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
