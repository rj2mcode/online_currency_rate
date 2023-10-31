import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          //Top Header
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              const SizedBox(
                width: 12,
              ),
              const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ))),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Currency Rate",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
              Image.asset("assets/images/top_header_icon.png")
            ],
          ),

          //Body Content
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/question_icon.png"),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "About Rate fee",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
