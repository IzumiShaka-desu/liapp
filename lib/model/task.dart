class Task {
  String name;
  TaskType type;
  DateTime date;
  bool isDone;
  Task({
    required this.date,
    required this.isDone,
    required this.name,
    required this.type,
  });
}

enum TaskType { personal, business }
