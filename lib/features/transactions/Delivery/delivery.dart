import 'package:flutter/material.dart';
import 'package:pool/features/model/variable.dart';
import '../Delivery/new_delivery.dart';
import '../Delivery/delivery_list.dart';
//import 'package:chewie/chewie.dart';
//import 'package:video_player/video_player.dart';


class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
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
        actions: <Widget>[
          /*IconButton(
            icon: const Icon(, color: Colors.black),
            onPressed: () {},
          ),*/
        ],
        title: const Text('Delivery Page'),
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




