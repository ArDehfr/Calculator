import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'currency_converter.dart';
import 'history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator Neumorphism',
      home: CalculatorNeuApp(),
    );
  }
}

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

class CalculatorNeuApp extends StatefulWidget {
  @override
  _CalculatorNeuAppState createState() => _CalculatorNeuAppState();
}

class _CalculatorNeuAppState extends State<CalculatorNeuApp> {
  bool darkMode = false;
  String expression = '';
  String result = '';
  List<String> dropdownItems = ['Weight', 'Height', 'Money'];
  String selectedDropdownItem = 'Weight'; // Initial selected item
  List<String> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          darkMode = !darkMode;
                        });
                      },
                      child: _switchMode(),
                    ),
                    SizedBox(height: 80),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        result.isEmpty ? '0' : result,
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: darkMode
                                ? Color.fromRGBO(255, 147, 48, 1)
                                : Color.fromRGBO(255, 147, 48, 1)),
                      ),
                    ),
                    SizedBox(height: 1),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        expression.isEmpty ? '0' : expression,
                        style: TextStyle(
                          fontSize: 20,
                          color: darkMode
                              ? Color.fromRGBO(0, 192, 31, 1)
                              : Color.fromRGBO(90, 90, 90, 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 1),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonRounded(
                            title: 'C',
                            textColor: darkMode
                                ? Color.fromRGBO(0, 192, 31, 1)
                                : Color.fromRGBO(190, 1, 1, 1),
                            onPressed: _clear),
                        _buttonRounded(title: '(', onPressed: () => _appendToExpression('(')),
                        _buttonRounded(title: ')', onPressed: () => _appendToExpression(')')),
                        _buttonRounded(
                            title: '/',
                            textColor: darkMode
                                ? Color.fromRGBO(0, 192, 31, 1)
                                : Color.fromRGBO(190, 1, 1, 1),
                            onPressed: () => _appendToExpression('/')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonRounded(title: '7', onPressed: () => _appendToExpression('7')),
                        _buttonRounded(title: '8', onPressed: () => _appendToExpression('8')),
                        _buttonRounded(title: '9', onPressed: () => _appendToExpression('9')),
                        _buttonRounded(
                            title: '*',
                            textColor: darkMode
                                ? Color.fromRGBO(0, 192, 31, 1)
                                : Color.fromRGBO(190, 1, 1, 1),
                            onPressed: () => _appendToExpression('*')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonRounded(title: '4', onPressed: () => _appendToExpression('4')),
                        _buttonRounded(title: '5', onPressed: () => _appendToExpression('5')),
                        _buttonRounded(title: '6', onPressed: () => _appendToExpression('6')),
                        _buttonRounded(
                            title: '-',
                            textColor: darkMode
                                ? Color.fromRGBO(0, 192, 31, 1)
                                : Color.fromRGBO(190, 1, 1, 1),
                            onPressed: () => _appendToExpression('-')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonRounded(title: '1', onPressed: () => _appendToExpression('1')),
                        _buttonRounded(title: '2', onPressed: () => _appendToExpression('2')),
                        _buttonRounded(title: '3', onPressed: () => _appendToExpression('3')),
                        _buttonRounded(
                            title: '+',
                            textColor: darkMode
                                ? Color.fromRGBO(0, 192, 31, 1)
                                : Color.fromRGBO(190, 1, 1, 1),
                            onPressed: () => _appendToExpression('+')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonRounded(title: ',', onPressed: () => _appendToExpression(',')),
                        _buttonRounded(title: '0', onPressed: () => _appendToExpression('0')),
                        _buttonRounded(
                          icon: Icons.backspace_outlined,
                          iconColor: darkMode ? Colors.green : Colors.redAccent,
                          onPressed: _deleteLastCharacter,
                        ),
                        _buttonRounded(
                          title: '=',
                          textColor: darkMode
                              ? Color.fromRGBO(0, 192, 31, 1)
                              : Color.fromRGBO(190, 1, 1, 1),
                          onPressed: _calculateResult,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _dropDown(), // Added dropdown menu
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryPage(history: history),
            ),
          );
        },
        child: Icon(Icons.history),
      ),
    );
  }

  Widget _buttonRounded({
    String? title,
    double padding = 17,
    IconData? icon,
    Color? iconColor,
    Color? textColor,
    Function()? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NeuContainer(
        darkMode: darkMode ?? false,
        borderRadius: BorderRadius.circular(40),
        padding: EdgeInsets.all(padding),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: padding * 2,
            height: padding * 2,
            child: Center(
              child: title != null
                  ? Text(
                      '$title',
                      style: TextStyle(
                        color: textColor ?? ((darkMode ?? false) ? Colors.white : Colors.black),
                        fontSize: 30,
                      ),
                    )
                  : Icon(
                      icon ?? Icons.error,
                      color: iconColor ?? Colors.black,
                      size: 30,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DropdownButton<String>(
      value: selectedDropdownItem,
      onChanged: (String? newValue) {
        setState(() {
          selectedDropdownItem = newValue!;
          if (selectedDropdownItem == 'Money') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrencyConverter()), 
            );
          }
        });
      },
      items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.wb_sunny,
              color: darkMode ? Colors.grey : Color.fromRGBO(255, 199, 0, 1),
            ),
            Icon(
              Icons.nightlight_round,
              color: darkMode ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _appendToExpression(String value) {
    setState(() {
      expression += value;
    });
  }

  void _clear() {
    setState(() {
      expression = '';
      result = '';
    });
  }

  void _deleteLastCharacter() {
    setState(() {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    });
  }

  void _calculateResult() {
    setState(() {
      try {
        // Use math expressions library
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = exp.evaluate(EvaluationType.REAL, cm).toString();
        history.add('$expression = $result');
      } catch (e) {
        // Handle errors such as division by zero
        result = 'Error';
        history.add('Invalid input: $expression');
      }
    });
  }
}

class NeuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;

  NeuContainer({
    this.darkMode = false,
    required this.child,
    required this.borderRadius,
    this.padding,
  });

  @override
  _NeuContainerState createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: darkMode ? colorDark : colorLight,
          borderRadius: widget.borderRadius,
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    color: darkMode ? Colors.black54 : Colors.blueGrey.shade200,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: darkMode ? Colors.blueGrey.shade700 : Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  )
                ],
        ),
        child: widget.child,
      ),
    );
  }
}
