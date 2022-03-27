class Todo {
  String todoMessage;
  bool isCompleted;
  final int id;

  Todo(
      {required this.todoMessage, required this.isCompleted, required this.id});

  Todo.fromJson(Map json)
      : todoMessage = json['todo'],
        isCompleted = json['isCompleted'] == "true",
        id = json['id'] as int;
}
