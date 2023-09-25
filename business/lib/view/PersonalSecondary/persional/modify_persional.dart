import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:business/login.dart';
import 'package:business/login.dart';
class Modifiy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserProfilePage();
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}


class _UserProfilePageState extends State<UserProfilePage> {
  int _id = getGlobalId();
  String _name = getGlobalName();
  int _age = getGlobalAge();
  String _sex = getGlobalSex();
  String _area = getGlobalArea();
  String _sig = getGlobalSig();
  String _position = '';
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _sigController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  void _updateUserProfile() async {
    // 这里替换成您的后端接口地址

    var url = Uri.http(
        // '192.168.33.217:8081', 'php/PHP/modify.php'
      '8.141.86.125',
      '/info.php',
    );
    final response = await http.post(
      url,
      // headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': _name,
        'sex': _sex,
        'age': _age.toString(),
        'job': _position,
        'area': _area,
        'sig': _sig,
        'id': _id.toString(),



      },
    );

    if (response.statusCode == 200) {
      print('请求成功');
      print(response.body);
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['message'] == "修改成功") {
        Fluttertoast.showToast(msg: responseData['message']);
        print(response.body);
        print("修改成功");
      } else {
        Fluttertoast.showToast(msg: responseData['message']);
        print("修改失败");
      }
    } else {
      print('请求失败');
      Fluttertoast.showToast(msg: '请求失败');
    }
  }
  @override
  void initState() {
    super.initState();

    // 设置文本输入框的默认值
    _nameController.text = _name;
    _sexController.text = _sex;
    _ageController.text = _age.toString();
    _positionController.text = _position;
    _areaController.text = _area;
    _sigController.text = _sig;
  }

  @override
  Widget build(BuildContext context) {
    updateGlobalVariables(_name,_age,_area,_sig,);
    return Scaffold(
      appBar: AppBar(
        title: Text('修改个人资料'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '姓名'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },

              ),
              SizedBox(height: 10),
              TextField(
                controller: _sexController,
                decoration: InputDecoration(labelText: '性别'),
                onChanged: (value) {
                  setState(() {
                    _sex = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: '年龄'),
                onChanged: (value) {
                  setState(() {
                    _age = int.tryParse(value) ?? 0;
                  });
                },
              ),
              // SizedBox(height: 10),
              // TextField(
              //   controller: _positionController,
              //   decoration: InputDecoration(labelText: '职务'),
              //   onChanged: (value) {
              //     setState(() {
              //       _position = value;
              //     });
              //   },
              // ),
              SizedBox(height: 10),
              TextField(
                controller: _areaController,
                decoration: InputDecoration(labelText: '地区'),
                onChanged: (value) {
                  setState(() {
                    _area = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _sigController,
                decoration: InputDecoration(labelText: '个性签名'),
                onChanged: (value) {
                  setState(() {
                    _sig = value;
                  });
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateUserProfile();
                },
                child: Text('保存'),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

