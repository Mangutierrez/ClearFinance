import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryContent extends StatelessWidget {
  const HistoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          InkWell(
              onTap: () {},
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBA7423),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                      Text(
                        'Añadir Nuevo Movimiento',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          )),
                    ],
                  ))),
          const SizedBox(height: 10),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text('May 25',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                _buildHistoryItem(
                    'May 25',
                    'Salario',
                    'Ingreso',
                    'Sueldo',
                    '0.00 COP',
                    const Color(0xFFF4BE37),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildHistoryItem(
                    'May 25',
                    'Comida',
                    'Gasto',
                    'Sueldo',
                    '0.00 COP',
                    const Color(0xFF48B6D6),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildHistoryItem(
                    'May 24',
                    'Salario',
                    'Ingreso',
                    'Sueldo',
                    '0.00 COP',
                    const Color(0xFFF4BE37),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildHistoryItem(
                    'May 24',
                    'Salario',
                    'Ingreso',
                    'Sueldo',
                    '0.00 COP',
                    const Color(0xFFF4BE37),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildHistoryItem(
                    'May 24',
                    'Salario',
                    'Ingreso',
                    'Sueldo',
                    '0.00 COP',
                    const Color(0xFFF4BE37),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildHistoryItem(
                    'May 24',
                    'Salario',
                    'Ingreso',
                    'Sueldo',
                    '0.00 COP',
                    const Color(0xFFF4BE37),
                    const Color(0xFFD64848)),
              ],
            ),
          ))
        ]));
  }

  Widget _buildHistoryItem(String date, String category, String type,
      String description, String amount, Color categoryColor, Color typeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildChip(category, categoryColor),
                  const SizedBox(width: 8),
                  _buildChip(type, typeColor),
                  const Spacer(),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ic_edit.svg'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/ic_delete.svg'),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(description,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300)),
              const SizedBox(height: 8),
              Text(amount,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
