import 'package:clear_finance/data/category_data.dart';
import 'package:clear_finance/data/history_data.dart';
import 'package:clear_finance/model/category_model.dart';
import 'package:clear_finance/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewHistoryContent extends StatefulWidget {
  final HistoryModel? historyToEdit;
  final void Function(bool, HistoryModel) onHistoryCreated;
  final void Function() onCancel;

  const NewHistoryContent({
    super.key,
    required this.onCancel,
    required this.onHistoryCreated,
    this.historyToEdit,
  });

  @override
  _NewHistoryContentState createState() => _NewHistoryContentState();
}

class _NewHistoryContentState extends State<NewHistoryContent> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedCategory;
  String? _selectedType;
  String? _selectedDescription;
  double? _selectedAmount;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (widget.historyToEdit != null) {
      final history = widget.historyToEdit!;
      _selectedDate = history.date;
      _selectedCategory = history.category;
      _selectedType = history.type;
      _selectedDescription = history.description;
      _selectedAmount = history.amount;
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Llena los campos para registrar un nuevo movimiento',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                          : 'Selecciona una fecha',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
              items: CategoryData.categories.map((CategoryModel category) {
                return DropdownMenuItem(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor selecciona una categoría';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Tipo',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Ingreso', child: Text('Ingreso')),
                DropdownMenuItem(value: 'Gasto', child: Text('Gasto')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor selecciona un tipo';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _selectedDescription ?? '',
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa una descripción';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedDescription = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _selectedAmount?.toString() ?? '',
              decoration: const InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un monto';
                }
                if (double.tryParse(value) == null) {
                  return 'Por favor ingresa un monto válido';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedAmount = double.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final newHistory = HistoryModel(
                        date: _selectedDate!,
                        category: _selectedCategory!,
                        type: _selectedType!,
                        description: _selectedDescription!,
                        amount: _selectedAmount!,
                        categoryColor: _getCategoryColor(_selectedCategory!),
                        typeColor: _selectedType == 'Ingreso' ? Colors.green : Colors.red,
                      );
                      widget.onHistoryCreated(
                          widget.historyToEdit != null, newHistory);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(color: Colors.white),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Guardar', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: widget.onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(color: Colors.white),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Color _getCategoryColor(String categoryName) {
    return CategoryData.categories
        .firstWhere((category) => category.name == categoryName)
        .backgroundColor;
  }
}
