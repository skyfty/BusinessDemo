import 'package:flutter/material.dart';
import 'package:patent/subject/subject.dart'; //主体
import 'package:patent/subject/my.dart';
import 'package:patent/home/homePage/homePage.dart';
import 'package:patent/home/home.dart';
import 'package:patent/main.dart';
import 'package:patent/home/agentHome/agenthomepage.dart'; //代理人

class BottomNavigationDemo extends StatefulWidget {
  final String token;
  final String peopleType;

  BottomNavigationDemo({
    required this.token,
    required this.peopleType,
  });

  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget homePage;

    homePage = AlipayHomePage(
      token: widget.token,
      peopleType: widget.peopleType,
    );
    final List<Widget> _pages = [
      homePage,
      ExplorePage(),
      NotificationsPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '咨讯',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 90,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Principal()));
              },
              child: Container(
                height: 100, // 设置卡片的高度
                width: 140,

                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '企业主体',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => myfile()),
                );
              },
              child: Container(
                height: 100, // 设置卡片的高度
                width: 180, // 设置卡片的宽度
                child: Card(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '个人主体',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Explore Page'),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Page'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Profile Page'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              clearCacheAndNavigateToLoginScreen(context);
            },
            child: Text('退出登录'),
          ),
        ],
      ),
    );
  }

  void clearCacheAndNavigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
