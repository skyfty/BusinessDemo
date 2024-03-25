import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ExplorePagess extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController idcardController = TextEditingController();
  final TextEditingController educationalController = TextEditingController();
  final TextEditingController service_talentsController =
      TextEditingController();
  final TextEditingController scientistController = TextEditingController();

  void _submitChanges() async {
    final url = Uri.http('8.141.86.125', '/patent-app/addmy.php');
    final response = await http.post(
      url,
      body: {
        'name': nameController.text,
        'sex': sexController.text,
        'idcard': idcardController.text,
        'educational': educationalController.text,
        'service_talents': service_talentsController.text,
        'scientist': scientistController.text,
      },
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['success'] == '添加成功') {
        Fluttertoast.showToast(msg: jsonResponse['success']);
      } else {
        Fluttertoast.showToast(msg: '添加失败');
      }
    } else {
      print('Failed to submit changes. Status code: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加个人主体', style: TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          TextInputField(
            field: 'name',
            labelText: '名字',
            controller: nameController,
          ),
          TextInputField(
            field: 'sex',
            labelText: '性别',
            controller: sexController,
          ),
          TextInputField(
            field: 'idcard',
            labelText: '身份证号',
            controller: idcardController,
          ),
          TextInputField(
            field: 'educational',
            labelText: '学历',
            controller: educationalController,
          ),
          TextInputField(
            field: 'service_talents',
            labelText: '服务人才',
            controller: service_talentsController,
          ),
          TextInputField(
            field: 'scientist',
            labelText: '科学家',
            controller: scientistController,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitChanges,
            child: Text('提交'),
          ),
        ],
      ),
    );
  }
}

class TextInputField extends StatefulWidget {
  final String field; //字段
  final String labelText; //标签
  final TextEditingController controller; //控制器

  TextInputField({
    required this.field,
    required this.labelText,
    required this.controller,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  Future<Map<String, dynamic>?> uploadImage(List<int> imageBytes) async {
    final url = Uri.parse('http://8.141.86.125/patent-app/upload.php');
    final request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: 'image.jpg',
    ));
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = await response.stream.bytesToString();
      return json.decode(jsonResponse);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isReadOnly = widget.field == 'business_licence' ||
        widget.field == 'brand' ||
        widget.field == 'appearance_patent_granted';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller, //
              decoration: InputDecoration(
                labelText: widget.labelText,
              ),
              readOnly: isReadOnly,
            ),
          ),
        ],
      ),
    );
  }
}
