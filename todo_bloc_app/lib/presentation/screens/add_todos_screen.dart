import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/cubit/addtodo_cubit.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add todo"),
      ),
      body: BlocListener<AddtodoCubit, AddtodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.of(context).pop();
            return;
          } else if (state is AddTodoError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error")));
          }
        },
        child: Container(
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: controller,
                decoration: InputDecoration(labelText: "Enter Todo message..."),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AddtodoCubit>(context, listen: false)
                      .addTodo(controller.text);
                },
                child: BlocBuilder<AddtodoCubit, AddtodoState>(
                  builder: (context, state) {
                    if (state is AddingTodo) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text("Add todo");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
