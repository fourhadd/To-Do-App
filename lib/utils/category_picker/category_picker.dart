// utils/category_picker/category_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/l10n/app_localizations.dart';
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
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        backgroundColor: AppColor.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Text(
                AppLocalizations.of(context)!.chooseCategory,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.87),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 49.w,
                  childAspectRatio: 0.8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final String category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, category);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 64.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: CategoryConfig.getContainerColor(category),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            CategoryConfig.getIcon(category),
                            color: CategoryConfig.getIconColor(category),
                            size: 35.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.87),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
    },
  );

  return selectedCategory;
}
