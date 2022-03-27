import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_app/cubit/todos_cubit.dart';
import 'package:todo_bloc_app/data/repository.dart';

part 'addtodo_state.dart';

class AddtodoCubit extends Cubit<AddtodoState> {
  AddtodoCubit(this.repository, this.todosCubit) : super(AddtodoInitial());

  final Repository repository;
  final TodosCubit todosCubit;

  void addTodo(String text) {
    if (text.isEmpty) {
      emit(AddTodoError("Todo message is required"));
      return;
    }
    emit(AddingTodo());
    Timer(const Duration(seconds: 2), () {
      repository.addTodo(text).then((value) => {todosCubit.addTodo(value)});
      emit(TodoAdded());
    });
  }
}
