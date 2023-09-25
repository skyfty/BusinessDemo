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
        '192.168.33 .217:8081','/php/PHP/business/login.php',
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
        globalAge = responseData['age'];
        globalSex = responseData['sex'];
        globalJob = responseData['job'];
        globalArea = responseData['area'];
        globalPhone = responseData['phone'];
        globalSig = responseData['sig'];
        print('登录成功');
        Fluttertoast.showToast(msg: responseData['message']);
        print(response.body);
        print(responseData['message']);
        print(responseData['name']);
        print(responseData['age']);
        print(responseData['job']);
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













// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:business/main.dart';
// import 'dart:convert';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _smsCodeController = TextEditingController();
//
//   int _countDown = 0;
//    Timer? _timer;
//
//   void _startCountDown() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(oneSec, (Timer timer) {
//       setState(() {
//         if (_countDown <= 0) {
//           _timer?.cancel();
//         } else {
//           _countDown--;
//         }
//       });
//     });
//   }
//
//   void _getSmsCode() {
//     // TODO: 实现获取短信验证码逻辑
//
//     // 模拟获取短信验证码，倒计时60秒
//     _countDown = 60;
//     _startCountDown();
//   }
//
//   void _loginWithPhone(BuildContext context) {
//     // TODO: 实现手机号登录逻辑
//     String phone = _phoneController.text;
//     String smsCode = _smsCodeController.text;
//
//     // 进行手机号和短信验证码登录逻辑处理
//     // ...
//
//     // 登录成功后跳转到下一个页面
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => BottomNavigationDemo()));
//     // Navigator.pushReplacementNamed(context, '/home');
//   }
//
//   void _loginWithWeChat(BuildContext context) {
//     // TODO: 实现微信授权登录逻辑
//     // 调用微信授权登录接口
//     // ...
//
//     // 登录成功后跳转到下一个页面
//     Navigator.pushReplacementNamed(context, '/home');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//
//         '/home': (context) => BottomNavigationDemo(),
//       },
//       home: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 200.0),
//               TextField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(labelText: '手机号'),
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _smsCodeController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(labelText: '短信验证码'),
//                     ),
//                   ),
//                   SizedBox(width: 8.0),
//                   _countDown > 0
//                       ? Text('$_countDown 秒后重新获取')
//                       : ElevatedButton(
//                     onPressed: _getSmsCode,
//                     child: Text('获取验证码'),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               SizedBox(
//                 width: 280, // 设置按钮的宽度
//                 height: 40,
//                 child: ElevatedButton(
//                   onPressed: () => _loginWithPhone(context),
//                   child: Text('登录'),
//                 ),
//               ),
//               SizedBox(height: 200.0),
//               SizedBox(
//                 width: 160,
//                 child: ElevatedButton(
//                   onPressed: () => _loginWithWeChat(context),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0), // 设置圆角半径
//                     ),
//                     primary: Colors.white, // 设置按钮背景色
//                     onPrimary: Colors.blue, // 设置按钮文字颜色
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 30,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.green, // 可根据实际情况修改颜色
//                         ),
//                         child: Icon(
//                           Icons.favorite, // 可替换为微信图标
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(width: 8.0),
//                       Text('微信快捷登录'),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
