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

class _HomePageState extends State<HomePage> {
  late String title;
  String text = 'No todos added';

  void setText() {
    text = title;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      body: Column(
        children: <Widget>[
          Container(
            child: Text(text),
          )
        ],
      ),
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
                          onChanged: (value) => title = value,
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
