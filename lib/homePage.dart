import 'package:flutter/material.dart';
import 'package:pool/features/transactions/Courier/courier.dart';
import 'package:pool/features/transactions/Delivery/delivery.dart';
import 'package:pool/features/transactions/Trip/trip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: const Text('Home Page'),
        backgroundColor: Colors.orange.shade600,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/cor1.png.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Courier(),
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Send a Courier", style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(
              height: 50,
              width: 50,
            ),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/plane.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Trip(),
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Organize a Trip',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 50,
              width: 50,
            ),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: OutlinedButton(
                    child: Image.asset(
                      'assets/images/del1.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Delivery(),
                        ));
                    },
                  ),
                ),
                SizedBox(height: 20,),
                 const Text(
                  'I want to Deliver',
                  style: TextStyle(fontSize: 20),
                )
              ],
            )
          ],
        ),
      ),
      //backgroundColor: Colors.blueGrey.shade700,
    );
  }
}
