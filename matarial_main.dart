// Flutter 머티리얼 디자인 패키지 가져오기
import 'package:flutter/material.dart';

// 사용자 정의 모델 파일 import (경로와 파일명 정확히 확인 필요)
import 'model/animal.dart';
import 'model/animal_list.dart';
import 'model/animal_create.dart';

// 앱 전체에서 사용할 동물 리스트
List<Animal> animalList = [];

void main() {
  runApp(const MyApp()); // 앱 시작
}

// StatelessWidget으로 앱의 루트 정의
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tab example',
      home: const MaterialMain(title: '탭 예제'), // 메인 위젯 지정
    );
  }
}

// 탭 기능이 있는 StatefulWidget 정의
class MaterialMain extends StatefulWidget {
  final String title;
  const MaterialMain({super.key, required this.title});

  @override
  State<MaterialMain> createState() => _MaterialMainState();
}

// 실제 상태 관리 클래스
class _MaterialMainState extends State<MaterialMain>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // 탭 컨트롤러 선언
  List<Animal> animalList = []; // 동물 리스트

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 탭 2개
  }

  @override
  void dispose() {
    _tabController.dispose(); // 탭 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // 앱바 제목
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'List', icon: Icon(Icons.list)),    // 첫 번째 탭: 리스트
            Tab(text: 'Create', icon: Icon(Icons.add)),   // 두 번째 탭: 추가
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AnimalList(title: 'Animal List', animalList: animalList),   // 동물 목록
          AnimalCreate(title: 'Animal Create', animalList: animalList), // 동물 생성
        ],
      ),
    );
  }
}