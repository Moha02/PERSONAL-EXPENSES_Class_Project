import 'package:project/services/transaction.dart';
import 'package:project/services/transaction_list.dart';
import 'package:project/services/new_transaction.dart';
import 'package:project/services/chart.dart';
import 'package:project/screens/balance.dart';
import 'package:project/screens/about.dart';
import '../db/db.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({this.locationWeather});
  final locationWeather;

  // String titleInput;
  // String amountInput;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int temperature;

  @override
  void initState() {
    super.initState();
    updateWT(widget.locationWeather);
  }

  void updateWT(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;

        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
    });
  }

  List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
    String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
      
      
      
    });
  }



  void _startAddNewTran(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTrans(String id) {
    setState(() {
      _userTransaction.removeWhere((ctx) => ctx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Flutter'),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.access_time),
        //   onPressed: () => _startAddNewTran(context)

        Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '$temperature °',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ]),
      ],
    );
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text("Drawer Header"),
          ),
          ListTile(
              leading: Icon(Icons.account_balance),
              title: Text("Balance"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Balance()));
              }),
          ListTile(
              leading: Icon(Icons.album),
              title: Text("About"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => About()));
              }),
          ListTile(
            leading: Icon(Icons.assessment),
            title: Text("Close Drawer"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: TransactionList(
                  _userTransaction,
                  _deleteTrans,
                )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _startAddNewTran(context)),
    );
  }
}

