import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'COP 0.00',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCard('Ingresos', '0.00 COP', const Color(0xFF6DD648)),
                    const SizedBox(width: 20),
                    _buildCard('Gastos', '0.00 COP', const Color(0XFFD64848)),
                  ],
                )),
            const SizedBox(height: 20),
            _buildPieChart(context, 'Ingresos', {
              'Salario': 60.0,
              'Inversiones': 40.0,
            }, [
              _buildCardItem('Salario', Colors.blue),
              _buildCardItem('Inversiones', Colors.black),
            ]),
            const SizedBox(height: 20),
            _buildPieChart(context, 'Gastos', {
              'Arriendo': 25.0,
              'Comida': 25.0,
              'Servicios': 25.0,
              'Entretenimiento': 25.0,
            }, [
              _buildCardItem('Arriendo', Colors.yellow),
              _buildCardItem('Comida', Colors.blue),
              _buildCardItem('Servicios', Colors.black),
              _buildCardItem('Entretenimiento', Colors.teal),
            ]),
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
                    colorList: title == 'Ingresos'
                        ? [Colors.blue, Colors.black]
                        : [Colors.yellow, Colors.blue, Colors.black, Colors.teal],
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
}
