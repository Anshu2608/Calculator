
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "";
  String _currentNumber = "";
  double _num1 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      setState(() {
        _output = "";
        _currentNumber = "";
        _num1 = 0;
        _operand = "";
      });
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      if (_currentNumber.isNotEmpty) {
        _num1 = double.parse(_currentNumber);
        setState(() {
          _output = _currentNumber + " " + buttonText;
          _currentNumber = "";
          _operand = buttonText;
        });
      } else if (_output.isNotEmpty && _output[_output.length - 1] != " ") {
        setState(() {
          _operand = buttonText;
          _output += " " + buttonText;
        });
      }
    } else if (buttonText == ".") {
      if (!_currentNumber.contains(".")) {
        setState(() {
          _currentNumber += ".";
          _output += ".";
        });
      }
    } else if (buttonText == "=") {
      if (_currentNumber.isNotEmpty) {
        double result = 0;
        double num2 = double.parse(_currentNumber);
        switch (_operand) {
          case "+":
            result = _num1 + num2;
            break;
          case "-":
            result = _num1 - num2;
            break;
          case "*":
            result = _num1 * num2;
            break;
          case "/":
            if (num2 != 0) {
              result = _num1 / num2;
            } else {
              result = double.infinity;
            }
            break;
        }
        setState(() {
          _output = result.toString();
          if (_output.endsWith(".0")) {
            _output = _output.replaceAll(".0", "");
          }
          _currentNumber = "";
          _num1 = 0;
          _operand = "";
        });
      }
    } else {
      setState(() {
        _currentNumber += buttonText;
        _output += buttonText;
      });
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
          textStyle: const TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output.isEmpty ? "0" : _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("0"),
              _buildButton("."),
              _buildButton("C"),
              _buildButton("+"),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("="),
            ],
          ),
        ],
      ),
    );
  }
}
