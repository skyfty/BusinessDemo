import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsPage extends StatefulWidget {
  final String data;

  DetailsPage(this.data);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _isInputEnabled = false;
  late Map<String, String> _inputValues;
  late TextEditingController _nameController;
  late TextEditingController _chinese_nameController;
  late TextEditingController _english_nameController;
  late TextEditingController _brandController;
  late TextEditingController _signedController;
  late TextEditingController _industry_model_idController;
  late TextEditingController _phoneController;
  late TextEditingController _telephoneController;
  late TextEditingController _registerdateController;
  late TextEditingController _registerfundController;
  late TextEditingController _credit_codeController;
  late TextEditingController _typeController;
  late TextEditingController _acreageController;
  late TextEditingController _unauthorized_appearance_patentController;
  late TextEditingController _appearance_patent_grantedController;
  late TextEditingController _unauthorized_invention_patentController;
  late TextEditingController _authorize_patent_countController;
  late TextEditingController _not_authorize_patent_countController;
  late TextEditingController _authorize_new_patent_countController;
  late TextEditingController _register_bookmaking_countController;
  late TextEditingController _apply_bookmaking_countController;
  late TextEditingController _aptitude_stateController;
  late TextEditingController _business_licenceController;
  late TextEditingController _scaleController;
  late TextEditingController _hightechController;
  late TextEditingController _trademark_cntController;
  late TextEditingController _ms_enterprisesController;
  late TextEditingController _enrolladdressController;
  late TextEditingController _business_licence_codeController;

  bool _dataLoaded = false; // 新增数据加载标志位
  @override
  void initState() {
    super.initState();
    fetchData();
    Quanju.dd = widget.data;
    _inputValues = {
      'name': '',
      'chinese_name': '',
      'english_name': '',
      'brand': '',
      'signed': '',
      'industry_model_id': '',
      'phone': '',
      'telephone': '',
      'registerdate': '',

      'registerfund': '',
      'credit_code': '',
      'type': '',
      'acreage': '',
      'unauthorized_appearance_patent': '',
      'appearance_patent_granted': '',
      'unauthorized_invention_patent': '',
      'authorize_patent_count': '',
      'not_authorize_patent_count': '',
      'authorize_new_patent_count': '',
      'register_bookmaking_count': '',
      'apply_bookmaking_count': '',
      'aptitude_state': '',
      'business_licence': '',
      'scale': '',
      'hightech': '',
      'trademark_cnt': '',
      'ms_enterprises': '',
      'enrolladdress': '',
      'business_licence_code': '',

      // Add more input fields with their default values here
    };
    _nameController = TextEditingController(text: _inputValues['name']);
    _chinese_nameController =
        TextEditingController(text: _inputValues['chinese_name']);
    _english_nameController =
        TextEditingController(text: _inputValues['english_name']);
    _brandController = TextEditingController(text: _inputValues['brand']);
    _signedController = TextEditingController(text: _inputValues['signed']);
    _industry_model_idController =
        TextEditingController(text: _inputValues['industry_model_id']);
    _phoneController = TextEditingController(text: _inputValues['phone']);
    _telephoneController =
        TextEditingController(text: _inputValues['telephone']);
    _registerdateController =
        TextEditingController(text: _inputValues['registerdate']);
    _registerfundController =
        TextEditingController(text: _inputValues['registerfund']);
    _credit_codeController =
        TextEditingController(text: _inputValues['credit_code']);
    _typeController = TextEditingController(text: _inputValues['type']);
    _acreageController = TextEditingController(text: _inputValues['acreage']);
    _unauthorized_appearance_patentController = TextEditingController(
        text: _inputValues['unauthorized_appearance_patent']);
    _appearance_patent_grantedController =
        TextEditingController(text: _inputValues['appearance_patent_granted']);
    _unauthorized_invention_patentController = TextEditingController(
        text: _inputValues['unauthorized_invention_patent']);
    _authorize_patent_countController =
        TextEditingController(text: _inputValues['authorize_patent_count']);
    _not_authorize_patent_countController =
        TextEditingController(text: _inputValues['not_authorize_patent_count']);
    _authorize_new_patent_countController =
        TextEditingController(text: _inputValues['authorize_new_patent_count']);
    _register_bookmaking_countController =
        TextEditingController(text: _inputValues['register_bookmaking_count']);
    _apply_bookmaking_countController =
        TextEditingController(text: _inputValues['apply_bookmaking_count']);
    _aptitude_stateController =
        TextEditingController(text: _inputValues['aptitude_state']);
    _business_licenceController =
        TextEditingController(text: _inputValues['business_licence']);
    _scaleController = TextEditingController(text: _inputValues['scale']);
    _hightechController = TextEditingController(text: _inputValues['hightech']);
    _trademark_cntController =
        TextEditingController(text: _inputValues['trademark_cnt']);
    _ms_enterprisesController =
        TextEditingController(text: _inputValues['ms_enterprises']);
    _enrolladdressController =
        TextEditingController(text: _inputValues['enrolladdress']);
    _business_licence_codeController =
        TextEditingController(text: _inputValues['business_licence_code']);
  }

  Future<void> fetchData() async {
    final url = Uri.http('8.141.86.125', '/patent-app/company.php');
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
        _inputValues['chinese_name'] = dd[0]['chinese_name']; // 确保在获取数据后更新状态
        _inputValues['english_name'] = dd[0]['english_name'];
        _inputValues['brand'] = dd[0]['brand'];
        _inputValues['signed'] = dd[0]['signed'];
        _inputValues['industry_model_id'] = dd[0]['industry_model_id'];
        _inputValues['phone'] = dd[0]['phone'];
        _inputValues['telephone'] = dd[0]['telephone'];
        _inputValues['registerdate'] = dd[0]['registerdate'];
        _inputValues['registerfund'] = dd[0]['registerfund'];
        _inputValues['credit_code'] = dd[0]['credit_code'];
        _inputValues['type'] = dd[0]['type'];
        _inputValues['acreage'] = dd[0]['acreage'];
        _inputValues['unauthorized_appearance_patent'] =
            dd[0]['unauthorized_appearance_patent'];
        _inputValues['appearance_patent_granted'] =
            dd[0]['appearance_patent_granted'];
        _inputValues['unauthorized_invention_patent'] =
            dd[0]['unauthorized_invention_patent'];
        _inputValues['authorize_patent_count'] =
            dd[0]['authorize_patent_count'];
        _inputValues['not_authorize_patent_count'] =
            dd[0]['not_authorize_patent_count'];
        _inputValues['authorize_new_patent_count'] =
            dd[0]['authorize_new_patent_count'];
        _inputValues['register_bookmaking_count'] =
            dd[0]['register_bookmaking_count'];
        _inputValues['apply_bookmaking_count'] =
            dd[0]['apply_bookmaking_count'];
        _inputValues['aptitude_state'] = dd[0]['aptitude_state'];
        _inputValues['business_licence'] = dd[0]['business_licence'];
        _inputValues['scale'] = dd[0]['scale'];
        _inputValues['hightech'] = dd[0]['hightech'];
        _inputValues['trademark_cnt'] = dd[0]['trademark_cnt'];
        _inputValues['ms_enterprises'] = dd[0]['ms_enterprises'];
        _inputValues['enrolladdress'] = dd[0]['enrolladdress'];
        _inputValues['business_licence_code'] = dd[0]['business_licence_code'];
        _dataLoaded = true;
      });
      _nameController.text = _inputValues['name']!; // 更新文本框的值
      _chinese_nameController.text = _inputValues['chinese_name']!;
      _english_nameController.text = _inputValues['english_name']!;
      _brandController.text = _inputValues['brand']!;
      _signedController.text = _inputValues['signed']!;
      _industry_model_idController.text = _inputValues['industry_model_id']!;
      _phoneController.text = _inputValues['phone']!;
      _telephoneController.text = _inputValues['telephone']!;
      _registerdateController.text = _inputValues['registerdate']!;
      _registerfundController.text = _inputValues['registerfund']!;
      _credit_codeController.text = _inputValues['credit_code']!;
      _typeController.text = _inputValues['type']!;
      _acreageController.text = _inputValues['acreage']!;
      _unauthorized_appearance_patentController.text =
          _inputValues['unauthorized_appearance_patent']!;
      _appearance_patent_grantedController.text =
          _inputValues['appearance_patent_granted']!;
      _unauthorized_invention_patentController.text =
          _inputValues['unauthorized_invention_patent']!;
      _authorize_patent_countController.text =
          _inputValues['authorize_patent_count']!;
      _not_authorize_patent_countController.text =
          _inputValues['not_authorize_patent_count']!;
      _authorize_new_patent_countController.text =
          _inputValues['authorize_new_patent_count']!;
      _register_bookmaking_countController.text =
          _inputValues['register_bookmaking_count']!;
      _apply_bookmaking_countController.text =
          _inputValues['apply_bookmaking_count']!;
      _aptitude_stateController.text = _inputValues['aptitude_state']!;
      _business_licenceController.text = _inputValues['business_licence']!;
      _scaleController.text = _inputValues['scale']!;
      _hightechController.text = _inputValues['hightech']!;
      _trademark_cntController.text = _inputValues['trademark_cnt']!;
      _ms_enterprisesController.text = _inputValues['ms_enterprises']!;
      _enrolladdressController.text = _inputValues['enrolladdress']!;
      _business_licence_codeController.text =
          _inputValues['business_licence_code']!;
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
    final url = Uri.http('8.141.86.125', '/patent-app/edit.php');
    final response = await http.post(
      url,
      body: {
        'name': _inputValues['name'],
        'chinese_name': _inputValues['chinese_name'],
        'english_name': _inputValues['english_name'],
        'brand': _inputValues['brand'],
        'signed': _inputValues['signed'],
        'industry_model_id': _inputValues['industry_model_id'],
        'phone': _inputValues['phone'],
        'telephone': _inputValues['telephone'],
        'registerdate': _inputValues['registerdate'],
        'registerfund': _inputValues['registerfund'],
        'credit_code': _inputValues['credit_code'],
        'type': _inputValues['type'],
        'acreage': _inputValues['acreage'],
        'business_licence': _inputValues['business_licence'],
        'scale': _inputValues['scale'],
        'hightech': _inputValues['hightech'],
        'ms_enterprises': _inputValues['ms_enterprises'],
        'enrolladdress': _inputValues['enrolladdress'],
        'business_licence_code': _inputValues['business_licence_code'],
      },
    );
    if (response.statusCode == 200) {
      print(
        _inputValues['chinese_name'],
      );
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
              label: '公司名称:',
              value: '${_inputValues["name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '中文简称:',
              value: '${_inputValues["chinese_name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '英文简称:',
              value: '${_inputValues["english_name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '商标:',
              value: '${_inputValues["brand"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '签约:',
              value: '${_inputValues["signed"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '行业:',
              value: '${_inputValues["industry_model_id"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '电话号码:',
              value: '${_inputValues["phone"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '手机号码:',
              value: '${_inputValues["telephone"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '注册日期:',
              value: '${_inputValues["registerdate"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '注册区域:',
              value: '${_inputValues["name"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '注册资金:',
              value: '${_inputValues["registerfund"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '统一信用代码:',
              value: '${_inputValues["credit_code"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '企业性质:',
              value: '${_inputValues["type"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '办公面积:',
              value: '${_inputValues["acreage"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '未授权外观专利:',
              value: '${_inputValues["unauthorized_appearance_patent"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '已授权外观专利:',
              value: '${_inputValues["appearance_patent_granted"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '未授权发明专利:',
              value: '${_inputValues["unauthorized_invention_patent"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '已授权发明专利:',
              value: '${_inputValues["authorize_patent_count"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '未授权实用新型专利:',
              value: '${_inputValues["not_authorize_patent_count"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '已授权实用新型专利:',
              value: '${_inputValues["authorize_new_patent_count"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '已登记软件著作权:',
              value: '${_inputValues["register_bookmaking_count"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '已申请软件著作权:',
              value: '${_inputValues["apply_bookmaking_count"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '知识产权贯标:',
              value: '${_inputValues["aptitude_state"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '营业执照副本:',
              value: '${_inputValues["business_licence"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '员工数:',
              value: '${_inputValues["scale"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '高新企业:',
              value: '${_inputValues["hightech"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '注册商标数:',
              value: '${_inputValues["trademark_cnt"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '中小微企业:',
              value: '${_inputValues["ms_enterprises"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '注册地址:',
              value: '${_inputValues["enrolladdress"]}',
            ),
            SizedBox(height: 10),
            ScrollableRow(
              label: '营业执照号:',
              value: '${_inputValues["business_licence_code"]}',
            ),
          ],
          if (_isInputEnabled) ...[
            SizedBox(height: 16),
            TextInputField(
              controller: _nameController,
              field: 'name',
              labelText: '公司名称',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _chinese_nameController,
              field: 'chinese_name',
              labelText: '中文简称',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _english_nameController,
              field: 'english_name',
              labelText: '英文简称',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _brandController,
              field: 'brand',
              labelText: '商标',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _signedController,
              field: 'signed',
              labelText: '签约',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _industry_model_idController,
              field: 'industry_model_id',
              labelText: '行业',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _phoneController,
              field: 'phone',
              labelText: '电话号码',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _telephoneController,
              field: 'telephone',
              labelText: '手机号码',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _registerdateController,
              field: 'registerdate',
              labelText: '注册日期',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _registerfundController,
              field: 'english_name',
              labelText: '注册资金',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _credit_codeController,
              field: 'credit_code',
              labelText: '统一信用代码',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _typeController,
              field: 'type',
              labelText: '企业性质',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _acreageController,
              field: 'acreage',
              labelText: '办公面积',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _business_licenceController,
              field: 'business_licence',
              labelText: '营业执照副本',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _scaleController,
              field: 'scale',
              labelText: '员工数',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _hightechController,
              field: 'hightech',
              labelText: '高新企业',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _ms_enterprisesController,
              field: 'ms_enterprises',
              labelText: '中小微企业',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _enrolladdressController,
              field: 'enrolladdress',
              labelText: '注册地址',
              onUpdate: _updateValue,
            ),
            TextInputField(
              controller: _business_licence_codeController,
              field: 'business_licence_code',
              labelText: '营业执照号',
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
    return Container(
      color: Colors.black12, // 设置背景颜色
      height: 60, // 设置高度
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              SizedBox(width: 10), // 添加一些间距
              if (label == '商标:')
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Image.network(
                          'http://8.141.86.125/patent-app/' + value,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    'http://8.141.86.125/patent-app/' + value,
                    width: 40,
                    height: 100,
                  ),
                ),
              if (label != '商标:')
                Text(
                  value,
                  style: TextStyle(fontSize: 19, color: Colors.black87),
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

class TextInputField extends StatefulWidget {
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
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  String imageUrl = '';

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
    request.fields['name'] = Quanju.dd;
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: 'image.jpg',
    ));
    final response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: '上传成功');
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
              onChanged: (value) => widget.onUpdate(widget.field, value),
              decoration: InputDecoration(
                labelText: widget.labelText,
              ),
              readOnly: isReadOnly,
            ),
          ),
          if (widget.field == 'business_licence' || widget.field == 'brand')
            IconButton(
              onPressed: _uploadImage,
              icon: Icon(Icons.upload_file),
            ),
        ],
      ),
    );
  }
}
