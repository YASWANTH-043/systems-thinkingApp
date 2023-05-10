import 'package:flutter/material.dart';
import 'package:pool/features/model/variable.dart';
import 'newvariable.dart';
import 'variable_list.dart';

class Trip extends StatefulWidget {
  const Trip({super.key});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  final List<Variable> _userVariables = [];
  void _addNewVariable(
    String vrboard,
    String vrdest,
    double vrweight,
    double vrprize,
    DateTime chosenDate,
  ) {
    final newTx = Variable(
      board: vrboard,
      dest: vrdest,
      weight: vrweight,
      prize: vrprize,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

     setState(() {
      _userVariables.add(newTx);
    });
  }
  void _startNewVariable(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewVariable(_addNewVariable),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
          /*IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: ()=> _startNewVariable(context),
          ),
        ],*/
        title: const Text('Trip Page'),
        backgroundColor: Colors.orange.shade600,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[VariableList(_userVariables),],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton( backgroundColor: Colors.orange,
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: () => _startNewVariable(context),
      ),
    );
  }
}



  
 
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () => _startNewTransaction(context),
                icon: Icon(Icons.add)),
          ],
          title: Text(
            'Canteen Expenses App',
            style: TextStyle(fontFamily: 'Quicksand'),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            Expanded(
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}*/
