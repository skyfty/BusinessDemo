import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

//全局变量
class MyGlobals {
  static String RR = '';
  static String idType = '';
}

//发明人
class showProposerPage extends StatefulWidget {
  final String name;

  showProposerPage({required this.name});
  @override
  _showProposerPageState createState() => _showProposerPageState();
}

class _showProposerPageState extends State<showProposerPage> {
  bool _isInputEnabled = false;
  late Map<String, String> _inputValues;
  late TextEditingController _nameController;
  late TextEditingController _english_nameController;
  late TextEditingController _user_numberController;
  late TextEditingController _applicant_typeController;
  late TextEditingController _certificate_typeController;
  late TextEditingController _id_numberController;
  late TextEditingController _nationality_regionController;
  late TextEditingController _place_residenceController;
  late TextEditingController _provienceController;

  late TextEditingController _streetController;
  late TextEditingController _postal_codeController;
  late TextEditingController _emailController;
  late TextEditingController _applicant_telephoneController;
  late TextEditingController _fee_reduction_requestController;
  late TextEditingController _pre_examination_recordController;
  late TextEditingController _general_committee_recordController;

  bool _dataLoaded = false;
  @override
  void initState() {
    //初始化
    super.initState(); //
    fetchData();
    Quanju.dd = widget.name;
    _inputValues = {
      'name': '',
      'english_name': '',
      'user_number': '',
      'applicant_type': '',
      'certificate_type': '',
      'id_number': '',
      'nationality_region': '',
      'place_residence': '',
      'provience': '',
      
      'street': '',
      'postal_code': '',
      'email': '',
      'applicant_telephone': '',
      'fee_reduction_request': '',
      'pre_examination_record': '',
      'general_committee_record': '',

     
    };
    _nameController = TextEditingController(text: _inputValues['name']);
    _english_nameController =
        TextEditingController(text: _inputValues['english_name']);
    _user_numberController =
        TextEditingController(text: _inputValues['user_number']);
    _applicant_typeController =
        TextEditingController(text: _inputValues['applicant_type']);
    _certificate_typeController =
        TextEditingController(text: _inputValues['certificate_type']);
    _id_numberController =
        TextEditingController(text: _inputValues['id_number']);
    _nationality_regionController =
        TextEditingController(text: _inputValues['nationality_region']);
    _place_residenceController =
        TextEditingController(text: _inputValues['place_residence']);
    _provienceController =
        TextEditingController(text: _inputValues['provience']);
    // _cityController = TextEditingController(text: _inputValues['city']);
    _streetController = TextEditingController(text: _inputValues['street']);
    _postal_codeController =
        TextEditingController(text: _inputValues['postal_code']);
    _emailController = TextEditingController(text: _inputValues['email']);
    _applicant_telephoneController =
        TextEditingController(text: _inputValues['applicant_telephone']);
    _fee_reduction_requestController =
        TextEditingController(text: _inputValues['fee_reduction_request']);
    _pre_examination_recordController =
        TextEditingController(text: _inputValues['pre_examination_record']);
    _general_committee_recordController =
        TextEditingController(text: _inputValues['general_committee_record']);
  }

