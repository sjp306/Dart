import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class MaterialMain extends StatefulWidget {
  final String title;
  const MaterialMain({super.key, required this.title});

  @override
  State<MaterialMain> createState() => _MaterialMainState();
}

class _MaterialMainState extends State<MaterialMain> {
  static const String FILE_URL = "https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg";
  String filename = "pexels-photo-240040.jpeg";
  bool _downloading = false;
  String? _downloadedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _downloading
            ? const CircularProgressIndicator()
            : _downloadedFilePath != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("다운로드 완료!"),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.open_in_new),
              label: const Text("파일 열기"),
              onPressed: () => OpenFile.open(_downloadedFilePath),
            ),
          ],
        )
            : const Text("FloatingActionButton으로 파일 다운로드"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.file_download),
        onPressed: () => _downloadFile(filename),
      ),
    );
  }

  Future<void> _downloadFile(String filename) async {
    try {
      setState(() {
        _downloading = true;
        _downloadedFilePath = null;
      });

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePathSaved = "${appDocDir.path}/$filename";

      await Dio().download(
        FILE_URL,
        filePathSaved,
        onReceiveProgress: (count, total) {
          print("다운로드 중: $count / $total bytes");
        },
      );

      setState(() {
        _downloadedFilePath = filePathSaved;
        _downloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("다운로드 완료: $filePathSaved")),
      );
    } catch (e) {
      setState(() => _downloading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("다운로드 실패: $e")),
      );
    }
  }
}
