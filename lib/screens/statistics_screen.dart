import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 150,
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [BarChartRodData(toY: 120, color: Colors.blue)],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [BarChartRodData(toY: 50, color: Colors.green)],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [BarChartRodData(toY: 80, color: Colors.orange)],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [BarChartRodData(toY: 30, color: Colors.red)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
