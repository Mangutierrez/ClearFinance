import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoalsContent extends StatelessWidget {
  const GoalsContent({super.key});

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
                        'Añadir Nueva Meta',
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
                _buildGoalsItem(
                    'Entretenimiento',
                    'Computador',
                    '0.00 COP',
                    '35/12/2024',
                    const Color(0xFF48B6D6),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildGoalsItem(
                    'Entretenimiento',
                    'Computador',
                    '0.00 COP',
                    '35/12/2024',
                    const Color(0xFF48B6D6),
                    const Color(0xFFD64848)),
                const SizedBox(height: 10),
                _buildGoalsItem(
                    'Entretenimiento',
                    'Computador',
                    '0.00 COP',
                    '35/12/2024',
                    const Color(0xFF48B6D6),
                    const Color(0xFFD64848)),
              ],
            ),
          ))
        ]));
  }

  Widget _buildGoalsItem(String category, String description, String amount, String date, Color categoryColor, Color typeColor) {
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
              const SizedBox(height: 8),
              Text('Fecha Límite: $date',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xFFBA7423))),
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
