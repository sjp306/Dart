import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController operand1Controller = TextEditingController();
  final TextEditingController operand2Controller = TextEditingController();

  double result = 0;
  String selectedOperator = '더하기'; // ✅ 드롭다운 선택 값

  final List<String> operators = ['더하기', '빼기', '곱하기', '나누기']; // ✅ 드롭다운 리스트

  void calculate() {
    double num1 = double.tryParse(operand1Controller.text) ?? 0;
    double num2 = double.tryParse(operand2Controller.text) ?? 0;
    double tempResult;

    switch (selectedOperator) {
      case '더하기':
        tempResult = num1 + num2;
        break;
      case '빼기':
        tempResult = num1 - num2;
        break;
      case '곱하기':
        tempResult = num1 * num2;
        break;
      case '나누기':
        if (num2 != 0) {
          tempResult = num1 / num2;
        } else {
          setState(() {
            result = double.nan; // 또는 NaN 메시지 출력
          });
          return;
        }
        break;
      default:
        tempResult = 0;
    }

    setState(() {
      result = tempResult;
    });
  }

  @override
  void dispose() {
    operand1Controller.dispose();
    operand2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                '결과: ${result.isNaN ? "0으로 나눌 수 없습니다" : result.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: operand1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '피연산자1',
                hintText: '정수 또는 실수',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: operand2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '피연산자2',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedOperator,
              isExpanded: true,
              items: operators.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOperator = newValue!;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: calculate,
              child: Text('계산하기'),
            ),
          ],
        ),
      ),
    );
  }
}
