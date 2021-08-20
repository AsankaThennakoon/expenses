import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  bool _showChart = false;
  void _addTransaction(String title, double amount, DateTime selectedDate) {
    final _sampleTransaction = Transaction(
      amount: amount,
      date: selectedDate,
      title: title,
      transcationId: DateTime.now().toString(),
    );

    setState(() {
      print(_sampleTransaction.title + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      transactions.add(_sampleTransaction);
    });
  }

  void showAddNewTransactionBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransation(_addTransaction),
        );
      },
    );
  }

  List<Transaction> get _recentTransaction {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteTransctin(String id) {
    setState(() {
      transactions.removeWhere((element) {
        return element.transcationId == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'My Expenses',
        style: Theme.of(context).appBarTheme.textTheme!.headline6,
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => showAddNewTransactionBottomSheet(context),
            icon: Icon(Icons.add))
      ],
    );

    final txListWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              0.7,
          child: TransactionList(transactions, deleteTransctin),
        ),
      ],
    );
    print(transactions.length);
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Column(
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                      value: _showChart,
                      onChanged: (bool) {
                        setState(() {
                          _showChart = bool;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Card(
                  color: Theme.of(context).primaryColorLight,
                  elevation: 5,
                  child: Chart(_recentTransaction),
                ),
              ),
            if (!isLandScape) txListWidget,
            if (isLandScape)
              _showChart
                  ? Container(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Card(
                        color: Theme.of(context).primaryColorLight,
                        elevation: 5,
                        child: Chart(_recentTransaction),
                      ),
                    )
                  : txListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddNewTransactionBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
