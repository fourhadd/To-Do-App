import 'package:flutter/material.dart';
import 'package:todo/theme/app_color.dart';

import 'package:todo/utils/category_config/category_config.dart';

Future<String?> selectCategory(BuildContext context) async {
  final List<String> categories = [
    'Grocery',
    'Work',
    'Sport',
    'Design',
    'University',
    'Social',
    'Music',
    'Health',
    'Movie',
    'Home',
    'Create New',
  ];

  String? selectedCategory = await showDialog<String>(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: AppColor.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "Choose Category",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 49,
                  childAspectRatio: 0.8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final String category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, category.toString());
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: CategoryConfig.getContainerColor(category),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            CategoryConfig.getIcon(category),
                            color: CategoryConfig.getIconColor(category),
                            size: 35,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );

  return selectedCategory;
}
