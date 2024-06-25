import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clear_finance/model/category_model.dart';
import 'package:clear_finance/model/goal_model.dart';
import 'package:clear_finance/data/category_data.dart';

class NewGoalContent extends StatefulWidget {
  final GoalModel? goalToEdit;
  final void Function(bool, GoalModel) onGoalCreated;
  final void Function() onCancel;

  const NewGoalContent({
    super.key,
    required this.onCancel,
    required this.onGoalCreated,
    this.goalToEdit,
  });

  @override
  _NewGoalContentState createState() => _NewGoalContentState();
}

class _NewGoalContentState extends State<NewGoalContent> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedName;
  double? _selectedAmount;
  CategoryModel? _selectedCategory;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.goalToEdit != null) {
      _selectedName = widget.goalToEdit!.name;
      _selectedAmount = widget.goalToEdit!.amount;
      _selectedCategory = CategoryData.categories
          .firstWhere((category) => category.name == widget.goalToEdit!.category);
      _selectedDate = widget.goalToEdit!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Llena los campos para registrar una nueva meta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _selectedName,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un nombre para la meta';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _selectedAmount?.toString(),
              decoration: const InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un monto';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedAmount = double.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<CategoryModel>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
              items: CategoryData.categories
                  .map((category) => DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(category.name),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor selecciona una categoría';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha Límite',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedDate != null
                          ? DateFormat.yMd().format(_selectedDate!)
                          : 'Selecciona una fecha',
                    ),
                    const Spacer(),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onCancel();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onGoalCreated(
                          widget.goalToEdit != null,
                          GoalModel(
                            name: _selectedName ?? '',
                            amount: _selectedAmount ?? 0,
                            category: _selectedCategory!.name,
                            date: _selectedDate ?? DateTime.now(),
                            categoryColor: _selectedCategory!.backgroundColor,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
