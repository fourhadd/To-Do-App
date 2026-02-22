// utils/category_config/category_config.dart
import 'package:flutter/material.dart';
import 'package:todo/theme/app_color.dart';

class CategoryConfig {
  static final Map<String, IconData> icons = {
    'Grocery': Icons.breakfast_dining,
    'Work': Icons.work_outline,
    'Sport': Icons.fitness_center_outlined,
    'Design': Icons.brush_outlined,
    'University': Icons.school_outlined,
    'Social': Icons.people_outline,
    'Music': Icons.music_note_outlined,
    'Health': Icons.favorite_outline,
    'Movie': Icons.movie_outlined,
    'Home': Icons.home_outlined,
    'Create New': Icons.add_circle_outline,
  };

  static final Map<String, Color> iconColors = {
    'Grocery': AppColor.groceryIcon,
    'Work': AppColor.workIcon,
    'Sport': AppColor.sportIcon,
    'Design': AppColor.designIcon,
    'University': AppColor.universityIcon,
    'Social': AppColor.socialIcon,
    'Music': AppColor.musicIcon,
    'Health': AppColor.healthIcon,
    'Movie': AppColor.movieIcon,
    'Home': AppColor.homeIcon,
    'Create New': AppColor.createNewIcon,
  };

  static final Map<String, Color> containerColors = {
    'Grocery': AppColor.groceryBg,
    'Work': AppColor.workBg,
    'Sport': AppColor.sportBg,
    'Design': AppColor.designBg,
    'University': AppColor.universityBg,
    'Social': AppColor.socialBg,
    'Music': AppColor.musicBg,
    'Health': AppColor.healthBg,
    'Movie': AppColor.movieBg,
    'Home': AppColor.homeBg,
    'Create New': AppColor.createNewBg,
  };

  static IconData getIcon(String category) =>
      icons[category] ?? Icons.add_box_outlined;

  static Color getIconColor(String category) =>
      iconColors[category] ?? Colors.white;

  static Color getContainerColor(String category) =>
      containerColors[category] ?? Colors.grey;
}
