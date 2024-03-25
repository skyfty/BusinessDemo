import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

//发明人
class showInventorPage extends StatefulWidget {
  final String name;

  showInventorPage({required this.name});
  @override
  _showInventorPageState createState() => _showInventorPageState();
}

class _showInventorPageState extends State<showInventorPage> {
  bool _isInputEnabled = false;
  late Map<String, String> _inputValues;
  late TextEditingController _nameController;
  late TextEditingController _english_nameController;
  late TextEditingController _stateController;
  late TextEditingController _idcardController;

  bool _dataLoaded = false; //
  @override
  void initState() {
    super.initState();
    fetchData();
    Quanju.dd = widget.name;
    _inputValues = {
      'name': '',
      'english_name': '',
      'state': '',
      'idcard': '',
    };
    _nameController = TextEditingController(text: _inputValues['name']);
    _english_nameController =
        TextEditingController(text: _inputValues['english_name']);
    _stateController = TextEditingController(text: _inputValues['state']);
    _idcardController = TextEditingController(text: _inputValues['idcard']);
  }

  Future<void> fetchData() async {
    final url =
        Uri.http('8.141.86.125', '/patent-app/index/applicant/show.php');
    final response = await http.post(
      url,
      body: {
        'name': widget.name,
        'surface': 'inventor',
      },
    );

    if (response.statusCode == 200) {
      final dd = json.decode(response.body);
      print(dd);

      print(dd[0]['name']);
      setState(() {
        _inputValues['name'] = dd[0]['name'];
        _inputValues['english_name'] = dd[0]['english_name']; // 确保在获取数据后更新状态
        _inputValues['state'] = dd[0]['state'];
        _inputValues['idcard'] = dd[0]['idcard'];
        _dataLoaded = true;
      });
      _nameController.text = _inputValues['name']!; // 更新文本框的值
      _english_nameController.text = _inputValues['english_name']!;
      _stateController.text = _inputValues['state']!;
      _idcardController.text = _inputValues['idcard']!;
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
    final url =
        Uri.http('8.141.86.125', '/patent-app/index/inventor/inventorEdit.php');
    final response = await http.post(
      url,
      body: {
        'name': _inputValues['name'],
        'english_name': _inputValues['english_name'],
        'state': _inputValues['state'],
        'idcard': _inputValues['idcard'],
      },
    );
    if (response.statusCode == 200) {
      print(
        _inputValues['english_name'],
      );
      final aa = json.decode(response.body);
      if (aa['success'] == '更新成功') {
        Fluttertoast.showToast(msg: aa['success']);
      } else {
        Fluttertoast.showToast(msg: aa['error']);
      }
      print(aa);
      print('Changes submitted successfully.');
    } else {
      print('Failed to submit changes. Status code: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}', style: TextStyle(fontSize: 16)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Container(
              width: 48, // 设置宽度
              height: 48, // 设置高度
              child: FloatingActionButton(
                onPressed: () {
                  if (_isInputEnabled) {
                    _submitChanges();
                    _toggleInput();
                  } else {
                    _toggleInput();
                  }
                },
                child: _isInputEnabled ? Text('提交') : Text('编辑'),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0), //更改按钮圆角
                ),
                elevation: 0.0, //更改阴影
                hoverElevation: 0.0, //更改阴影
                focusElevation: 0.0, //更改阴影
                highlightElevation: 0.0, //更改阴影
                disabledElevation: 0.0, //更改阴影
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          if (!_isInputEnabled) ...[
            ScrollableRow(
              label: '姓名或名称:',
              value: '${_inputValues["name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '姓名或名称(英文):',
              value: '${_inputValues["english_name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '国家:',
              value: '${_inputValues["state"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '身份证号:',
              value: '${_inputValues["idcard"]}',
            ),
            SizedBox(height: 10),
          ],
          if (_isInputEnabled) ...[
            SizedBox(height: 16),
            TextInputField(
              controller: _nameController,
              field: 'name',
              labelText: '姓名或名称',
              prefixIcon: Icons.one_k_outlined,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _english_nameController,
              field: 'english_name',
              labelText: '姓名或名称(英文)',
              prefixIcon: Icons.one_k_outlined,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _stateController,
              field: 'state',
              labelText: '国家',
              prefixIcon: Icons.one_k_outlined,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _idcardController,
              field: 'idcard',
              labelText: '身份证号',
              prefixIcon: Icons.one_k_outlined,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

//修改
class TextInputField extends StatefulWidget {
  final String field; //字段
  final String labelText; //标签
  final TextEditingController controller; //控制器
  final IconData prefixIcon; // 前缀图标
  final Function(String, String) onUpdate;

  TextInputField({
    required this.field,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
    required this.onUpdate,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  String? selectedValue; // 用户选择的值

  Map<String, List<DropdownMenuItem<String>>> dropdownOptions = {
    '减缓费用请求': [
      DropdownMenuItem(
        value: '是',
        child: Text('是'),
      ),
      DropdownMenuItem(
        value: '否',
        child: Text('否'),
      ),
      // 添加其他选项
    ],
    '国家': [
      DropdownMenuItem(
        value: '中国',
        child: Text('中国'),
      ),
      DropdownMenuItem(
        value: '美国',
        child: Text('美国'),
      ),
      // 添加其他选项
    ],
  };
  @override
  void initState() {
    super.initState();
    selectedValue = widget.controller.text; // 初始化selectedValue为controller的初始值
  }

  @override
  Widget build(BuildContext context) {
    if (dropdownOptions.containsKey(widget.labelText)) {
      List<DropdownMenuItem<String>> options =
          dropdownOptions[widget.labelText]!;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    widget.controller.text = value ?? ''; // 更新controller的值
                    widget.onUpdate(widget.field, value!); // 调用onUpdate回调
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),

                  labelText: widget.labelText, // 设置标签
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 63, 93, 80),
                  ),
                  prefixIcon: Icon(
                    widget.prefixIcon,
                    color: Color.fromARGB(255, 63, 93, 80),
                  ),
                ),
                items: options,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                cursorColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    // 清除错误提示信息
                    if (widget.field == 'idcard' &&
                        widget.controller.text.length == 18 &&
                        widget.controller.text != '请输入18位身份证号码') {
                      widget.controller.text = value.substring(0, 18);
                    }
                  });
                  widget.onUpdate(widget.field, value); // 执行更新回调
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  labelText: widget.labelText,
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 63, 93, 80),
                  ),
                  hintText: "请输入${widget.labelText}",
                  prefixIcon: Icon(
                    widget.prefixIcon,
                    color: Color.fromARGB(255, 63, 93, 80),
                  ),
                  errorText: (widget.field == 'idcard' && // 如果是身份证号码字段
                          widget.controller.text.isNotEmpty && // 并且输入不为空
                          widget.controller.text.length != 18) // 并且长度不等于18
                      ? '请输入18位身份证号码'
                      : null,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

//展示
class ScrollableRow extends StatelessWidget {
  final String label;
  final String value;

  ScrollableRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                value,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Quanju {
  static String dd = '';
}

//修改组件
