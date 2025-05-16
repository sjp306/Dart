import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Search',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MaterialMain(title: '카카오 책 검색'),
    );
  }
}

class MaterialMain extends StatefulWidget {
  final String title;

  const MaterialMain({super.key, required this.title});

  @override
  State<MaterialMain> createState() => _MaterialMainState();
}

class _MaterialMainState extends State<MaterialMain> {
  static const String API_SERVER = "https://dapi.kakao.com/v3/search/book";
  static const String REST_API_KEY = "f8c034b8b2636bbcf85091d5737b7114"; // ← 본인 키로 교체
  List<dynamic> bookList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _getBookList(),
                    decoration: const InputDecoration(
                      hintText: '검색어를 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _getBookList,
                  child: const Text('검색'),
                ),
              ],
            ),
          ),
          Expanded(
            child: bookList.isEmpty
                ? const Center(child: Text("검색어를 입력하고 검색 버튼을 누르세요."))
                : Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bookList.length,
                itemBuilder: (context, index) {
                  final book = bookList[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: book['thumbnail'] != null && book['thumbnail'] != ""
                          ? Image.network(
                        book['thumbnail'],
                        width: 50,
                        cacheWidth: 100,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                      )
                          : const Icon(Icons.book, size: 50),
                      title: Text(
                        book['title'] ?? '제목 없음',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text("저자: ${book['authors']?.join(', ') ?? '정보 없음'}"),
                          Text("출판사: ${book['publisher'] ?? '정보 없음'}"),
                          Text("정가: ${book['price']}원"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getBookList() async {
    final searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      _showError("검색어를 입력하세요.");
      return;
    }

    final query = Uri.encodeQueryComponent(searchText);
    final url = "$API_SERVER?query=$query&target=title";

    final headers = {
      "Authorization": "KakaoAK $REST_API_KEY",
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final documents = jsonMap['documents'];

        setState(() {
          bookList = documents;
        });
      } else {
        _showError("요청 실패 (상태 코드: ${response.statusCode})");
      }
    } catch (e) {
      _showError("에러 발생: $e");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("오류"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("확인"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}