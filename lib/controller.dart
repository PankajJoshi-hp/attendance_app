import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/todoModal.dart';

class Controller extends GetxController {
  String text = 'No todos added';
  var todoList = <Todo>[].obs;
  final TextEditingController textController = TextEditingController();

  void setText() {
    String newText = textController.text.trim();
    if (newText.isNotEmpty) {
      todoList.add(Todo(id: DateTime.now().toString(), title: newText));
      textController.clear();
    }
  }

  void updateTodo(String id, String newTitle) {
    final index = todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todoList[index] = Todo(id: id, title: newTitle);
    }
    textController.clear();
  }

  void toggleTodoStatus(
    String id,
  ) {
    final index = todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todoList[index] = Todo(
          id: id,
          title: todoList[index].title,
          isCompleted: !todoList[index].isCompleted);
    }
  }

  void deleteTodo(String id) {
    todoList.removeWhere((todo) => todo.id == id);
  }
}
