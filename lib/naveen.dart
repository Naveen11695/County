import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  final _cNewName = TextEditingController();

  double metroAmount = 0.0;

  String divider = "";

  String errorMessage = "";

  @override
  void initState() {
    viewTotalTable();
    super.initState();
    for (var i = 0; i < 200; i++) {
      divider = divider + " - ";
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      elevation: 20,
                      onPressed: () {
                        // _displayDialog(context);
                        _addNewTransaction(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0))),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                    )),
                Container(
                  height: 30,
                  width: 10,
                  color: Colors.black,
                ),
                Expanded(
                    child: RaisedButton(
                      elevation: 20,
                      onPressed: () {
                        setState(() {
                          removeLastEntryFromTable("naveen");
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                    )),
              ],
            ),
          ),
        ),
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
                            top: 0.0, left: 0.0, bottom: 10.0),
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
                                          totalAmount = double.parse(
                                              snapshot.data[0].toString());
                                          metroAmount = double.parse(
                                              snapshot.data[1].toString());
                                        }
                                        return Column(
                                          children: <Widget>[
                                            Wrap(
                                              crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    new Text(
                                                      "Total Amount",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                          "Pacifico",
                                                          fontWeight:
                                                          FontWeight.w200),
                                                    ),
                                                    new InkWell(
                                                      onTap: () {
                                                        _displayTotalDialog(
                                                            context);
                                                      },
                                                      child: new Text(
                                                        "₹ " +
                                                            formatter.format(
                                                                totalAmount),
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontFamily:
                                                            "Pacifico",
                                                            color:
                                                            Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 30.0,
                                                      right: 20.0),
                                                  child: new Container(
                                                    height: 40,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    new Text(
                                                      "Papa's balance",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                          "Pacifico",
                                                          fontWeight:
                                                          FontWeight.w200),
                                                    ),
                                                    new Text(
                                                      "₹ " +
                                                          formatter.format(
                                                              spent -
                                                                  metroAmount),
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily:
                                                          "Pacifico",
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 30.0,
                                                      right: 20.0),
                                                  child: new Container(
                                                    height: 40,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    new Text(
                                                      "Metro Expense",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                          "Pacifico",
                                                          fontWeight:
                                                          FontWeight.w200),
                                                    ),
                                                    new Text(
                                                      "₹ " +
                                                          formatter.format(
                                                              metroAmount),
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily:
                                                          "Pacifico",
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
                                              alignment: WrapAlignment.center,
                                              crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    new Text(
                                                      "Spent",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                          "Pacifico",
                                                          fontWeight:
                                                          FontWeight.w300),
                                                    ),
                                                    new Text(
                                                      "₹ " +
                                                          formatter
                                                              .format(spent),
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily:
                                                          "Pacifico",
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 30.0,
                                                      right: 20.0),
                                                  child: new Container(
                                                    height: 40,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    new Text(
                                                      "Remaining",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                          "Pacifico",
                                                          fontWeight:
                                                          FontWeight.w300),
                                                    ),
                                                    new Text(
                                                      "₹ " +
                                                          formatter
                                                              .format(
                                                              totalAmount -
                                                                  spent)
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily:
                                                          "Pacifico",
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
                        padding: const EdgeInsets.only(top: 240.0, bottom: 10),
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
                                    itemCount: snapshot.data.length + 1,
                                    itemBuilder: (context, i) {
                                      if (i == snapshot.data.length) {
                                        return Container(
                                          height: 100.0,
                                        );
                                      } else {
                                        return Dismissible(
                                          background: slideRightBackground(),
                                          secondaryBackground:
                                          slideLeftBackground(),
                                          key: new Key(trs[i].timeStamp),
                                          confirmDismiss: (DismissDirection
                                          direction) async {
                                            if (direction ==
                                                DismissDirection.endToStart) {
                                              return await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                    const Text("Confirm"),
                                                    content: Wrap(
                                                      children: [
                                                        Text(
                                                            "Are you sure you wish to delete"),
                                                        Text(
                                                          " ${trs[i].title}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        Text("?"),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () async {
                                                            removeEntryFromTable(
                                                                "naveen",
                                                                trs[i].id)
                                                                .then((value) {
                                                              if (value) {
                                                                setState(() {
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(
                                                                      true);
                                                                  _scaffoldKey
                                                                      .currentState
                                                                      .showSnackBar(
                                                                      new SnackBar(
                                                                          content:
                                                                          Text(
                                                                              "${trs[i]
                                                                                  .title} is deleted successfully")));
                                                                });
                                                              } else {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop(false);
                                                                _scaffoldKey
                                                                    .currentState
                                                                    .showSnackBar(
                                                                    new SnackBar(
                                                                        content:
                                                                        Text(
                                                                            "Failed to delete ${trs[i]
                                                                                .title}")));
                                                              }
                                                            });
                                                          },
                                                          child: const Text(
                                                            "DELETE",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          )),
                                                      FlatButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                context)
                                                                .pop(false);
                                                          },
                                                          child: const Text(
                                                            "CANCEL",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          )),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              return await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                    const Text("Confirm"),
                                                    content: Wrap(
                                                      children: [
                                                        Text(
                                                            "Are you sure you wish to rename"),
                                                        Text(
                                                          " ${trs[i].title}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        Text("?"),
                                                        TextField(
                                                          controller: _cNewName,
                                                          keyboardType:
                                                          TextInputType
                                                              .text,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                              "Enter new title",
                                                              hintStyle: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontFamily:
                                                                  "Pacifico",
                                                                  letterSpacing:
                                                                  2.0,
                                                                  wordSpacing:
                                                                  2.0)),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () async {
                                                            if (_cNewName.text
                                                                .isNotEmpty) {
                                                              renameEntryFromTable(
                                                                  "naveen",
                                                                  trs[i].id,
                                                                  _cNewName
                                                                      .text
                                                                      .trim())
                                                                  .then(
                                                                      (value) {
                                                                    if (value) {
                                                                      setState(() {
                                                                        _cNewName
                                                                            .text =
                                                                        "";
                                                                        Navigator
                                                                            .of(
                                                                            context)
                                                                            .pop(
                                                                            true);
                                                                        _scaffoldKey
                                                                            .currentState
                                                                            .showSnackBar(
                                                                            new SnackBar(
                                                                                content:
                                                                                Text(
                                                                                    "${trs[i]
                                                                                        .title} is rename successfully")));
                                                                      });
                                                                    } else {
                                                                      Navigator
                                                                          .of(
                                                                          context)
                                                                          .pop(
                                                                          false);
                                                                      _scaffoldKey
                                                                          .currentState
                                                                          .showSnackBar(
                                                                          new SnackBar(
                                                                              content:
                                                                              Text(
                                                                                  "Failed to rename ${trs[i]
                                                                                      .title}")));
                                                                    }
                                                                  });
                                                            }
                                                          },
                                                          child: const Text(
                                                            "RENAME",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          )),
                                                      FlatButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                context)
                                                                .pop(false);
                                                          },
                                                          child: const Text(
                                                            "CANCEL",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          )),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                divider,
                                                textAlign: TextAlign.end,
                                                maxLines: 1,
                                                style: new TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "Pacifico",
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.2,
                                                    fontStyle:
                                                    FontStyle.italic),
                                              ),
                                              new ExpansionTile(
                                                backgroundColor: Colors.black87,
                                                title: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              trs[i]
                                                                  .title
                                                                  .toUpperCase(),
                                                              style: new TextStyle(
                                                                  fontSize:
                                                                  15.0,
                                                                  fontFamily:
                                                                  "Montserrat",
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                                  letterSpacing:
                                                                  0.5,
                                                                  color: textColor(
                                                                      trs[i])),
                                                            ),
                                                          ),
                                                        ]),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                      child: Text(
                                                        dateformat(
                                                            trs[i].timeStamp),
                                                        textAlign:
                                                        TextAlign.end,
                                                        maxLines: 1,
                                                        style: new TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                            "Pacifico",
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            letterSpacing: 0.8,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                children: <Widget>[
                                                  new Column(
                                                    children:
                                                    _buildExpandableContent(
                                                        trs[i]),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                divider,
                                                textAlign: TextAlign.end,
                                                maxLines: 1,
                                                style: new TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "Pacifico",
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.2,
                                                    fontStyle:
                                                    FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
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
              fontFamily: "Raleway",
              fontSize: 18.0,
              color: trans.title.compareTo("METRO RECHARGE") == 0 ||
                  trans.amount < 0
                  ? Colors.blueGrey
                  : Colors.red,
            ),
          ),
          leading: Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 30.0,
          ),
          trailing: new Text(
            trans.title.compareTo("METRO RECHARGE") == 0 || trans.amount < 0
                ? " - ₹ " + trans.amount.toString().replaceFirst("-", "")
                : " + ₹ " + trans.amount.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Montserrat",
              fontSize: 18.0,
              color: trans.title.compareTo("METRO RECHARGE") == 0 ||
                  trans.amount < 0
                  ? Colors.blueGrey
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
        data[i]["id"],
        data[i]["title"],
        [data[i]["detail"]],
        double.parse(data[i]["amount"].toString()),
        data[i]["timeStamp"].toString(),
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
                  fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
            ),
            content: TextField(
              controller: _ctotal,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter total amount",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Raleway",
                      letterSpacing: 2.0,
                      wordSpacing: 2.0)),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'SUBMIT',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontFamily: "Raleway"),
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
                      fontWeight: FontWeight.w600, fontFamily: "Raleway"),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  String dateformat(String timeStamp) {
    final DateTime now = DateTime.parse(timeStamp);
    final DateFormat formatter1 = DateFormat('E, d MMMM yyyy');
    final DateFormat formatter2 = DateFormat('jms');
    final String formatted =
        formatter1.format(now) + " " + formatter2.format(now);
    return formatted;
  }

  textColor(transaction tr) {
    if (tr.title == "METRO RECHARGE") {
      return Colors.blueGrey;
    } else if (tr.amount < 0) {
      return Colors.lightBlue;
    } else {
      return Colors.red;
    }
  }

  _addNewTransaction(context) async {
    return showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Container(
              height: 100.0 * a1.value,  // USE PROVIDED ANIMATION
              width: 100.0 * a1.value,
              child: AlertDialog(
                title: Text(
                  'New Transcation',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
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
                                fontFamily: "Raleway",
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
                                fontFamily: "Raleway",
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
                                fontFamily: "Raleway",
                                letterSpacing: 2.0)),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new FlatButton(
                        child: new Text(
                          'ADD METRO RECHARGE',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                              color: Colors.green),
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
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                              color: Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            insertTotable(
                                "naveen", _ctitle.text, _cdetails.text,
                                double.parse(_camount.text));
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      new FlatButton(
                        child: new Text(
                          'CANCEL',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat"),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

class transaction {
  final int id;
  final String title;
  final double amount;
  List<String> contents = [];
  final String timeStamp;

  transaction(this.id, this.title, this.contents, this.amount, this.timeStamp);
}

List<transaction> trs = [];
