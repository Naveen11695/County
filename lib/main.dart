import 'package:flutter/material.dart';
import './naveen.dart';

void main() => runApp(MyHomePage());



class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.grey,
              labelStyle: TextStyle(fontFamily: "Pacifico",fontSize: 20.0, fontWeight: FontWeight.bold,),
              tabs: [
                Tab(icon: Icon(Icons.account_circle,size: 20,), text: "Naveen",)
              ],
            ),
            backgroundColor: Colors.green,
            title: Text('County', style: TextStyle(fontFamily: "Pacifico",fontSize: 30.0),),
          ),
          body: TabBarView(
            children: [
              Naveen(),
            ],
          ),
        ),
      ),
    );
  }
}
