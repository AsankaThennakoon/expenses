import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTX;

  TransactionList(this.transactions, this.deleteTX);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Container(
              child: ListView(
                children: [
                  Text(
                    "Still have no picture add!.",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: FittedBox(
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: () =>
                              deleteTX(transactions[index].transcationId),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          label: Text(
                            'delete',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ))
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () =>
                              deleteTX(transactions[index].transcationId),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}



// Column(
//                   children: [
//                     Card(
//                       child: Row(
//                         children: <Widget>[
//                           Container(
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.all(10),
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Theme.of(context).primaryColorDark,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Text(
//                               '\$ ${transactions[index].amount.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Quicksand',
//                                 fontSize: 20,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.all(4),
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: 15,
//                                 ),
//                                 child: Text(
//                                   transactions[index].title,
//                                   style: Theme.of(context).textTheme.headline6,
//                                 ),
//                               ),
//                               Text(
//                                 DateFormat.yMMMd()
//                                     .format(transactions[index].date),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black26,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
                