  Future<void> fetchData() async {
  
    final url =
        Uri.http('8.141.86.125', '/patent-app/index/applicant/show.php');
    final response = await http.post(
      url,
      body: {
        'name': widget.name,
        'surface': 'proposer',
      },
    );

    if (response.statusCode == 200) {
      final dd = json.decode(response.body);
      print(dd);
      // print(widget.name);
      print(dd[0]['name']);
      setState(() {
        _inputValues['name'] = dd[0]['name'];
        _inputValues['english_name'] = dd[0]['english_name']; // 确保在获取数据后更新状态
        _inputValues['user_number'] = dd[0]['user_number'];
        _inputValues['applicant_type'] = dd[0]['applicant_type'];
        _inputValues['certificate_type'] = dd[0]['certificate_type'];
        _inputValues['id_number'] = dd[0]['id_number'];
        _inputValues['nationality_region'] = dd[0]['nationality_region'];
        _inputValues['place_residence'] = dd[0]['place_residence'];
        _inputValues['provience'] = dd[0]['provience'];
        // _inputValues['city'] = dd[0]['city'];
        _inputValues['street'] = dd[0]['street'];
        _inputValues['postal_code'] = dd[0]['postal_code'];
        _inputValues['email'] = dd[0]['email'];
        _inputValues['applicant_telephone'] = dd[0]['applicant_telephone'];
        _inputValues['fee_reduction_request'] = dd[0]['fee_reduction_request'];
        _inputValues['pre_examination_record'] =
            dd[0]['pre_examination_record'];
        _inputValues['general_committee_record'] =
            dd[0]['general_committee_record'];
        _dataLoaded = true;
      });
      _nameController.text = _inputValues['name']!; // 更新文本框的值
      _english_nameController.text = _inputValues['english_name']!;
      _user_numberController.text = _inputValues['user_number']!;
      _applicant_typeController.text = _inputValues['applicant_type']!;
      _certificate_typeController.text = _inputValues['certificate_type']!;
      _id_numberController.text = _inputValues['id_number']!;
      _nationality_regionController.text = _inputValues['nationality_region']!;
      _place_residenceController.text = _inputValues['place_residence']!;
      _provienceController.text = _inputValues['provience']!;
      // _cityController.text = _inputValues['city']!;
      _streetController.text = _inputValues['street']!;
      _postal_codeController.text = _inputValues['postal_code']!;
      _emailController.text = _inputValues['email']!;
      _applicant_telephoneController.text =
          _inputValues['applicant_telephone']!;
      _fee_reduction_requestController.text =
          _inputValues['fee_reduction_request']!;
      _pre_examination_recordController.text =
          _inputValues['pre_examination_record']!;
      _general_committee_recordController.text =
          _inputValues['general_committee_record']!;
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
    //更新值
    setState(() {
      _inputValues[field] = value; //更新值
      print(field);
      if (field == 'certificate_type') {
        updateIdType(value);
      }
    });
  }

  void _submitChanges() async {
   
    final url = Uri.http(
        '8.141.86.125', '/patent-app/index/applicant/proposerEdit.php');
    final response = await http.post(
      url,
      body: {
        'name': _inputValues['name'],
        'english_name': _inputValues['english_name'],
        'user_number': _inputValues['user_number'],
        'applicant_type': _inputValues['applicant_type'],
        'certificate_type': _inputValues['certificate_type'],
        'id_number': _inputValues['id_number'],
        'nationality_region': _inputValues['nationality_region'],
        'place_residence': _inputValues['place_residence'],
        'provience': _inputValues['provience'],
        // 'city': _inputValues['city'],
        'street': _inputValues['street'],
        'postal_code': _inputValues['postal_code'],
        'email': _inputValues['email'],
        'applicant_telephone': _inputValues['applicant_telephone'],
        'fee_reduction_request': _inputValues['fee_reduction_request'],
        'pre_examination_record': _inputValues['pre_examination_record'],
        'general_committee_record': _inputValues['general_committee_record'],
      },
    );
    if (response.statusCode == 200) {
      final aa = json.decode(response.body);
     
      if (aa['success'] == '更新成功') {
        Fluttertoast.showToast(msg: aa['success']);
      } else {
        Fluttertoast.showToast(msg: aa['error']);
      }
   
    } else {
      print('请求失败');
      print('Failed to submit changes. Status code: ${response.statusCode}.');
    }
  }

  void updateIdType(String newValue) {
    setState(() {
      print(newValue);
      MyGlobals.idType = newValue;
    });
    print(MyGlobals.idType);
    print(MyGlobals.idType);
  }

  showProposerPage() {
    _nameController.addListener(() {
      MyGlobals.RR = _nameController.text;
    });


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
              label: '用户编号:',
              value: '${_inputValues["user_number"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '申请人类型:',
              value: '${_inputValues["applicant_type"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '证件类型:',
              value: '${_inputValues["certificate_type"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '身份证号:',
              value: '${_inputValues["id_number"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '国籍地区:',
              value: '${_inputValues["nationality_region"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '居所地:',
              value: '${_inputValues["place_residence"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '省份:',
              value: '${_inputValues["provience"]}',
            ),
          
            SizedBox(height: 10),
            ScrollableRow(
              label: '街道:',
              value: '${_inputValues["street"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '邮政编码:',
              value: '${_inputValues["postal_code"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '电子邮箱:',
              value: '${_inputValues["email"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '申请人电话:',
              value: '${_inputValues["applicant_telephone"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '减缓请求:',
              value: '${_inputValues["fee_reduction_request"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '预审备案:',
              value: '${_inputValues["pre_examination_record"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '总委备案:',
              value: '${_inputValues["general_committee_record"]}',
            ),
          ],
          if (_isInputEnabled) ...[
            SizedBox(height: 16),
            TextInputField(
              controller: _nameController,
              field: 'name',
              labelText: '姓名或名称',
              prefixIcon: Icons.people,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _english_nameController,
              field: 'english_name',
              labelText: '姓名或名称(英文)',
              prefixIcon: Icons.engineering,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _user_numberController,
              field: 'user_number',
              labelText: '用户编号',
              prefixIcon: Icons.format_list_numbered,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _applicant_typeController,
              field: 'applicant_type',
              labelText: '申请人类型',
              prefixIcon: Icons.class_,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _certificate_typeController,
              field: 'certificate_type',
              labelText: '证件类型',
              prefixIcon: Icons.add_card_rounded,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _id_numberController,
              field: 'id_number',
              labelText: '证件号',
              prefixIcon: Icons.sd_card,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _nationality_regionController,
              field: 'nationality_region',
              labelText: '国籍地区',
              prefixIcon: Icons.roofing,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _place_residenceController,
              field: 'place_residence',
              labelText: '住所',
              prefixIcon: Icons.maps_home_work_rounded,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _provienceController,
              field: 'provience',
              labelText: '省份',
              prefixIcon: Icons.safety_check_outlined,
              onUpdate: _updateValue,
            ),
          
            SizedBox(height: 25),
            TextInputField(
              controller: _streetController,
              field: 'street',
              labelText: '街道',
              prefixIcon: Icons.maps_home_work_rounded,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _postal_codeController,
              field: 'postal_code',
              labelText: '邮政编码',
              prefixIcon: Icons.confirmation_number_outlined,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _emailController,
              field: 'email',
              labelText: '电子邮箱',
              prefixIcon: Icons.email,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _applicant_telephoneController,
              field: 'applicant_telephone',
              labelText: '申请人电话',
              prefixIcon: Icons.phone_iphone,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 25),
            TextInputField(
              controller: _fee_reduction_requestController,
              field: 'fee_reduction_request',
              labelText: '减缓费用请求',
              prefixIcon: Icons.local_atm,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 16),
            TextInputField(
              controller: _pre_examination_recordController,
              field: 'pre_examination_record',
              labelText: '预审备案',
              prefixIcon: Icons.confirmation_number_outlined,
              onUpdate: _updateValue,
            ),
            SizedBox(height: 16),
            TextInputField(
              controller: _general_committee_recordController,
              field: 'general_committee_record',
              labelText: '总委备案',
              prefixIcon: Icons.pix,
              onUpdate: _updateValue,
            ),
          ],
        ],
      ),
    );
  }
}

