import 'package:clear_finance/data/category_data.dart';
import 'package:clear_finance/data/history_data.dart';
import 'package:clear_finance/model/category_model.dart';
import 'package:clear_finance/model/history_model.dart';
import 'package:flutter/material.dart';

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
  String? _selectedDate;
  String? _selectedCategory;
  String? _selectedType;
  String? _selectedDescription;
  String? _selectedAmount;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (widget.historyToEdit != null) {
      _selectedDate = widget.historyToEdit!.date;
      _selectedCategory = widget.historyToEdit!.category;
      _selectedType = widget.historyToEdit!.type;
      _selectedDescription = widget.historyToEdit!.description;
      _selectedAmount = widget.historyToEdit!.amount;
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
            TextFormField(
              initialValue: _selectedDate ?? '',
              decoration: const InputDecoration(
                labelText: 'Fecha',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa una fecha';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedDate = value;
                });
              },
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
              initialValue: _selectedAmount ?? '',
              decoration: const InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un monto';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _selectedAmount = value;
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

  Color _getCategoryColor(String categoryName) {
    return CategoryData.categories
        .firstWhere((category) => category.name == categoryName)
        .backgroundColor;
  }
}
