import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  final String baseurl = "http://127.0.0.1:3000";
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(baseurl + "/todos"));
      List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await http.patch(Uri.parse(baseurl + "/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> addTodo(Map<String, String> todoObj) async {
    try {
      final response =
          await http.post(Uri.parse(baseurl + "/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  deleteTodo(int id) async {
    try {
      await http.delete(Uri.parse(baseurl + "/todos/$id"));
    } catch (e) {
      rethrow;
    }
  }
}
