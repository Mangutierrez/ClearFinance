import 'package:clear_finance/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:clear_finance/data/category_data.dart';
import 'package:clear_finance/data/history_data.dart';
import 'package:clear_finance/util/format_util.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    double totalIngresos = HistoryData.history
        .where((item) => item.type == 'Ingreso')
        .fold(0, (sum, item) => sum + item.amount);
    double totalGastos = HistoryData.history
        .where((item) => item.type == 'Gasto')
        .fold(0, (sum, item) => sum + item.amount);
    double balance = totalIngresos - totalGastos;

    Map<String, double> ingresosMap = {};
    Map<String, double> gastosMap = {};

    HistoryData.history.forEach((item) {
      if (item.type == 'Ingreso') {
        ingresosMap[item.category] = (ingresosMap[item.category] ?? 0) + item.amount;
      } else {
        gastosMap[item.category] = (gastosMap[item.category] ?? 0) + item.amount;
      }
    });

    List<Widget> ingresosLegends = ingresosMap.keys.map((key) {
      Color? color = _getCategoryColor(key);
      return _buildCardItem(key, color ?? Colors.blue);
    }).toList();

    List<Widget> gastosLegends = gastosMap.keys.map((key) {
      Color? color = _getCategoryColor(key);
      return _buildCardItem(key, color ?? Colors.red);
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'COP ${FormatUtil.formatCurrency(balance)}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCard('Ingresos', '${FormatUtil.formatCurrency(totalIngresos)} COP', const Color(0xFF6DD648)),
                    const SizedBox(width: 20),
                    _buildCard('Gastos', '${FormatUtil.formatCurrency(totalGastos)} COP', const Color(0XFFD64848)),
                  ],
                )),
            const SizedBox(height: 20),
            _buildPieChart(context, 'Ingresos', ingresosMap, ingresosLegends),
            const SizedBox(height: 20),
            _buildPieChart(context, 'Gastos', gastosMap, gastosLegends),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(BuildContext context, String title, Map<String, double> dataMap, List<Widget> legends) {
    if (dataMap.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
              color: title == 'Ingresos'
                  ? const Color(0xFFB7F0B2)
                  : const Color(0XFFF0B2B2)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'No hay datos disponibles',
            style: TextStyle(
              color: title == 'Ingresos'
                  ? const Color(0xFF6DD648)
                  : const Color(0XFFD64848),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
              color: title == 'Ingresos'
                  ? const Color(0xFFB7F0B2)
                  : const Color(0XFFF0B2B2)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: title == 'Ingresos'
                        ? const Color(0xFF6DD648)
                        : const Color(0XFFD64848),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 500),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    colorList: dataMap.keys.map((key) {
                      final category = CategoryData.categories.firstWhere((category) => category.name == key, orElse: () => CategoryModel(name: key, icon: Icons.category, backgroundColor: Colors.grey, type: ''));
                      return category.backgroundColor;
                    }).toList(),
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: false,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: legends,
            ),
          ],
        ));
  }

  Widget _buildCardItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Color? _getCategoryColor(String categoryName) {
    final category = CategoryData.categories.firstWhere(
            (category) => category.name == categoryName,
        orElse: () => CategoryModel(
          name: 'Default',
          icon: Icons.category,
          backgroundColor: Colors.grey,
          type: 'Default',
        ));
    return category.backgroundColor;
  }
}
