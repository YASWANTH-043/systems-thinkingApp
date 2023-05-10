import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewVariable extends StatefulWidget {
  final Function addTx;
  NewVariable(this.addTx);

  @override
  _NewVariableState createState() => _NewVariableState();
}

class _NewVariableState extends State<NewVariable> {
  final _boardController = TextEditingController();
  final _destController = TextEditingController();
  final _weightController = TextEditingController();
  final _prizeController = TextEditingController();
 DateTime? _selectedDate;

  void _submitData() {
    if (_prizeController.text.isEmpty) {
      return;
    }
    final _boardentered = _boardController.text;
    final _destentered = _destController.text;
    final _weightentered = double.parse(_weightController.text);
    final _prizeentered = double.parse(_prizeController.text);
    

    if (_boardentered.isEmpty || _destentered.isEmpty || _weightentered <=0 || _prizeentered <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      _boardentered,
      _destentered,
      _weightentered,
      _prizeentered,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10), 
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              cursorColor: Theme.of(context).primaryColorDark,
              decoration: const InputDecoration(labelText: 'Boarding at:',
                  labelStyle: TextStyle(color: Colors.black),),
              controller: _boardController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              cursorColor: Theme.of(context).primaryColorDark,
              decoration: const InputDecoration(labelText: 'Destination:',
                  labelStyle: TextStyle(color: Colors.black),),
              controller: _destController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              cursorColor: Theme.of(context).primaryColorDark,
              decoration: const InputDecoration(labelText: 'Weight(in kgs):',
                  labelStyle: TextStyle(color: Colors.black),),
              controller: _weightController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              cursorColor: Theme.of(context).primaryColorDark,
              decoration: const InputDecoration(labelText: 'Price(per kg)',
                labelStyle: TextStyle(color: Colors.black),),
              controller: _prizeController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            SizedBox(
              height: 70,
              //width:3,
              child: Row(
                children: <Widget>[
                    Text(
                      _selectedDate == null ? 'No Date chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                  ElevatedButton (
                    onPressed: _presentDatePicker,
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child:const Text(
                      'Choose One!',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.orange)),
              onPressed: _submitData,
              child: const Text(
                'Add Trip',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
