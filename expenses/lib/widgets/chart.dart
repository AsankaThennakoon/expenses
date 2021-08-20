import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get generateAccordingToWeeks {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totaleAmount = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totaleAmount += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totaleAmount
      };
    });
  }

  double get totalSpending {
    return generateAccordingToWeeks.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(generateAccordingToWeeks);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (var index = 0;
                  index < generateAccordingToWeeks.length;
                  index++)
                Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    generateAccordingToWeeks[index]['day'] as String,
                    generateAccordingToWeeks[index]['amount'] as double,
                    totalSpending == 0
                        ? 0.0
                        : (generateAccordingToWeeks[index]['amount']
                                as double) /
                            totalSpending,
                  ),
                )
            ]),
      ),
    );
  }
}
