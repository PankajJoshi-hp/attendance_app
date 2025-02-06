import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/reusable_widgets/todo_modal.dart';

class Controller extends GetxController {
  String text = 'No todos added';
  var todoList = <Todo>[].obs;
  final TextEditingController textController = TextEditingController();

  Future<void> saveTodoList(List<Todo> todoList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        todoList.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todo_list', jsonStringList);
  }

  Future<void> loadTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('todo_list');
    if (jsonStringList != null) {
      todoList.assignAll(jsonStringList
          .map((jsonString) => Todo.fromJson(jsonDecode(jsonString))));
    }
  }

  void setText() async {
    String newText = textController.text.trim();
    if (newText.isNotEmpty) {
      todoList.add(Todo(id: DateTime.now().toString(), title: newText));
      textController.clear();
      await saveTodoList(todoList);
    }
  }

  void updateTodo(String id, String newTitle) async {
    final index = todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todoList[index] = Todo(id: id, title: newTitle);
    }
    textController.clear();
    await saveTodoList(todoList);
  }

  void toggleTodoStatus(
    String id,
  ) async {
    final index = todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todoList[index] = Todo(
          id: id,
          title: todoList[index].title,
          isCompleted: !todoList[index].isCompleted);
      await saveTodoList(todoList);
    }
  }

  void deleteTodo(String id) async {
    todoList.removeWhere((todo) => todo.id == id);
    await saveTodoList(todoList);
  }
}
