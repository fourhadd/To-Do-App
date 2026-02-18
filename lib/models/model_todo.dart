import 'dart:convert';

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

  static List<TodoItem> tasks() {
    return [];
  }
}
