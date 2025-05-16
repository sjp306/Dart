import 'package:flutter/material.dart';
import 'animal.dart'; // Animal 클래스 정의된 파일

class AnimalList extends StatelessWidget {
  final String title; // 앱바 제목
  final List<Animal> animalList; // 동물 객체 리스트

  const AnimalList({
    super.key,
    required this.title,
    required this.animalList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: animalList.length,
        itemBuilder: (context, index) {
          final animal = animalList[index]; // 현재 동물 객체

          return ListTile(
            leading: Image.asset(
              animal.imagePath, // 예: 'assets/cat.png'
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            title: Text(animal.name), // 동물 이름 표시
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("동물 정보"),
                  content: Text("${animal.name}는 ${animal.species}입니다."),
                  actions: [
                    TextButton(
                      child: Text("닫기"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}