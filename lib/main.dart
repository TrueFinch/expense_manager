import 'package:flutter/material.dart';
import 'models/ExpenseDB.dart';
import 'pages/HomePage.dart';

void main() {
  // ExpenseDB(); // init expenseDB before start application
  runApp(ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Awesome expense manager!'),
    );
  }
}
