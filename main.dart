import 'package:flutter/material.dart';
import 'model/animal.dart';
import 'model/animal_create.dart'; // 또는 animal_list.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '동물 추가',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimalCreate(
        title: '동물 추가',
        animalList: [],
      ),
    );
  }
}