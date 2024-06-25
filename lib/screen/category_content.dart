import 'package:clear_finance/data/category_data.dart';
import 'package:clear_finance/model/category_model.dart';
import 'package:clear_finance/screen/new_category_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryContent extends StatefulWidget {
  const CategoryContent({super.key});

  @override
  _CategoryContentState createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  bool showNewCategoryContent = false;
  CategoryModel? categoryToEdit;

  @override
  Widget build(BuildContext context) {
    return showNewCategoryContent
        ? NewCategoryContent(
            categoryToEdit: categoryToEdit,
            onCancel: () {
              setState(() {
                showNewCategoryContent = false;
              });
            },
            onCategoryCreated: (fromEdit, categoryModel) {
              if (fromEdit) {
                if (categoryToEdit == null) return;
                CategoryData.removeCategory(categoryToEdit!);
                categoryToEdit = null;
              }
              CategoryData.addCategory(categoryModel);
              setState(() {
                showNewCategoryContent = false;
              });
            },
          )
        : _buildCategoryContent();
  }

  Widget _buildCategoryContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showNewCategoryContent = true;
              });
            },
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
              child: CategoryData.categories.isNotEmpty
                  ? ListView.builder(
                      itemCount: CategoryData.categories.length,
                      itemBuilder: (context, index) {
                        final category = CategoryData.categories[index];
                        return _buildCategoryItem(category);
                      },
                    )
                  : const Center(
                      child: Text('No hay categorías'),
                    ))
        ],
      ),
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
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
                    backgroundColor: category.backgroundColor,
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          category.icon,
                          color: Colors.white,
                          size: 24,
                        )),
                  ),
                  const SizedBox(width: 16),
                  Text(category.name, style: const TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: category.type == 'Ingreso'
                          ? Colors.green
                          : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category.type,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: SizedBox(
                      width: 24, // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: SvgPicture.asset('assets/images/ic_edit.svg',
                          color: Colors.yellow),
                    ),
                    onPressed: () {
                      setState(() {
                        showNewCategoryContent = true;
                        categoryToEdit = category;
                      });
                    },
                  ),
                  IconButton(
                    icon: SizedBox(
                      width: 24, // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: SvgPicture.asset('assets/images/ic_delete.svg',
                          color: Colors.red),
                    ),
                    onPressed: () {
                      setState(() {
                        CategoryData.removeCategory(category);
                      });
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
