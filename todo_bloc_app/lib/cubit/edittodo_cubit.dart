import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_app/cubit/todos_cubit.dart';
import 'package:todo_bloc_app/data/repository.dart';

part 'edittodo_state.dart';

class EdittodoCubit extends Cubit<EdittodoState> {
  EdittodoCubit(this.repository, this.todosCubit) : super(EdittodoInitial());

  final Repository repository;
  final TodosCubit todosCubit;

  deleteTodo(int id) async {
    repository.deleteTodo(id).then((value) {
      emit(DeleteTodo());
      todosCubit.deleteTodo(id);
    });
  }

  updateTodo(int id, String text) async {
    repository.updateTodo(id, text).then((value) {
      emit(EditedCompletedTodo());
      todosCubit.editTodo(id, text);
    });
  }
}
