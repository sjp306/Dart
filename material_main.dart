import 'package:flutter/material.dart';

class MaterialMain extends StatefulWidget {
  final String title;

  const MaterialMain({super.key, required this.title});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  String strResult = "0";
  final TextEditingController _tecStrNum1 = TextEditingController();
  final TextEditingController _tecStrNum2 = TextEditingController();

  final List<String> _stnDropdownButtonList = ["더하기", "빼기", "곱하기", "나누기"];
  late String _strDropdownButtonValue;

  @override
  void initState() {
    super.initState();
    _strDropdownButtonValue = _stnDropdownButtonList.first;
  }

  void _calculate() {
    double num1 = double.tryParse(_tecStrNum1.text) ?? 0;
    double num2 = double.tryParse(_tecStrNum2.text) ?? 0;
    double result;

    switch (_strDropdownButtonValue) {
      case "더하기":
        result = num1 + num2;
        break;
      case "빼기":
        result = num1 - num2;
        break;
      case "곱하기":
        result = num1 * num2;
        break;
      case "나누기":
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          setState(() {
            strResult = "0으로 나눌 수 없습니다";
          });
          return;
        }
        break;
      default:
        result = 0;
    }

    setState(() {
      strResult = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "결과: $strResult",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _tecStrNum1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '피연산자1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _tecStrNum2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '피연산자2',
                hintText: "정수 또는 실수",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _strDropdownButtonValue,
              isExpanded: true,
              items: _stnDropdownButtonList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _strDropdownButtonValue = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('계산하기'),
            ),
          ],
        ),
      ),
    );
  }
}