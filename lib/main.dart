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
  bool isCompleted = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Todo".toUpperCase(),
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        )),
        backgroundColor: Colors.lightGreen,
      ),
      body: todoList.isEmpty
          ? Text('No todos added')
          : ListView(
              children: todoList
                  .map((todo) => Card(
                      child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) => toggleTodoStatus(todo.id),
                          ),
                          title: Text(todo.title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: <Widget>[
                              InkWell(
                                  onTap: () {
                                    textController.text = todo.title;
                                    print('edit clicked ${todo.title}');
                                    print(
                                        '*************************************');
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                              child: Padding(
                                                padding: EdgeInsets.all(30),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    TextFormField(
                                                      maxLines: 3,
                                                      onChanged: (value) =>
                                                          text = value,
                                                      controller:
                                                          textController,
                                                      decoration:
                                                          InputDecoration(
                                                        label: Text(
                                                          'Enter your task here...',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightGreen),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (textController
                                                              .text
                                                              .trim()
                                                              .isNotEmpty) {
                                                            updateTodo(
                                                                todo.id,
                                                                textController
                                                                    .text
                                                                    .trim());
                                                          }
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStatePropertyAll(
                                                                    Colors
                                                                        .lightGreen),
                                                            shape: WidgetStatePropertyAll(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)))),
                                                        child: Text(
                                                            'Submit'
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Icon(Icons.edit,
                                      size: 24, color: Colors.lightGreen)),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    todoList.remove(todo);
                                  });
                                },
                                child: Icon(Icons.delete,
                                    size: 24, color: Colors.lightGreen),
                              ),
                            ],
                          ))))
                  .toList()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          maxLines: 3,
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
                            onPressed: setText,
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
                  ),
                )),
        child: const Text(
          '+',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