//全局变量
class Quanju {
  static String dd = '';
}

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
    '预审备案': [
      DropdownMenuItem(
        value: '是',
        child: Text('是'),
      ),
      DropdownMenuItem(
        value: '否',
        child: Text('否'),
      ),
      
    ],
    '总委备案': [
      DropdownMenuItem(
        value: '是',
        child: Text('是'),
      ),
      DropdownMenuItem(
        value: '否',
        child: Text('否'),
      ),
      
    ],
    '申请人类型': [
      DropdownMenuItem(
        value: '大专院校',
        child: Text('大专院校'),
      ),
      DropdownMenuItem(
        value: '科研单位',
        child: Text('科研单位'),
      ),
      DropdownMenuItem(
        value: '工矿企业',
        child: Text('工矿企业'),
      ),
      DropdownMenuItem(
        value: '事业单位',
        child: Text('事业单位'),
      ),
      DropdownMenuItem(
        value: '个人',
        child: Text('个人'),
      ),
    ],
    '证件类型': [
      DropdownMenuItem(
        value: '身份证',
        child: Text('身份证'),
      ),
      DropdownMenuItem(
        value: '统一信用代码',
        child: Text('统一信用代码'),
      ),
      DropdownMenuItem(
        value: '护照',
        child: Text('护照'),
      ),
    ],
    '减缓费用请求': [
      DropdownMenuItem(
        value: '是',
        child: Text('是'),
      ),
      DropdownMenuItem(
        value: '否',
        child: Text('否'),
      ),
      
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
                    widget.onUpdate(widget.field, value!);
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  labelText: widget.labelText,
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
                   
                
                  
                    if (widget.field == 'id_number' &&
                        widget.controller.text.length == 18 &&
                        widget.controller.text != '请输入18位身份证号码') {
                      widget.controller.text = value.substring(0, 18);
                    } else if (widget.field == 'applicant_telephone' &&
                        (widget.controller.text.length < 11 ||
                            widget.controller.text.length > 11)) {
                      widget.controller.text = value.substring(0, 11);
                    }
                  });
                  widget.onUpdate(widget.field, value);
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
                  errorText: (widget.field == 'applicant_telephone' &&
                          (widget.controller.text.length < 11 ||
                              widget.controller.text.length > 11))
                      ? '请输入11位手机号码'
                      : (widget.field == 'id_number' &&
                        
                              MyGlobals.idType == '身份证' && 
                              (widget.controller.text.length < 18 ||
                                  widget.controller.text.length > 18))
                          ? '请输入18位身份证号码'
                          : (widget.field == 'id_number' &&
                                  MyGlobals.idType.isNotEmpty &&
                                  MyGlobals.idType == '护照' &&
                                  (widget.controller.text.length < 9 ||
                                      widget.controller.text.length > 9))
                              ? '请输入9位护照号码'
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
      color: Colors.grey[200], // 更改背景颜色
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
                style:
                    TextStyle(fontSize: 18, color: Colors.black87), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
