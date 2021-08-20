import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  final Function addTransaction;

  NewTransation(this.addTransaction);

  @override
  _NewTransationState createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? dateSelecte;

  void submitedData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || dateSelecte == null) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      dateSelecte,
    );

    Navigator.of(context).pop();
  }

  void _showDatePickeDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        dateSelecte = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) => submitedData,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitedData,
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      dateSelecte == null
                          ? "No Date Chosesn    ?"
                          : ' Date:${DateFormat.yMMMd().format(dateSelecte as DateTime)}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextButton(
                        onPressed: _showDatePickeDialog,
                        child: Text(
                          'Choose date',
                          style: Theme.of(context).textTheme.headline6,
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitedData,
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
