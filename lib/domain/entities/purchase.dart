import 'package:app_advanced_mobile/domain/entities/product.dart';

class Purchase {
  final Product item;
  final DateTime date = DateTime.now();
  final double amount;

  Purchase({required this.item, required this.amount});
}
