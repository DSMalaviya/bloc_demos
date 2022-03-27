import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/cubit/edittodo_cubit.dart';
import 'package:todo_bloc_app/data/models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.todo.todoMessage;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit todo"),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<EdittodoCubit>(context, listen: false)
                  .deleteTodo(widget.todo.id);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocListener<EdittodoCubit, EdittodoState>(
        listener: (context, state) {
          if (state is DeleteTodo || state is EditedCompletedTodo) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          child: Column(
            children: [
              TextField(
                autocorrect: false,
                controller: controller,
                decoration: InputDecoration(labelText: "Edit todo...."),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<EdittodoCubit>(context, listen: false)
                      .updateTodo(widget.todo.id, controller.text);
                },
                child: Text("edit todo"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
