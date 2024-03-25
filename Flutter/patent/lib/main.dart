import 'package:flutter/material.dart';
import 'package:patent/subject/subject.dart';
import 'package:patent/home/homeRoute.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(), //BottomNavigationDemo(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    final url = Uri.http('192.168.33.217:160', '/patent-app/login/login.php');
    final response = await http.post(
      url,
      body: {
        'phone': username,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      String token = jsonData['token'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationDemo(
            token: jsonData['token'],
            peopleType: jsonData['people_type'],
          ),
        ),
      );
    } else {
      print('请求失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center, // 将父级容器内容居中
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 将 Column 内容上下居中
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: '用户名'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: login,
                child: Text('登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
