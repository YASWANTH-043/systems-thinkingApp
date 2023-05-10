import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pool/features/model/variable.dart';

class VariableList extends StatelessWidget {
  final List<Variable> variables;
  
   VariableList(this.variables);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: variables.isEmpty
          ? Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                const Text(
                  'Ready to start your Journey!',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                      //color: Colors.cyan,
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/plane3.png',
                        //fit: BoxFit.contain,
                      )),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Container(color: Colors.orange,
                            child: Column( 
                              children: [ const Text('Per kg:',style: TextStyle(color: Colors.white),),
                                Text(
                                  'Rs. ${variables[index].prize}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      variables[index].board,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(variables[index].date),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [ const Text('Available Space(in kgs):'),
                            Text(
                              variables[index].weight.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: variables.length,
              scrollDirection: Axis.vertical,
            ),
    );
  }
}
