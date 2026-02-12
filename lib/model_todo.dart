import 'dart:convert';

import 'package:flutter/material.dart';

class TodoItem {
  int id;
  String title;
  String category;
  int priority;
  String description;
  DateTime time;
  DateTime dueTime;

  bool isDone;

  TodoItem({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.description,
    required this.time,
    required this.dueTime,
    this.isDone = false,
  });
  String get formattedDueTime {
    DateTime now = DateTime.now();

    if (dueTime.year == now.year &&
        dueTime.month == now.month &&
        dueTime.day == now.day) {
      return "Today ${dueTime.hour}:${dueTime.minute.toString().padLeft(2, '0')}";
    }

    return "${dueTime.day}/${dueTime.month} "
        "${dueTime.hour}:${dueTime.minute.toString().padLeft(2, '0')}";
  }

  static String encodeTasks(List<TodoItem> tasks) {
    return json.encode(tasks.map((t) => t.toJson()).toList());
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      category: json['category'] ?? 'Work',
      priority: json['priority'] is int
          ? json['priority']
          : int.tryParse(json['priority'].toString()) ?? 1,
      description: json['description'] ?? '',
      time: json['time'] != null
          ? DateTime.parse(json['time'])
          : DateTime.now(),
      dueTime: json['dueTime'] != null
          ? DateTime.parse(json['dueTime'])
          : DateTime.now(),
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'priority': priority,
      'description': description,
      'time': time.toIso8601String(),
      'dueTime': dueTime.toIso8601String(),
      'isDone': isDone,
    };
  }

  static IconData getTaskIcon(String category) {
    const icons = {
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
    return icons[category] ?? Icons.add_box_outlined;
  }

  static Color getIconColor(String category) {
    switch (category) {
      case 'Grocery':
        return const Color(0xff21A300);
      case 'Work':
        return const Color(0xffA31D00);
      case 'Sport':
        return const Color(0xff00A32F);
      case 'Design':
        return const Color(0xff00A372);
      case 'University':
        return const Color(0xff0055A3);
      case 'Social':
        return const Color(0xffA30089);
      case 'Music':
        return const Color(0xffA000A3);
      case 'Health':
        return const Color(0xff00A3A3);
      case 'Movie':
        return const Color(0xff0069A3);
      case 'Home':
        return const Color(0xffA36200);
      case 'Create New':
        return const Color(0xff00A369);
      default:
        return Colors.white;
    }
  }

  static Color getContainerColor(String category) {
    switch (category) {
      case 'Grocery':
        return const Color(0xffCCFF80);
      case 'Work':
        return const Color(0xffFF9680);
      case 'Sport':
        return const Color(0xff80FFFF);
      case 'Design':
        return const Color(0xff80FFD9);
      case 'University':
        return const Color(0xff809CFF);
      case 'Social':
        return const Color(0xffFF80EB);
      case 'Music':
        return const Color(0xffFC80FF);
      case 'Health':
        return const Color(0xff80FFA3);
      case 'Movie':
        return const Color(0xff80D1FF);
      case 'Home':
        return const Color(0xffFFCC80);
      case 'Create New':
        return const Color(0xff80FFD1);
      default:
        return Colors.grey;
    }
  }

  static List<TodoItem> tasks() {
    return [];
  }
}
