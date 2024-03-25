//添加企业主体

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

//全局变量
class MyGlobals {
  static String RR = '';
}

// 添加主体页面
class addBusiness extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController chineseNameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _signedController = TextEditingController();
  final TextEditingController _industry_model_idController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  final TextEditingController _registerdateController = TextEditingController();

  final TextEditingController _registermoneyController =
      TextEditingController();
  final TextEditingController _registerfundController = TextEditingController();
  final TextEditingController _credit_codeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _acreageController = TextEditingController();
  final TextEditingController _unauthorized_appearance_patentController =
      TextEditingController();
  final TextEditingController _appearance_patent_grantedController =
      TextEditingController();
  final TextEditingController _unauthorized_invention_patentController =
      TextEditingController();

  final TextEditingController _authorize_patent_countController =
      TextEditingController();
  final TextEditingController _not_authorize_patent_countController =
      TextEditingController();
  final TextEditingController _authorize_new_patent_countController =
      TextEditingController();
  final TextEditingController _register_bookmaking_countController =
      TextEditingController();
  final TextEditingController _apply_bookmaking_countController =
      TextEditingController();
  final TextEditingController _aptitude_stateController =
      TextEditingController();
  final TextEditingController _business_licenceController =
      TextEditingController();
  final TextEditingController _scaleController = TextEditingController();
  final TextEditingController _hightechController = TextEditingController();
  final TextEditingController _trademark_cntController =
      TextEditingController();
  final TextEditingController _ms_enterprisesController =
      TextEditingController();
  final TextEditingController _enrolladdressController =
      TextEditingController();
  final TextEditingController _business_licence_codeController =
      TextEditingController();
  void _submitChanges() async {
    final url = Uri.http('8.141.86.125', '/patent-app/add.php');
    final response = await http.post(
      url,
      body: {
        'name': nameController.text,
        'chinese_name': chineseNameController.text,
        'english_name': englishNameController.text,
        'brand': _brandController.text,
        'signed': _signedController.text,
        'industry_model_id': _industry_model_idController.text,
        'phone': _phoneController.text,
        'telephone': _telephoneController.text,
        'registerdate': _registerdateController.text,
        'registerfund': _registerfundController.text,
        'credit_code': _credit_codeController.text,
        'type': _typeController.text,
        'acreage': _acreageController.text,
        'unauthorized_appearance_patent':
            _unauthorized_appearance_patentController.text,
        'appearance_patent_granted': _appearance_patent_grantedController.text,
        'unauthorized_invention_patent':
            _unauthorized_invention_patentController.text,
        'authorize_patent_count': _authorize_patent_countController.text,
        'not_authorize_patent_count':
            _not_authorize_patent_countController.text,
        'authorize_new_patent_count':
            _authorize_new_patent_countController.text,
        'register_bookmaking_count': _register_bookmaking_countController.text,
        'apply_bookmaking_count': _apply_bookmaking_countController.text,
        'aptitude_state': _aptitude_stateController.text,
        'business_licence': _business_licenceController.text,
        'scale': _scaleController.text,
        'hightech': _hightechController.text,
        'trademark_cnt': _trademark_cntController.text,
        'ms_enterprises': _ms_enterprisesController.text,
        'enrolladdress': _enrolladdressController.text,
        'business_licence_code': _business_licence_codeController.text,
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data['success'] == '添加成功') {
        Fluttertoast.showToast(msg: data['success']);
        // Navigator.push(
        //   this.context,
        //   MaterialPageRoute(builder: (context) => FirstPage()),
        // );
        // navigatorKey.currentState?.push(
        //   MaterialPageRoute(builder: (context) => FirstPage()),
        // );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加企业主体', style: TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          Container(
            height: 180,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'name',
                      labelText: '公司名称',
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                      field: 'chinese_name',
                      labelText: '中文简称',
                      controller: chineseNameController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 180,
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                      controller: _brandController,
                      field: 'brand',
                      labelText: '商标',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 180,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _signedController,
                      field: 'signed',
                      labelText: '签约',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputField(
                      controller: _industry_model_idController,
                      field: 'industry_model_id',
                      labelText: '行业',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 400,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _phoneController,
                      field: 'phone',
                      labelText: '电话号码',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _telephoneController,
                      field: 'telephone',
                      labelText: '手机号码',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _registerdateController,
                      field: 'registerdate',
                      labelText: '注册日期',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _registerfundController,
                      field: 'registerfund',
                      labelText: '注册资金',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _credit_codeController,
                      field: 'credit_code',
                      labelText: '统一信用代码',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 180,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _typeController,
                      field: 'type',
                      labelText: '企业性质',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _acreageController,
                      field: 'acreage',
                      labelText: '办公面积',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 180,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _business_licenceController,
                      field: 'business_licence',
                      labelText: '营业执照副本',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _scaleController,
                      field: 'scale',
                      labelText: '员工数',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 240,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _hightechController,
                      field: 'hightech',
                      labelText: '高新企业',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _trademark_cntController,
                      field: 'trademark_cnt',
                      labelText: '注册商标数',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _ms_enterprisesController,
                      field: 'ms_enterprises',
                      labelText: '中小微企业',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 180,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      controller: _enrolladdressController,
                      field: 'enrolladdress',
                      labelText: '注册地址',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextInputField(
                      controller: _business_licence_codeController,
                      field: 'business_licence_code',
                      labelText: '营业执照号',
                    ),
                  ],
                ),
              ),
            ),
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
  final String field;
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
  String imageUrl = '';
  void _patentNum() async {
    if (MyGlobals.RR.isNotEmpty) {
      setState(() {
        widget.controller.text = '123';
      });
    } else {
      setState(() {
        // 更新图片地址
        widget.controller.text = '请输入公司名称';
      });
    }
  }

  void _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageFile = await pickedImage.readAsBytes();
      final response = await uploadImage(pickedImageFile);
      if (response != null && response.containsKey('name')) {
        final uploadedImageUrl =
            'http://8.141.86.125/patent-app/${response['name']}';
        setState(() {
          imageUrl = uploadedImageUrl;
          widget.controller.text = imageUrl;
        });
      }
    }
  }

  Future<Map<String, dynamic>?> uploadImage(List<int> imageBytes) async {
    final url = Uri.parse('http://8.141.86.125/patent-app/upload.php');
    final request = http.MultipartRequest('POST', url);
    request.fields['name'] = MyGlobals.RR; // 添加name参数

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: 'image.jpg',
    ));
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: '上传成功');
      print(json.decode(jsonResponse));
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

    bool shouldShowButton = widget.field == 'appearance_patent_granted' ||
        widget.field == 'unauthorized_appearance_patent' ||
        widget.field == 'unauthorized_invention_patent' ||
        widget.field == 'authorize_patent_count' ||
        widget.field == 'not_authorize_patent_count' ||
        widget.field == 'authorize_new_patent_count' ||
        widget.field == 'register_bookmaking_count' ||
        widget.field == 'register_bookmaking_count' ||
        widget.field == 'register_bookmaking_count';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: widget.labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              readOnly: isReadOnly,
            ),
          ),
          if (widget.field == 'business_licence' || widget.field == 'brand')
            IconButton(
              onPressed: _uploadImage,
              icon: Icon(Icons.upload_file),
            ),
          Visibility(
            visible: shouldShowButton,
            child: TextButton(
              onPressed: () {
                _patentNum();
              },
              child: Text('查询'),
            ),
          ),
        ],
      ),
    );
  }
}
