import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:app_advanced_mobile/providers/profile_provider.dart';
import 'package:app_advanced_mobile/providers/purchase_provider.dart';
import 'package:app_advanced_mobile/widgets/app_bar_custom.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = context.watch<PurchaseProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    DateTime now = DateTime.now();

    // Compras del mes actual y anterior
    final currentMonthPurchases = purchaseProvider.purchases
        .where((p) => p.date.month == now.month && p.date.year == now.year)
        .toList();

    final lastMonth = DateTime(now.year, now.month - 1, 1);
    final lastMonthPurchases = purchaseProvider.purchases
        .where(
          (p) =>
              p.date.month == lastMonth.month && p.date.year == lastMonth.year,
        )
        .toList();

    double currentMonthTotal = currentMonthPurchases.fold(
      0,
      (sum, p) => sum + p.amount,
    );
    double lastMonthTotal = lastMonthPurchases.fold(
      0,
      (sum, p) => sum + p.amount,
    );
    double saved = lastMonthTotal - currentMonthTotal; // positivo = ahorro

    // Gasto por categoría
    Map<ProductCategory, double> categorySpending = {};
    for (var p in purchaseProvider.purchases) {
      categorySpending[p.item.category] =
          (categorySpending[p.item.category] ?? 0) + p.amount;
    }

    // Productos más comprados
    final productCountMap = <String, double>{};
    for (var purchase in purchaseProvider.purchases) {
      final name = purchase.item.name;
      productCountMap[name] = (productCountMap[name] ?? 0) + purchase.amount;
    }

    final topProducts = productCountMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top5Products = topProducts.take(5).toList();

    final top3Products = topProducts.take(3).toList();

    return Scaffold(
      appBar: const AppBarCustom(title: 'Estadísticas'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Resumen rápido
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard(
                  'Saldo Actual',
                  '\$${profileProvider.balance.toStringAsFixed(2)}',
                  Colors.blue,
                ),
                _infoCard(
                  'Compras este mes',
                  '\$${currentMonthTotal.toStringAsFixed(2)}',
                  Colors.green,
                ),
                _infoCard(
                  'Ahorro vs mes pasado',
                  '\$${saved.toStringAsFixed(2)}',
                  saved >= 0 ? Colors.orange : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pie chart: Gasto por categoría
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gasto por Categoría',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: categorySpending.entries.map((e) {
                    final color = _categoryColor(e.key);
                    return PieChartSectionData(
                      value: e.value,
                      title: '\$${e.value.toStringAsFixed(0)}',
                      color: color,
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Pie chart: Productos más comprados
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Productos más comprados (Top 5)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: top5Products.map((e) {
                    final color =
                        Colors.primaries[top5Products.indexOf(e) %
                            Colors.primaries.length];
                    return PieChartSectionData(
                      value: e.value,
                      title: '${e.key}\n\$${e.value.toStringAsFixed(0)}',
                      color: color,
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Barra: Top 3 productos más comprados
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top 3 Productos (Barra)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...top3Products.map((e) => _barItem(e.key, e.value.toDouble())),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, Color color) {
    return Card(
      elevation: 3,
      color: color.withOpacity(0.2),
      child: Container(
        width: 100,
        height: 80,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barItem(String name, double quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(name)),
          Expanded(
            flex: 5,
            child: LinearProgressIndicator(
              value: (quantity / 100).clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 8),
          Text(quantity.toInt().toString()),
        ],
      ),
    );
  }

  static Color _categoryColor(ProductCategory category) {
    switch (category) {
      case ProductCategory.frutas:
        return Colors.red;
      case ProductCategory.verduras:
        return Colors.green;
      case ProductCategory.carnes:
        return Colors.brown;
      case ProductCategory.lacteos:
        return Colors.orange;
      case ProductCategory.bebidas:
        return Colors.blue;
    }
  }
}
