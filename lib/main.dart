import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './naveen.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var table = Naveen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'County',
                  style: TextStyle(fontFamily: "Pacifico", fontSize: 30.0),
                ),
              ],
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, right: 5.0, bottom: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "naveen",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: "Pacifico", fontSize: 30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Naveen(),
        ),
      ),
    );
  }
}
