import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:patent/subject/addmy.dart';

class myfile extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<myfile> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://8.141.86.125/patent-app/subjectmy.php');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        this.data = data;
      });
      print(data);
    } else {
      print(111);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人主体'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePagess()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExplorePageaa(data[index])),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(data[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//展示和修改
class ExplorePageaa extends StatefulWidget {
  final String data;

  ExplorePageaa(this.data);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<ExplorePageaa> {
  bool _isInputEnabled = false;
  late Map<String, String> _inputValues;
  late TextEditingController _nameController;
  late TextEditingController _sexController;
  late TextEditingController _idcardController;
  late TextEditingController _educationalController;
  late TextEditingController _service_talentsController;
  late TextEditingController _scientistController;

  bool _dataLoaded = false;
  @override
  void initState() {
    super.initState();
    fetchData();
    _inputValues = {
      'name': '',
      'sex': '',
      'idcard': '',
      'educational': '',
      'service_talents': '',
      'scientist': '',
    };
    _nameController = TextEditingController(text: _inputValues['name']);
    _sexController = TextEditingController(text: _inputValues['sex']);
    _idcardController = TextEditingController(text: _inputValues['idcard']);
    _educationalController =
        TextEditingController(text: _inputValues['educational']);
    _service_talentsController =
        TextEditingController(text: _inputValues['service_talents']);
    _scientistController =
        TextEditingController(text: _inputValues['scientist']);
  }

  Future<void> fetchData() async {
    final url = Uri.http('8.141.86.125', '/patent-app/my.php');
    final response = await http.post(
      url,
      body: {
        'name': widget.data,
      },
    );
    if (response.statusCode == 200) {
      final dd = json.decode(response.body);

      print(dd);
      print(dd[0]['name']);
      setState(() {
        _inputValues['name'] = dd[0]['name'];
        _inputValues['sex'] = dd[0]['sex'];
        _inputValues['idcard'] = dd[0]['idcard'];
        _inputValues['educational'] = dd[0]['educational'];
        _inputValues['service_talents'] = dd[0]['service_talents'];
        _inputValues['scientist'] = dd[0]['scientist'];

        _dataLoaded = true;
      });
      _nameController.text = _inputValues['name']!;
      _sexController.text = _inputValues['sex']!;
      _idcardController.text = _inputValues['idcard']!;
      _educationalController.text = _inputValues['educational']!;
      _service_talentsController.text = _inputValues['service_talents']!;
      _scientistController.text = _inputValues['scientist']!;
    } else {
      print(111);
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _toggleInput() {
    setState(() {
      _isInputEnabled = !_isInputEnabled;
    });
  }

  void _updateValue(String field, String value) {
    setState(() {
      _inputValues[field] = value;
    });
  }

  void _submitChanges() async {
    final url = Uri.http('8.141.86.125', '/patent-app/editmy.php');
    final response = await http.post(
      url,
      body: {
        'name': _inputValues['name'],
        'chinese_name': _inputValues['sex'],
        'idcard': _inputValues['idcard'],
        'educational': _inputValues['educational'],
        'service_talents': _inputValues['service_talents'],
        'scientist': _inputValues['scientist'],
      },
    );
    if (response.statusCode == 200) {
      final aa = json.decode(response.body);
      print(aa);
      print('Changes submitted successfully.');
    } else {
      print('Failed to submit changes. Status code: ${response.statusCode}.');
    }
  }

//有边界
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.data}', style: TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          if (!_isInputEnabled) ...[
            ScrollableRow(
              label: '名称:',
              value: '${_inputValues["name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '性别:',
              value: '${_inputValues["sex"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '身份证号:',
              value: '${_inputValues["idcard"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '学历:',
              value: '${_inputValues["educational"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '服务人才:',
              value: '${_inputValues["service_talents"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '科学家:',
              value: '${_inputValues["scientist"]}',
            ),
            SizedBox(height: 10),
          ],
          if (_isInputEnabled) ...[
            SizedBox(height: 16),
            TextInputField(
              controller: _nameController,
              field: 'name',
              labelText: '名字',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _sexController,
              field: 'sex',
              labelText: '性别',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _idcardController,
              field: 'idcard',
              labelText: '身份证号',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _educationalController,
              field: 'educational',
              labelText: '学历',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _service_talentsController,
              field: 'service_talents',
              labelText: '服务人才',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _scientistController,
              field: 'scientist',
              labelText: '科学家',
              onUpdate: _updateValue,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitChanges,
              child: Text('提交'),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleInput,
        child: Icon(_isInputEnabled ? Icons.edit : Icons.not_interested),
        shape: CircleBorder(),
      ),
    );
  }
}

class ScrollableRow extends StatelessWidget {
  final String label;
  final String value;

  ScrollableRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 19, color: Colors.black45),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 19, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String field;
  final String labelText;
  final Function(String, String) onUpdate;

  TextInputField({
    required this.controller,
    required this.field,
    required this.labelText,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        onChanged: (value) => onUpdate(field, value),
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
