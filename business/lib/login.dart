import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:business/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
String globalName = '';
int globalAge = 0;
String globalSex = '';
String globalJob = '';
String globalArea = '';
String globalPhone = '';
String globalSig = '';
int globalId = 0;
class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String username = _usernameController.text;
    // String password = _passwordController.text;

    // 向后端接口发送登录请求
    var url = Uri.http(
        '192.168.33.217:8081','/php/PHP/business/login.php',
      // '8.141.86.125',
      // '/login.php',
    );

    final response = await http.post(
      url,
      body: {
        'phone': username,
        // 'password': password,

      },
    );
    // 处理登录结果
    if (response.statusCode == 200) {
      // 登录成功
      // 在此处处理后端返回的登录结果，根据实际情况执行相应的操作
     Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData['name']);
      if(responseData['status'] == 'success'){
        // 登录成功，实例化UserModel并传递数据
        globalName =  responseData['name'];
        globalId = responseData['id'];
        // globalAge = responseData['age'];
        // globalSex = responseData['sex'];
        // globalJob = responseData['job'];
        // globalArea = responseData['area'];
        globalPhone = responseData['phone'];
        // globalSig = responseData['sig'];
        print('登录成功');
        Fluttertoast.showToast(msg: responseData['message']);
        print(response.body);
        // print(responseData['message']);
        print(responseData['name']);
        // print(responseData['age']);
        // print(responseData['job']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationDemo()),
        );

      }else {
        Fluttertoast.showToast(msg: responseData['message']);
        print(response.body);
        print('登录失败');
      }
    } else {
      // 登录失败
      // 在此处处理后端返回的登录失败信息，根据实际情况执行相应的操作
      Map<String, dynamic> responseData = json.decode(response.body);
      Fluttertoast.showToast(msg: '网络错误');
      print('请求失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '账号'),
            ),
            SizedBox(height: 16.0),

            // SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
String getGlobalName() {
  return globalName; // 返回全局变量的值
}
int getGlobalAge() {
  return globalAge;
}

String getGlobalJob() {
  return globalJob;
}
String getGlobalPhone() {
  return globalPhone;
}
String getGlobalArea() {
  return globalArea;
}
String getGlobalSig() {
  return globalSig;
}
String getGlobalSex() {
  return globalSex;
}
int getGlobalId() {
  return globalId;
}
void updateGlobalVariables(String name, int age,String area,String sig,) {
  globalName = name;
  globalAge = age;
  globalSig = sig;
  globalArea = area;
}













