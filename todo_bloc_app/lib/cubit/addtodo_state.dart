part of 'addtodo_cubit.dart';

@immutable
abstract class AddtodoState {}

class AddtodoInitial extends AddtodoState {}

class AddTodoError extends AddtodoState {
  final String error;

  AddTodoError(this.error);
}

class AddingTodo extends AddtodoState {}

class TodoAdded extends AddtodoState {}
