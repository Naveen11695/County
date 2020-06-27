import 'package:flutter/material.dart';
import 'Componets/Calender.dart';
import 'Database.dart';
import 'package:intl/intl.dart';

class Naveen extends StatefulWidget {
  Naveen() : super();

  @override
  _Naveen createState() => _Naveen();
}

class _Naveen extends State<Naveen> {
  static double totalSum = 0;
  static double totalAmount = 0;
  static double spent = 0;
  final formatter = new NumberFormat("#,###");

  final _ctotal = TextEditingController();
  final _ctitle = TextEditingController();
  final _cdetails = TextEditingController();
  final _camount = TextEditingController();

  double metroAmount = 0.0;

  @override
  void initState() {
    viewTotalTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
          future: viewSumTable("naveen"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == "error") {
                print("Error");
                return Container();
              } else {
                if (snapshot.data != null)
                  spent = double.parse(snapshot.data.toString());
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 0.0, bottom: 20.0),
                      child: Column(
                        children: <Widget>[
                          Calender(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                                future: viewTotalTable(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.data == "error") {
                                      print("Error");
                                      return Container();
                                    } else {
                                      if (snapshot.data.toString() != '[]') {
                                        totalAmount = double.parse(snapshot
                                            .data[0]
                                            .toString());
                                        metroAmount = double.parse(snapshot
                                            .data[1]
                                            .toString());
                                      }
                                      return Column(
                                        children: <Widget>[
                                          Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            children: <Widget>[
                                              Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                alignment: WrapAlignment.center,
                                                children: <Widget>[
                                                  new Text(
                                                    "Total Amount: ₹ ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Pacifico",
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                  new InkWell(
                                                    onTap: () {
                                                      _displayTotalDialog(context);
                                                    },
                                                    child: new Text(
                                                      formatter.format(totalAmount),
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: "Pacifico",
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0, right: 20.0),
                                                child: new Container(
                                                  height: 40,
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                children: <Widget>[
                                                  new Text(
                                                    "Metro Expense: ₹ ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Pacifico",
                                                        fontWeight:
                                                        FontWeight.w200),
                                                  ),
                                                  new Text(
                                                    formatter.format(metroAmount),
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontFamily: "Pacifico",
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0, right: 20.0),
                                            child: new Container(
                                              height: 1,
                                              width: 400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Wrap(
                                            alignment:
                                                WrapAlignment.center,
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: <Widget>[
                                              Wrap(
                                                alignment:
                                                WrapAlignment.center,
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                children: <Widget>[
                                                  new Text(
                                                    "Spent: ₹ ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Pacifico",
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  new Text(
                                                    formatter.format(spent),
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Pacifico",
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0, right: 20.0),
                                                child: new Container(
                                                  height: 40,
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Wrap(
                                                alignment:
                                                WrapAlignment.center,
                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                children: <Widget>[
                                                  new Text(
                                                    "Remaining: ₹ ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Pacifico",
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  new Text(
                                                    formatter
                                                        .format(totalAmount - spent)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Pacifico",
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  } else {
                                    return Center(
                                      child: Container(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 200.0, bottom: 70),
                      child: FutureBuilder(
                          future: viewTable("naveen"),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == "error") {
                                print("Error");
                                return Container();
                              } else {
                                if (snapshot.data.toString() == "[]") {
                                  spent = 0;
                                }
                                setList(snapshot.data);
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    return new ExpansionTile(
                                      title: Row(
                                        children: <Widget>[
                                          Text(
                                            trs[i].title,
                                            style: new TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: "Pacifico",
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              color: trs[i].title.compareTo(
                                                          "METRO RECHARGE") ==
                                                      0
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 10),
                                            child: Text(
                                              trs[i].timeStamp,
                                              style: new TextStyle(
                                                  fontSize: 15.0,
                                                  fontFamily: "Pacifico",
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: <Widget>[
                                        new Column(
                                          children:
                                              _buildExpandableContent(trs[i]),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else {
                              return Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                );
              }
            } else {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.extended(
                onPressed: () async {
                 setState(() {
                   removeEntryFromTable("naveen");
                 });
                },
                backgroundColor: Colors.red,
                icon: Icon(Icons.remove),
                label: Text(
                  "Remove transaction",
                  style: TextStyle(fontFamily: "Pacifico", fontSize: 12.0),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FloatingActionButton.extended(
                  onPressed: () async {
                    _displayDialog(context);
                  },
                  backgroundColor: Colors.green,
                  icon: Icon(Icons.add),
                  label: Text(
                    "Add new transaction",
                    style: TextStyle(fontFamily: "Pacifico", fontSize: 12.0),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _buildExpandableContent(transaction trans) {
    List<Widget> columnContent = [];
    for (String content in trans.contents) {
      columnContent.add(
        new ListTile(
          title: new Text(
            content,
            style: new TextStyle(
              fontFamily: "Pacifico",
              fontSize: 18.0,
              color: trans.title.compareTo("METRO RECHARGE") == 0
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          leading: new Icon(trans.icon),
          trailing: new Text(
            " + ₹ " + trans.amount.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Pacifico",
              fontSize: 18.0,
              color: trans.title.compareTo("METRO RECHARGE") == 0
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ),
      );
    }
    return columnContent;
  }

  void setList(data) async {
    trs.clear();
    for (int i = 0; i < data.length; i++) {
      trs.add(new transaction(
        data[i]["title"],
        [data[i]["detail"]],
        double.parse(data[i]["amount"].toString()),
        data[i]["timeStamp"].toString(),
        Icons.monetization_on,
      ));
    }
  }

  _displayTotalDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Total Amount',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontFamily: "Pacifico"),
            ),
            content: TextField(
              controller: _ctotal,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter total amount",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Pacifico",
                      letterSpacing: 2.0,
                      wordSpacing: 2.0)),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'SUBMIT',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontFamily: "Pacifico"),
                ),
                onPressed: () {
                  setState(() {
                    insertTotalToTable(double.parse(_ctotal.text));
                    Navigator.of(context).pop();
                  });
                },
              ),
              new FlatButton(
                child: new Text(
                  'CANCEL',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontFamily: "Pacifico"),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'New Transcation',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontFamily: "Pacifico"),
            ),
            content: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    controller: _ctitle,
                    decoration: InputDecoration(
                        hintText: "title",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Pacifico",
                            letterSpacing: 2.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: TextField(
                    controller: _cdetails,
                    decoration: InputDecoration(
                        hintText: "detail",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Pacifico",
                            letterSpacing: 2.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110.0),
                  child: TextField(
                    controller: _camount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "amount",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Pacifico",
                            letterSpacing: 2.0)),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  new FlatButton(
                    child: new Text(
                      'ADD METRO RECHARGE',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: "Pacifico", color: Colors.green),
                    ),
                    onPressed: () {
                      setState(() {
                        insertTotable("naveen", "METRO RECHARGE",
                            "Metro Recharge of ₹500", 500.0);
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: "Pacifico", color: Colors.red),
                    ),
                    onPressed: () {
                      setState(() {
                        insertTotable("naveen", _ctitle.text, _cdetails.text,
                            double.parse(_camount.text));
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      'CANCEL',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontFamily: "Pacifico"),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}

class transaction {
  final String title;
  final double amount;
  List<String> contents = [];
  final String timeStamp;
  final IconData icon;

  transaction(
      this.title, this.contents, this.amount, this.timeStamp, this.icon);
}

List<transaction> trs = [];
