import 'dart:developer';

import 'package:todo_bloc_app/data/models/todo.dart';
import 'package:todo_bloc_app/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Todo>> fetchTodos() async {
    final todosData = await networkService.fetchTodos();
    log(todosData.toString());
    return todosData.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String text) async {
    final todoObj = {"todo": text, "isCompleted": "false"};
    Map data = await networkService.addTodo(todoObj);
    return Todo.fromJson(data);
  }

  Future<void> deleteTodo(int id) async {
    await networkService.deleteTodo(id);
  }

  Future<void> updateTodo(int id, String text) async {
    final patchObj = {"todo": text};
    await networkService.patchTodo(patchObj, id);
  }
}
