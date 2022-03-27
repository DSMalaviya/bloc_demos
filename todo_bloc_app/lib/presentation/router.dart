import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/cubit/addtodo_cubit.dart';
import 'package:todo_bloc_app/cubit/edittodo_cubit.dart';
import 'package:todo_bloc_app/cubit/todos_cubit.dart';
import 'package:todo_bloc_app/data/models/todo.dart';
import 'package:todo_bloc_app/data/network_service.dart';
import 'package:todo_bloc_app/data/repository.dart';
import 'package:todo_bloc_app/presentation/screens/add_todos_screen.dart';
import 'package:todo_bloc_app/presentation/screens/edit_todo_screen.dart';
import 'package:todo_bloc_app/presentation/screens/todos_screen.dart';

class AppRouter {
  late final NetworkService networkService = NetworkService();
  late final Repository repository = Repository(networkService: networkService);
  late final todoscubit = TodosCubit(repository: repository);

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TodosCubit>.value(
            value: todoscubit,
            child: TodosScreen(),
          ),
        );
      case "/edit_todo":
        return MaterialPageRoute(
          builder: (context) => BlocProvider<EdittodoCubit>(
            create: (context) => EdittodoCubit(repository, todoscubit),
            child: EditTodoScreen(todo: settings.arguments as Todo),
          ),
        );
      case "/add_todo":
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AddtodoCubit>(
            create: (context) => AddtodoCubit(repository, todoscubit),
            child: AddTodoScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const TodosScreen(),
        );
    }
  }
}
