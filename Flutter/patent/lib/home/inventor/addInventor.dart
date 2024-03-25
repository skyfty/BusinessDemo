import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';

class MyGlobals {
  static String RR = '';
}

class addInventor extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController idcardController = TextEditingController();

  String? filePath; // Holds the path of the selected file

  void _submitChanges() async {
    String idCard = idcardController.text;
    if (idCard.length != 18) {
      Fluttertoast.showToast(msg: '身份证号必须是18位');
      return;
    }

    final url =
        Uri.http('8.141.86.125', '/patent-app/index/inventor/inventorAdd.php');

    var request = http.MultipartRequest('POST', url);

    // Add form fields
    request.fields['name'] = nameController.text;
    request.fields['english_name'] = englishNameController.text;
    request.fields['state'] = stateController.text;
    request.fields['idcard'] = idcardController.text;

    // Add the file field
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('file', filePath!));
    }

    // Send the request
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      print(data);
      if (data['success'] == '添加成功') {
        Fluttertoast.showToast(msg: data['success']);
        //刷新页面
        // Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: data['error']);
      }

      print('Changes submitted successfully.');
    } else {
      print('Failed to submit changes. Status code: ${response.statusCode}.');
    }
  }

  addBusiness() {
    nameController.addListener(() {
      MyGlobals.RR = nameController.text;
    });
  }

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
      print('Selected file: $filePath');
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加发明人', style: TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          Container(
            height: 140,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'name',
                      labelText: '姓名',
                      controller: nameController,
                      prefixIcon: Icons.people,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 140,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'english_name',
                      labelText: '英文简称',
                      controller: englishNameController,
                      prefixIcon: Icons.engineering,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 140,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'state',
                      labelText: '国家',
                      controller: stateController,
                      prefixIcon: Icons.sim_card,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 140,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'idcard',
                      labelText: '身份证号',
                      controller: idcardController,
                      prefixIcon: Icons.ac_unit,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitChanges,
            child: Text('添加'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _selectFile,
            child: Text('选择文件'),
          ),
        ],
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  final String field;
  final String labelText;
  final TextEditingController controller;
  final IconData prefixIcon;

  TextInputField({
    required this.field,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
        ),
        controller: controller,
      ),
    );
  }
}
