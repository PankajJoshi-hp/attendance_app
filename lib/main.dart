import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller.dart';
import 'package:todo_app/todoModal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Controller todos = Get.put(Controller());
  await todos.loadTodoList();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final Controller todos = Get.find<Controller>();

  openDialogBox(context, todo, isUpdate) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Text field cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) => todos.text = value,
                          controller: todos.textController,
                          decoration: InputDecoration(
                            label: Text(
                              'Enter your task here...',
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.lightGreen, width: 2),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.lightGreen, width: 2),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (isUpdate == true) {
                                  todos.updateTodo(todo.id,
                                      todos.textController.text.trim());
                                } else {
                                  todos.setText();
                                }
                                await todos.saveTodoList(todos.todoList);
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.lightGreen),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                            child: Text('Submit'.toUpperCase(),
                                style: TextStyle(color: Colors.white)))
                      ],
                    ),
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo".toUpperCase(),
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: 1,
          ),
          Obx(() => Expanded(
                child: todos.todoList.isEmpty
                    ? Center(
                        child: Text(
                          'Please add some todos 🤧.',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                      )
                    : ListView(
                        children: todos.todoList
                            .map((todo) => Card(
                                child: ListTile(
                                    leading: Checkbox(
                                      activeColor: Colors.lightBlue,
                                      value: todo.isCompleted,
                                      onChanged: (_) async {
                                        todos.toggleTodoStatus(todo.id);
                                        await todos
                                            .saveTodoList(todos.todoList);
                                      },
                                    ),
                                    title: todo.isCompleted == false
                                        ? Text(
                                            todo.title,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          )
                                        : Text(
                                            todo.title,
                                            style: TextStyle(
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 5,
                                      children: <Widget>[
                                        todo.isCompleted == false
                                            ? InkWell(
                                                onTap: () {
                                                  todos.textController.text =
                                                      todo.title;
                                                  openDialogBox(
                                                      context, todo, true);
                                                },
                                                child: Icon(Icons.edit,
                                                    size: 24,
                                                    color: Colors.lightBlue))
                                            : Text(''),
                                        InkWell(
                                          onTap: () async {
                                            todos.deleteTodo(todo.id);
                                            await todos
                                                .saveTodoList(todos.todoList);
                                          },
                                          child: Icon(Icons.delete,
                                              size: 24, color: Colors.red),
                                        ),
                                      ],
                                    ))))
                            .toList()),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          todos.textController.clear();
          openDialogBox(context, null, false);
        },
        child: const Text(
          '+',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
