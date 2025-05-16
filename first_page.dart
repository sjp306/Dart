import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  final String title;

  const FirstPage({super.key, required this.title});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Hello, ${widget.title}!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
