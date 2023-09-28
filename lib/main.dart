import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Downes Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;
  List<Customer> customers = [
    Customer('Mark', "Davis", 001, "Saver"),
    Customer('Bradley', "Gilbert", 002, "Spender"),
    Customer('Trina', "Mattis", 003, "Saver"),
    Customer('Larry', "Dinkle", 004, "Occasional"),
    Customer('Samantha', "Scooters", 005, "Frequent"),
    Customer('Barry', "Smith", 006, "Spender"),
    Customer('Scooter', "Bradenson", 007, "Frequent"),
    Customer('Sarah', "Morris", 008, "Saver"),
    Customer('Glen', "Daniels", 009, "Occasional"),
    Customer('Lindsey', "Paths", 010, "Spender"),
  ];

  void _handleReset() {
    setState(() {
      pageFirstLoad = true;
    });
  }

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: pageFirstLoad
              ? ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Text("Load items"),
                )
              : isLoadingItemsFromDatabase
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text("Please wait")
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: customers.map((customer) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("First Name: ${customer.FirstName}",
                                    style: TextStyle(fontSize: 20)),
                                Text(
                                    "Last Name: ${customer.LastName.toString()}"),
                                Text(
                                    "Customer ID: ${customer.CustomerID.toString()}"),
                                Text("Type: ${customer.Type}"),
                                Divider(),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleReset,
          child: const Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
        ));
  }
}

class Customer {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Customer(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
