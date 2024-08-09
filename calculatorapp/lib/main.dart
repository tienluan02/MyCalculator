import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iPhone Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _input = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;
  bool _commaPressed = false;

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
        _commaPressed = false;
      } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
        _operator = value;
        _num1 = double.parse(_input);
        _input = "";
        _commaPressed = false; // Reset comma flag for new number
      } else if (value == "=") {
        _num2 = double.parse(_input);
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "×") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "÷") {
          _output = (_num1 / _num2).toString();
        }
        _input = _output;
        _operator = "";
        _commaPressed = _output.contains(".");
      } else if (value == "%") {
        _input = (double.parse(_input) / 100).toString();
        _output = _input;
        _commaPressed = _output.contains(".");
      } else if (value == "+/-") {
        if (_input.isEmpty) {
          _input = '-0';
        } else if (_input == '-0') {
          _input = '0';
        } else if (_input.startsWith("-")) {
          _input = _input.substring(1);
        } else {
          _input = "-$_input";
        }
        _output = _input;
      } else if (value == ',') {
        if (!_commaPressed) {
          if (_input.isEmpty) {
            _input = '0.';
          } else if (_input == '-0') {
            _input = '-0.';
          } else {
            _input += '.';
          }
        }
        _output = _input;
        _commaPressed = true;
      } else {
        if (_input == '0') {
          _input = value;
        } else if (_input == '-0') {
          _input = "-$value";
        } else {
          _input += value;
        }
        _output = _input;
      }

      _output = _output.replaceAll('.', ',');
    });
  }

  Widget _buildButton(String value,
      {Color? color, Color? textColor, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            foregroundColor: textColor ?? Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(20.0),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton("C", color: Colors.grey),
                  _buildButton("+/-", color: Colors.grey),
                  _buildButton("%", color: Colors.grey),
                  _buildButton("÷", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("×", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("0", color: Colors.grey[850], flex: 2),
                  _buildButton(","),
                  _buildButton("=", color: Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
