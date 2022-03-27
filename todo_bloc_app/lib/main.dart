import 'package:flutter/material.dart';
import 'package:todo_bloc_app/presentation/router.dart';

void main() {
  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router}) : super(key: key);

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: "/",
    );
  }
}
//json-server --watch db.json
