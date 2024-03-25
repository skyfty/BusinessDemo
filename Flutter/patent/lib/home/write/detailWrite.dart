import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DetailWrite extends StatefulWidget {
  final String token;
  final String peopleType;
  final String business_name;
  DetailWrite(
      {required this.token,
      required this.peopleType,
      required this.business_name});

  @override
  _DetailWriteState createState() => _DetailWriteState();
}

class _DetailWriteState extends State<DetailWrite> {
  late dynamic message = '';
  String _downloadUrl = '';

  @override
  void initState() {
    super.initState();
    detailedWriters(); 
  }

  Future<void> detailedWriters() async {
    final url = Uri.parse(
        'http://192.168.33.217:160/patent-app/write/detailedWriters.php');
    final response = await http.post(url, body: {
      'name': widget.business_name,
      'token': widget.token,
    });
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      setState(() {
        message = jsonData;
        _downloadUrl =
            'http://192.168.33.217:180/patents/public${message[0]['writeUrl']}';
      });

      print(message);
      print(message[0]['name']);
      print(_downloadUrl);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  String _downloadProgress = '';
  bool _isDownloading = false;

  Future<void> _startDownload() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = '下载中...';
    });

    final httpClient = HttpClient();
    File file;
    String filePath = '';

    try {
      final request = await httpClient.getUrl(Uri.parse(_downloadUrl));
      final response = await request.close();

      final appDir = await getExternalStorageDirectory();

      final parentFolder = path.join(
          appDir!.parent!.parent!.path, 'patent'); 
      final fileName = 'your_word_file.docx';
      filePath = path.join(parentFolder, fileName); 
      file = File(filePath);

      final parentDirectory = Directory(parentFolder);
      if (!await parentDirectory.exists()) {
        await parentDirectory.create(recursive: true);
      }

      final fileSink = file.openWrite();
      int totalBytes = 0;

      await response.forEach((List<int> data) {
        totalBytes += data.length;
        fileSink.add(data);

        setState(() {
          _downloadProgress =
              '下载中... ${(totalBytes / response.contentLength * 100).toStringAsFixed(2)}%';
        });
      });

      await fileSink.close();
    } catch (e) {
      print('下载错误: $e');
      setState(() {
        _downloadProgress = '下载失败';
      });
    } finally {
      httpClient.close();
    }

    setState(() {
      _isDownloading = false;
      _downloadProgress = '下载完成，保存于: $filePath';
      print(filePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.business_name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Text(
                  '上传文档需要在Web端进行上传',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Text(
                  '唯一标识：',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Text(
                  message.isEmpty ? '' : message[0]['idcode'],
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Text(
                  '当前状态：',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Text(
                  message.isEmpty ? '' : message[0]['now_status'],
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _isDownloading ? null : _startDownload,
              child: Text('下载文档'),
            ),
            SizedBox(height: 16),
            Text(_downloadProgress),
          ],
        ),
      ),
    );
  }
}
