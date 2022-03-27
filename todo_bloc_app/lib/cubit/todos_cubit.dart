import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_app/data/models/todo.dart';
import 'package:todo_bloc_app/data/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit({required this.repository}) : super(TodosInitial());

  final Repository repository;

  void fetchtodos() {
    Timer(const Duration(seconds: 3), () {
      repository.fetchTodos().then((value) {
        emit(TodosLoaded(todos: value));
      });
    });
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isCompleted, todo.id).then((value) {
      if (value == true) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (state is TodosLoaded) {
      emit(TodosLoaded(todos: (currentState as TodosLoaded).todos));
    }
  }

  addTodo(Todo value) {
    if (state is TodosLoaded) {
      List<Todo> todos = (state as TodosLoaded).todos..add(value);
      emit(TodosLoaded(todos: todos));
    }
  }

  void deleteTodo(int id) {
    if (state is TodosLoaded) {
      List<Todo> todos = (state as TodosLoaded).todos
        ..removeWhere((element) => element.id == id);
      emit(TodosLoaded(todos: todos));
    }
  }

  void editTodo(int id, String text) {
    if (state is TodosLoaded) {
      int index = (state as TodosLoaded)
          .todos
          .indexWhere((element) => element.id == id);
      List<Todo> todos = (state as TodosLoaded).todos;
      todos[index].todoMessage = text;
      emit(TodosLoaded(todos: todos));
    }
  }
}
