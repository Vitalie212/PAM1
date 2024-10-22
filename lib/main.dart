import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(LoanCalculatorApp());
}

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoanCalculator(),
    );
  }
}

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  double _months = 1;
  double _monthlyPayment = 0;

  void _calculatePayment() {
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final double interest = double.tryParse(_interestController.text) ?? 0;
    final double monthlyInterest = (interest / 100) / 12;
    
    if (amount > 0 && interest > 0 && _months > 0) {
      _monthlyPayment = amount * monthlyInterest / (1 - pow(1 + monthlyInterest, -_months));
    } else {
      _monthlyPayment = 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter amount',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter number of months',
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              value: _months,
              min: 1,
              max: 60,
              divisions: 59,
              label: '${_months.toInt()} luni',
              onChanged: (double value) {
                setState(() {
                  _months = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Enter % per month',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Percent',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'You will pay the approximate amount monthly:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${_monthlyPayment.toStringAsFixed(2)}€',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _calculatePayment,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), 
                backgroundColor: Colors.blue, 
              ),
              child: Text(
                'Calculate',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
