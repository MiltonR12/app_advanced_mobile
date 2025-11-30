import 'package:app_advanced_mobile/providers/profile_provider.dart';
import 'package:app_advanced_mobile/providers/theme_provider.dart';
import 'package:app_advanced_mobile/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final themeProvider = context.read<ThemeProvider>();

    return Scaffold(
      appBar: AppBarCustom(title: 'Perfil'),
      floatingActionButton: Column(
        children: [
          const Spacer(),
          FloatingActionButton(
            onPressed: () => _showAddIncomeDialog(context),
            child: const Icon(Icons.monetization_on_sharp),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => themeProvider.toggleTheme(),
            child: Icon(
              themeProvider.theme == AppTheme.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // FOTO + NOMBRE
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profile.photoUrl != null
                        ? NetworkImage(profile.photoUrl!)
                        : null,
                    child: profile.photoUrl == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // SALDO DISPONIBLE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    "Saldo disponible",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Bs. ${profile.balance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // LISTA DE INGRESOS
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ingresos",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),

            if (profile.incomes.isEmpty)
              const Text("No hay ingresos todavía 🙁"),

            ...profile.incomes.map(
              (income) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Ingreso de Bs. ${income.amount.toStringAsFixed(2)}",
                  ),
                  subtitle: Text(
                    "${income.date.day}/${income.date.month}/${income.date.year}",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // DIALOGO PARA AGREGAR INGRESOS
  // -------------------------------
  void _showAddIncomeDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Agregar ingreso"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Monto (Bs.)"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                Provider.of<ProfileProvider>(
                  context,
                  listen: false,
                ).addIncome(amount);
                Navigator.pop(context);
              }
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
    );
  }
}
