import 'package:app_advanced_mobile/providers/purchase_provider.dart';
import 'package:app_advanced_mobile/widgets/app_bar_custom.dart';
import 'package:app_advanced_mobile/widgets/purchase_item.dart';
import 'package:app_advanced_mobile/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  String searchQuery = '';
  String dateFilter = 'Todo';

  @override
  Widget build(BuildContext context) {
    final purchases = Provider.of<PurchaseProvider>(context).purchases;

    final filteredPurchases = purchases.where((p) {
      final matchesSearch = p.item.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final now = DateTime.now();
      final purchaseDate = p.date;

      bool matchesDate = true;

      switch (dateFilter) {
        case 'Hoy':
          matchesDate =
              purchaseDate.year == now.year &&
              purchaseDate.month == now.month &&
              purchaseDate.day == now.day;
          break;

        case 'Esta semana':
          final weekStart = now.subtract(Duration(days: now.weekday - 1));
          final weekEnd = weekStart.add(const Duration(days: 6));
          matchesDate =
              purchaseDate.isAfter(
                weekStart.subtract(const Duration(seconds: 1)),
              ) &&
              purchaseDate.isBefore(weekEnd.add(const Duration(days: 1)));
          break;

        case 'Este mes':
          matchesDate =
              purchaseDate.year == now.year && purchaseDate.month == now.month;
          break;

        default:
          matchesDate = true;
      }

      return matchesSearch && matchesDate;
    }).toList();

    return Scaffold(
      appBar: AppBarCustom(title: 'Historial de Compras'),
      body: Column(
        children: [
          SearchField(
            onChanged: (value) {
              setState(() => searchQuery = value);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: dateFilter,
              decoration: InputDecoration(
                labelText: 'Filtrar por fecha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Todo', child: Text('Todo')),
                DropdownMenuItem(value: 'Hoy', child: Text('Hoy')),
                DropdownMenuItem(
                  value: 'Esta semana',
                  child: Text('Esta semana'),
                ),
                DropdownMenuItem(value: 'Este mes', child: Text('Este mes')),
              ],
              onChanged: (value) {
                setState(() => dateFilter = value!);
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: filteredPurchases.isEmpty
                ? const Center(child: Text('No se encontraron compras'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPurchases.length,
                    itemBuilder: (context, index) {
                      final purchase = filteredPurchases[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: PurchaseItem(purchase: purchase),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
