import 'package:flutter/material.dart';

void main() {
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

class Todo {
  final String id;
  String title;
  bool isCompleted;
  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}

class _HomePageState extends State<HomePage> {
  String text = 'No todos added';
  final List<Todo> todoList = [];
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void setText() {
    String newText = textController.text.trim();
    if (newText.isNotEmpty) {
      setState(() {
        todoList.add(Todo(id: DateTime.now().toString(), title: newText));
        print(todoList);
        textController.clear();
      });
    }
  }

  void updateTodo(String id, String newTitle) {
    setState(() {
      final index = todoList.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        todoList[index].title = newTitle;
      }
      textController.clear();
    });
  }

  void toggleTodoStatus(
    String id,
  ) {
    setState(() {
      final index = todoList.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        todoList[index].isCompleted = !todoList[index].isCompleted;
      }
    });
  }

  openDialogBox(context, todo, isUpdate) {
    showDialog(
        context: context,
        barrierDismissible: false,
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
                          onChanged: (value) => text = value,
                          controller: textController,
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (isUpdate == true) {
                                  updateTodo(
                                      todo.id, textController.text.trim());
                                } else {
                                  setText();
                                }
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
      // backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: 1,
          ),
          todoList.isEmpty
              ? Text('No todos added')
              : Expanded(
                  child: ListView(
                      children: todoList
                          .map((todo) => Card(
                              child: ListTile(
                                  leading: Checkbox(
                                    activeColor: Colors.lightGreen,
                                    value: todo.isCompleted,
                                    onChanged: (_) => toggleTodoStatus(todo.id),
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
                                            color: Colors.lightGreen,
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
                                                textController.text =
                                                    todo.title;
                                                openDialogBox(
                                                    context, todo, true);
                                              },
                                              child: Icon(Icons.edit,
                                                  size: 24,
                                                  color: Colors.lightBlue))
                                          : Text(''),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            todoList.remove(todo);
                                          });
                                        },
                                        child: Icon(Icons.delete,
                                            size: 24, color: Colors.red),
                                      ),
                                    ],
                                  ))))
                          .toList()),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () => openDialogBox(context, null, false),
        child: const Text(
          '+',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
