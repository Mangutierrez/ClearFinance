import 'package:clear_finance/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewCategoryContent extends StatefulWidget {
  final CategoryModel? categoryToEdit;
  final void Function(bool, CategoryModel) onCategoryCreated;
  final void Function() onCancel;

  const NewCategoryContent({
    super.key,
    required this.onCancel,
    required this.onCategoryCreated,
    this.categoryToEdit,
  });

  @override
  _NewCategoryContentState createState() => _NewCategoryContentState();
}

class _NewCategoryContentState extends State<NewCategoryContent> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedName;
  String? _selectedType;
  IconData? _selectedIcon;
  Color _selectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    if (widget.categoryToEdit != null && _selectedName == null) {
      _selectedName = widget.categoryToEdit!.name;
      _selectedType = widget.categoryToEdit!.type;
      _selectedIcon = widget.categoryToEdit!.icon;
      _selectedColor = widget.categoryToEdit!.backgroundColor;
    }
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
              'Llena los campos para registrar una nueva categoría',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.categoryToEdit?.name ?? '',
              decoration: const InputDecoration(
                labelText: 'Nombre de categoría',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un nombre de categoría';
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
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Gasto o ingreso',
                border: OutlineInputBorder(),
              ),
              items: ['Gasto', 'Ingreso']
                  .map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor selecciona una opción';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _selectIcon(context);
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Icono',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  children: [
                    _selectedIcon != null
                        ? Icon(_selectedIcon)
                        : const Icon(Icons.image),
                    const SizedBox(width: 8),
                    Text(_selectedIcon != null
                        ? 'Icono seleccionado'
                        : 'Selecciona un icono'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Color',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    _selectColor(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: _selectedColor,
                    radius: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onCancel();
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Cancelar',
                          style: TextStyle(color: Colors.white)),
                    )),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onCategoryCreated(
                              widget.categoryToEdit != null,
                              CategoryModel(
                                  name: _selectedName ?? '',
                                  icon: _selectedIcon ?? Icons.category,
                                  backgroundColor: _selectedColor,
                                  type: _selectedType ?? ''));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectColor(BuildContext context) async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecciona un color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );

    if (pickedColor != null) {
      setState(() {
        _selectedColor = pickedColor;
      });
    }
  }

  Future<void> _selectIcon(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecciona un icono'),
        content: SizedBox(
          height: 300,
          // Establecer una altura fija
          width: double.maxFinite,
          // Asegurarse de que el contenido se ajuste
          child: IconSelector(
            selectedIcon: _selectedIcon ?? Icons.image,
            onIconSelected: (icon) {
              setState(() {
                _selectedIcon = icon;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class IconSelector extends StatelessWidget {
  final IconData selectedIcon;
  final void Function(IconData) onIconSelected;

  const IconSelector(
      {super.key, required this.selectedIcon, required this.onIconSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: _iconList.map((iconData) {
        return GestureDetector(
          onTap: () {
            onIconSelected(iconData);
            Navigator.of(context).pop();
          },
          child: Icon(
            iconData,
            color: iconData == selectedIcon ? Colors.blue : Colors.black,
            size: 30,
          ),
        );
      }).toList(),
    );
  }

  List<IconData> get _iconList => [
        Icons.home,
        Icons.star,
        Icons.settings,
        Icons.person,
        Icons.shopping_cart,
        Icons.phone,
        Icons.email,
        Icons.work,
        Icons.school,
        Icons.pets,
        Icons.book,
        Icons.camera,
        Icons.music_note,
        Icons.sports,
        Icons.local_cafe,
        Icons.local_dining,
      ];
}
