import 'package:flutter/material.dart';

class Todo {
  int id;
  String title;
  String category;
  String priority;
  String description;
  DateTime time;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.description,
    required this.time,
    this.isDone = false,
  });

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
    return icons[category] ?? Icons.category_outlined;
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
        return Colors.black;
    }
  }

  static List<Todo> tasks() {
    return [
      Todo(
        id: 1,
        title: "Math Homework",
        category: "Grocery",
        priority: "1",
        description: "Complete algebra exercises",
        time: DateTime.now().add(Duration(hours: 2)),
        isDone: false,
      ),
      Todo(
        id: 2,
        title: "Grocery Shopping",
        category: "Work",
        priority: "2",
        description: "Buy vegetables and fruits",
        time: DateTime.now().add(Duration(days: 1)),
        isDone: false,
      ),
      Todo(
        id: 3,
        title: "Read Book",
        category: "Music",
        priority: "3",
        description: "Read 30 pages of a novel",
        time: DateTime.now().add(Duration(days: 1, hours: 3)),
        isDone: false,
      ),
      Todo(
        id: 4,
        title: "Workout",
        category: "Health",
        priority: "4",
        description: "1-hour gym session",
        time: DateTime.now().add(Duration(hours: 5)),
        isDone: false,
      ),
      Todo(
        id: 5,
        title: "Call Mom",
        category: "Home",
        priority: "5",
        description: "Check how she is doing",
        time: DateTime.now().add(Duration(hours: 4)),
        isDone: false,
      ),
    ];
  }
}
