import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Chat with Phoenix Presence', user: 'Glenn'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final String user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    color: Color(0xFFD9EDF7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Hello, " + widget.user + "!"),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(4.0, 0.0, 18.0, 0.0),
                  width: 172.0, // hack
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Messages",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 200.0,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(5.0),
                          border: new Border.all(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Text("yo");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 172.0, // hack
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Who's Online",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Text("yo");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 8.0, 0.0, 0.0),
              child: TextField(
                controller: this.textController,
                onSubmitted: (String value) {
                  setState(() {

                  });
                  this.textController.clear();
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Type and press enter...",
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
