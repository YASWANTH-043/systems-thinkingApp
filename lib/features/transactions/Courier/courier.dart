import 'package:flutter/material.dart';
import 'package:pool/features/model/variable.dart';
import 'new_courier.dart';
import 'courier_list.dart';

class Courier extends StatefulWidget {

  @override
  State<Courier> createState() => _CourierState();
}

class _CourierState extends State<Courier> {
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
        actions: const <Widget> [],
        title: const Text('Courier Page'),
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
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.orange,
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: () => _startNewVariable(context),
      ),
    );
  }
}




