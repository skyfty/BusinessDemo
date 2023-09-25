import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business/view/communicate.dart';
import 'package:business/view/Personal_Information.dart';
import 'package:business/view/function.dart';
import 'package:business/view/home_page.dart';
// dart类
import 'package:business/login.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_volume_controller/flutter_volume_controller.dart';

class AndroidBackDesktop{

  //通讯名称，回到手机桌面
  static const String CHANNEL = "android/back/desktop";
  //设置回退到手机桌面事件
  static const String eventBackDesktop = "backDesktop";

  //设置回退到手机桌面方法
  static Future<bool> backToDesktop() async {
    final platform = MethodChannel(CHANNEL);
    //通知安卓返回到手机桌面
    try{
      await platform.invokeMethod(eventBackDesktop);
      print("通信成功");
    }
    on PlatformException catch (e){
      print("通信失败，设置回退到安卓手机桌面失败");
      print(e.toString());
    }
    return Future.value(false);
  }
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 注册flutter_volume_controller插件
  //FlutterVolumeController.register();
  runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: SplashScreen(),
        );

  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(), //BottomNavigationDemo(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/FFF.png',
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Home_pages(),
    Communication(),
    Function_file(),
    Personal_Information(),
  ];

  @override
  void initState() {
    super.initState();
    _loadLastPageIndex();
  }

  _loadLastPageIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastPageIndex = prefs.getInt('last_page_index') ?? 0;
    setState(() {
      _currentIndex = lastPageIndex;
    });
  }

  _saveLastPageIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('last_page_index', index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 拦截返回按钮事件
        // 在这里你可以添加应用程序挂起到后台的逻辑
        // 例如，将应用程序移动到后台
        print('返回取消');
        AndroidBackDesktop.backToDesktop();
        _saveLastPageIndex(_currentIndex); // 保存当前页面索引
        //await SystemNavigator.pop();
        print('返回取消');
        return false; // 返回false表示取消返回操作

      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '业务',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sms),
              label: '消息',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '资讯',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
