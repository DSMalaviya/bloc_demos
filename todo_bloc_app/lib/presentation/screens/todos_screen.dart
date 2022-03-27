import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/cubit/todos_cubit.dart';

import '../../data/models/todo.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchtodos();
    return Scaffold(
      appBar: AppBar(
        title: Text("todos"),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed("/add_todo"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<TodosCubit, TodosState>(
          builder: (context, state) {
            if (!(state is TodosLoaded)) {
              return Center(child: CircularProgressIndicator());
            }
            final todos = (state as TodosLoaded).todos;

            return SingleChildScrollView(
              child: Column(
                children: [...todos.map((e) => _todo(e, context)).toList()],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _todo(Todo todo, BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).pushNamed("/edit_todo", arguments: todo),
    child: Dismissible(
      background: Container(
        color: Colors.indigo,
      ),
      confirmDismiss: (_) async {
        BlocProvider.of<TodosCubit>(context, listen: false)
            .changeCompletion(todo);
        return false;
      },
      key: Key(todo.id.toString()),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(.2),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(todo.todoMessage),
            _completionIndicator(todo),
          ],
        ),
      ),
    ),
  );
}

Widget _completionIndicator(Todo todo) {
  return Container(
    height: 20,
    width: 20,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(
          width: 4.0, color: todo.isCompleted ? Colors.green : Colors.red),
    ),
  );
}
