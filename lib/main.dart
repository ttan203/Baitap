import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator and Prime Checker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final TextEditingController _primeController = TextEditingController();
  String _result = '';
  String _errorMessage = '';

  void _calculate(String operation) {
    setState(() {
      _errorMessage = '';
      double? a = double.tryParse(_controllerA.text);
      double? b = double.tryParse(_controllerB.text);

      if (a == null || b == null) {
        _errorMessage = 'Vui lòng nhập số hợp lệ!';
        _result = '';
        return;
      }

      switch (operation) {
        case '+':
          _result = 'Kết quả: ${a + b}';
          break;
        case '-':
          _result = 'Kết quả: ${a - b}';
          break;
        case '*':
          _result = 'Kết quả: ${a * b}';
          break;
        case '/':
          if (b != 0) {
            _result = 'Kết quả: ${a / b}';
          } else {
            _errorMessage = 'Không thể chia cho 0!';
            _result = '';
          }
          break;
      }
    });
  }

  void _checkPrime() {
    final String input = _primeController.text;
    final int? number = int.tryParse(input);

    if (number == null) {
      _showSnackbar('Vui lòng nhập số nguyên hợp lệ!');
      return;
    }

    if (number < 2) {
      _showSnackbar('$number không phải là số nguyên tố.');
      return;
    }

    bool isPrime = true;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        isPrime = false;
        break;
      }
    }

    if (isPrime) {
      _showSnackbar('$number là số nguyên tố.');
    } else {
      _showSnackbar('$number không phải là số nguyên tố.');
    }
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculator and Prime Checker App'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    children: [
    // Phần tính toán
    TextField(
    controller: _controllerA,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText: 'Nhập số A'),
    ),
    TextField(
      controller: _controllerB,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Nhập số B'),
    ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => _calculate('+'),
            child: Text('+'),
          ),
          ElevatedButton(
            onPressed: () => _calculate('-'),
            child: Text('-'),
          ),
          ElevatedButton(
            onPressed: () => _calculate('*'),
            child: Text('*'),
          ),
          ElevatedButton(
            onPressed: () => _calculate('/'),
            child: Text('/'),
          ),
        ],
      ),
      SizedBox(height: 20),
      if (_errorMessage.isNotEmpty)
        Text(_errorMessage, style: TextStyle(color: Colors.red)),
      if (_result.isNotEmpty)
        Text(_result, style: TextStyle(fontSize: 20)),

      // Phần kiểm tra số nguyên tố
      Divider(height: 40),
      TextField(
        controller: _primeController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Nhập số để kiểm tra nguyên tố'),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: _checkPrime,
        child: Text('Kiểm tra nguyên tố'),
      ),
    ],
    ),
        ),
    );
  }
}