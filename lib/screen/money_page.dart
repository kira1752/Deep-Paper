import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  @override
  _MoneyPageState createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Money Note", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}