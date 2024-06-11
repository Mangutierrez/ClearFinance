import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
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
                    'Añadir Nueva Categoría',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildCategoryItem('Salario', 'assets/images/ic_salary.svg', const Color(0xFFF4BE37), true),
                _buildCategoryItem('Comida', 'assets/images/ic_salary.svg', const Color(0xFF238EBA), false),
                _buildCategoryItem('Salario', 'assets/images/ic_salary.svg', const Color(0xFFF4BE37), true),
                _buildCategoryItem('Comida', 'assets/images/ic_salary.svg', const Color(0xFF238EBA), false),
                _buildCategoryItem('Salario', 'assets/images/ic_salary.svg', const Color(0xFFF4BE37), true),
                _buildCategoryItem('Comida', 'assets/images/ic_salary.svg', const Color(0xFF238EBA), false),
                _buildCategoryItem('Salario', 'assets/images/ic_salary.svg', const Color(0xFFF4BE37), true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, String iconPath, Color circleColor, bool isIncome) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: circleColor,
                    child: SizedBox(
                      width: 24, // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: SvgPicture.asset(iconPath, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(title, style: const TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isIncome ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isIncome ? 'Ingreso' : 'Gasto',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: SizedBox(
                      width: 24, // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: SvgPicture.asset('assets/images/ic_edit.svg', color: Colors.yellow),
                    ),
                    onPressed: () {
                      // Edit action here
                    },
                  ),
                  IconButton(
                    icon: SizedBox(
                      width: 24, // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: SvgPicture.asset('assets/images/ic_delete.svg', color: Colors.red),
                    ),
                    onPressed: () {
                      // Delete action here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
