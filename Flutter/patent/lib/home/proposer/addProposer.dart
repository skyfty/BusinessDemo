import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyGlobals {
  static String RR = '';
  static String idType = '';
  static String beiAnNumber = '';
}

class AddProposer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _AddProposerState();
  }
}

class _AddProposerState extends StatefulWidget {
  @override
  __AddProposerStateState createState() => __AddProposerStateState();
}

class __AddProposerStateState extends State<_AddProposerState> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController user_numberController = TextEditingController();
  final TextEditingController applicant_typeController =
      TextEditingController();
  final TextEditingController certificate_typeController =
      TextEditingController();
  final TextEditingController id_numberController = TextEditingController();
  final TextEditingController nationality_regionController =
      TextEditingController();
  final TextEditingController place_residenceController =
      TextEditingController();
  final TextEditingController provienceController = TextEditingController();

  final TextEditingController streetController = TextEditingController();
  final TextEditingController postal_codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController applicant_telephoneController =
      TextEditingController();
  final TextEditingController fee_reduction_requestController =
      TextEditingController();
  final TextEditingController pre_examination_recordController =
      TextEditingController();
  final TextEditingController general_committee_recordController =
      TextEditingController();
  final TextEditingController business_licenseController =
      TextEditingController();
  String? filePath;
  void _submitChanges() async {
    final url =
        Uri.http('8.141.86.125', '/patent-app/index/applicant/proposerAdd.php');
    final response = await http.post(
      url,
      body: {
        'name': nameController.text,
        'english_name': englishNameController.text,
        'user_number': user_numberController.text,
        'applicant_type': applicant_typeController.text,
        'certificate_type': certificate_typeController.text,
        'id_number': id_numberController.text,
        'nationality_region': nationality_regionController.text,
        'place_residence': place_residenceController.text,
        'provience': provienceController.text,
        'street': streetController.text,
        'postal_code': postal_codeController.text,
        'email': emailController.text,
        'applicant_telephone': applicant_telephoneController.text,
        'fee_reduction_request': fee_reduction_requestController.text,
        'pre_examination_record': pre_examination_recordController.text,
        'general_committee_record': general_committee_recordController.text,
        'business_license': business_licenseController.text,
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] == '添加成功') {
        Fluttertoast.showToast(msg: data['success']);
      } else {
        Fluttertoast.showToast(msg: data['error']);
      }

      print('Changes submitted successfully.');
    } else {
      print('Failed to submit changes. Status code: ${response.statusCode}.');
    }
  }

  __AddProposerStateState() {
    nameController.addListener(() {
      MyGlobals.RR = nameController.text;
    });

    certificate_typeController.addListener(() {
      MyGlobals.idType = certificate_typeController.text;
    });
    general_committee_recordController.addListener(() {
      MyGlobals.beiAnNumber = general_committee_recordController.text;
    });
  }
  String? selectedValue; // 用户选择的值
  Map<String, List<DropdownMenuItem<String>>> dropdownOptions = {
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
  };
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> options = dropdownOptions['总委备案']!;
    return Scaffold(
      appBar: AppBar(
        title: Text('添加申请人', style: TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          Container(
            height: 150,
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'user_number',
                      labelText: '用户编号',
                      controller: user_numberController,
                      prefixIcon: Icons.format_list_numbered,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'applicant_type',
                      labelText: '申请人类型',
                      controller: applicant_typeController,
                      prefixIcon: Icons.class_,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'certificate_type',
                      labelText: '证件类型',
                      controller: certificate_typeController,
                      prefixIcon: Icons.add_card_rounded,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'id_number',
                      labelText: '证件号码',
                      controller: id_numberController,
                      prefixIcon: Icons.sd_card,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'nationality_region',
                      labelText: '国籍/地区',
                      controller: nationality_regionController,
                      prefixIcon: Icons.roofing,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'place_residence',
                      labelText: '住所',
                      controller: place_residenceController,
                      prefixIcon: Icons.maps_home_work_rounded,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'provience',
                      labelText: '省份',
                      controller: provienceController,
                      prefixIcon: Icons.safety_check_outlined,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'street',
                      labelText: '街道',
                      controller: streetController,
                      prefixIcon: Icons.maps_home_work_rounded,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'postal_code',
                      labelText: '邮政编码',
                      controller: postal_codeController,
                      prefixIcon: Icons.confirmation_number_outlined,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'email',
                      labelText: '电子邮箱',
                      controller: emailController,
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'applicant_telephone',
                      labelText: '申请人电话',
                      controller: applicant_telephoneController,
                      prefixIcon: Icons.phone_iphone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'fee_reduction_request',
                      labelText: '减缓费用请求',
                      controller: fee_reduction_requestController,
                      prefixIcon: Icons.local_atm,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                      field: 'pre_examination_record',
                      labelText: '预审备案',
                      controller: pre_examination_recordController,
                      prefixIcon: Icons.confirmation_number_outlined,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 250,
            child: Card(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                general_committee_recordController.text =
                                    value ?? ''; // 更新controller的值
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                              labelText: '总委备案',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 63, 93, 80),
                              ),
                              prefixIcon: Icon(
                                Icons.pix,
                                color: Color.fromARGB(255, 63, 93, 80),
                              ),
                            ),
                            items: options,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (selectedValue == '是')
                      Row(
                        children: [
                          // SizedBox(height: 50,),
                          Expanded(
                            child: TextField(
                              controller: pre_examination_recordController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                ),
                                labelText: '备案号',
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 63, 93, 80),
                                ),
                                hintText: "请输入备案号",
                                prefixIcon: Icon(
                                  Icons.pix,
                                  color: Color.fromARGB(255, 63, 93, 80),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
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
  final String field; //字段
  final String labelText; //标签
  final TextEditingController controller; //控制器
  final IconData prefixIcon; // 前缀图标

  TextInputField({
    required this.field,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
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
      // 添加其他选项
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
      // 添加其他选项
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
      // 添加其他选项
    ],
    '国籍/地区': [
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
                              MyGlobals.idType == '身份证' && //判断证件类型
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
                onChanged: (value) {
                  setState(() {
                    if (widget.field == 'id_number' &&
                        (widget.controller.text.length < 11 ||
                            widget.controller.text.length > 11) &&
                        widget.controller.text.length == 18 &&
                        widget.controller.text != '请输入18位身份证号码') {
                      widget.controller.text = value.substring(0, 18);
                    } else if (widget.field == 'applicant_telephone' &&
                        (widget.controller.text.length < 11 ||
                            widget.controller.text.length > 11)) {
                      widget.controller.text = value.substring(0, 11);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

//总委备案
class TextInputFields extends StatefulWidget {
  final String field; //字段
  final String labelText; //标签
  final TextEditingController controller; //控制器
  final IconData prefixIcon; // 前缀图标

  TextInputFields({
    required this.field,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
  });

  @override
  _TextInputFieldsState createState() => _TextInputFieldsState();
}

class _TextInputFieldsState extends State<TextInputFields> {
  String? selectedValue; // 用户选择的值

  Map<String, List<DropdownMenuItem<String>>> dropdownOptions = {
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
  };

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> options = dropdownOptions[widget.labelText]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      widget.controller.text = value ?? ''; // 更新controller的值
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
          SizedBox(
            height: 30,
          ),
          if (widget.labelText == '总委备案' && selectedValue == '是')
            Row(
              children: [
                // SizedBox(height: 50,),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    cursorColor: Colors.black,
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
                    onChanged: (value) {
                      setState(() {
                        // 清除错误提示信息
                        print(2222);
                        print(MyGlobals.idType);
                        if (widget.field == 'id_number' &&
                            (widget.controller.text.length < 11 ||
                                widget.controller.text.length > 11) &&
                            widget.controller.text.length == 18 &&
                            widget.controller.text != '请输入18位身份证号码') {
                          widget.controller.text = value.substring(0, 18);
                        } else if (widget.field == 'applicant_telephone' &&
                            (widget.controller.text.length < 11 ||
                                widget.controller.text.length > 11)) {
                          widget.controller.text = value.substring(0, 11);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class Fujian extends StatefulWidget {
  final String field; //字段
  final String labelText; //标签
  final TextEditingController controller; //控制器

  Fujian({
    required this.field,
    required this.labelText,
    required this.controller,
  });

  @override
  _FujianState createState() => _FujianState();
}

class _FujianState extends State<Fujian> {
  String imageUrl = '';

  void _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageFile = await pickedImage.readAsBytes();
      final response = await uploadImage(pickedImageFile);
      if (response != null && response.containsKey('name')) {
        final uploadedImageUrl =
            'http://8.141.86.125/patent-app/${response['name']}'; //图片地址
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
    request.fields['name'] = MyGlobals.RR;
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero, // 设置边框为非圆角
                    ),
                    labelText: widget.labelText,
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
                if (imageUrl.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: Container(
                              child: Image.network(imageUrl),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.image),
                    ),
                  ),
              ],
            ),
          ),
          if (widget.field == 'business_licence' ||
              widget.field == 'brand' ||
              widget.field == 'business_license')
            IconButton(
              onPressed: _uploadImage,
              icon: Icon(Icons.upload_file),
            ),
        ],
      ),
    );
  }
}
