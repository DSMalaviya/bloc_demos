part of 'edittodo_cubit.dart';

@immutable
abstract class EdittodoState {}

class EdittodoInitial extends EdittodoState {}

class EditedCompletedTodo extends EdittodoState {}

class DeleteTodo extends EdittodoState {}

class ErrorState extends EdittodoState {}
