import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(calculator());
}

class calculator extends StatefulWidget {
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String clear = '';
  String equation = '0';
  String currentresult = '0';
  String buttonpress(String sign) {
    setState(() {
      if (sign == '=') {
        currentresult = equation;
        try {
          Parser p = Parser();
          Expression exp = p.parse(currentresult);
          ContextModel cm = ContextModel();
          currentresult = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          currentresult = 'Error';
        }
      } else if (sign == 'AC') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else {
        if (equation == '0') {
          equation = sign;
        } else {
          equation = equation + sign;
        }
      }
    });
  }

  Container buttonpad({String sign, Color buttoncolor}) {
    return Container(
      child: Expanded(
        child: FlatButton(
          color: buttoncolor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$sign',
                style: TextStyle(fontSize: 50),
              )
            ],
          ),
          onPressed: () {
            buttonpress(sign);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Calculator'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Text(
                      '$equation',
                      style: TextStyle(fontSize: 35),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                    child: Text(
                      '$currentresult',
                      style: TextStyle(fontSize: 45),
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            buttonpad(
                                sign: '√', buttoncolor: Colors.orangeAccent),
                            buttonpad(
                                sign: '±', buttoncolor: Colors.orangeAccent),
                            buttonpad(
                                sign: '%', buttoncolor: Colors.orangeAccent),
                            buttonpad(
                                sign: 'AC', buttoncolor: Colors.orangeAccent),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            buttonpad(sign: '7'),
                            buttonpad(sign: '8'),
                            buttonpad(sign: '9'),
                            buttonpad(
                                sign: '/', buttoncolor: Colors.orangeAccent),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            buttonpad(sign: '4'),
                            buttonpad(sign: '5'),
                            buttonpad(sign: '6'),
                            buttonpad(
                                sign: '*', buttoncolor: Colors.orangeAccent),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            buttonpad(sign: '1'),
                            buttonpad(sign: '2'),
                            buttonpad(sign: '3'),
                            buttonpad(
                                sign: '-', buttoncolor: Colors.orangeAccent),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            buttonpad(sign: '.'),
                            buttonpad(sign: '0'),
                            buttonpad(sign: '='),
                            buttonpad(
                                sign: '+', buttoncolor: Colors.orangeAccent),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
