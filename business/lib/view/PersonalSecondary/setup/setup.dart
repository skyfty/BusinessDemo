import 'package:flutter/material.dart';
import 'package:business/view/PersonalSecondary/setup/volume.dart';
import 'package:business/login.dart';
class Setuppage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[700], // 主题颜色设为绿色
        hintColor: Colors.greenAccent, // 按钮颜色设为浅蓝色
      ),
      routes: {
            '/personalInfo': (context) => VolumePage(),
            '/logout': (context) => LoginScreen(),
      },
      home: Scaffold(

        body: ListView(
          children: [
            const SizedBox(height: 70),
           Volume(),
            const SizedBox(height: 20),
            BeCurrent(),
            const SizedBox(height: 20),
            About(),
            const SizedBox(height: 20),
            Logout(),

            // Add more RowComponent widgets as needed
          ],
        ),
      ),
    );
  }
}



class Volume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/personalInfo');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.volume_down,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '调节音量',
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
class BeCurrent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/personalInfo');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.stay_current_portrait,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '通用',
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/personalInfo');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.manage_accounts,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '关于我们',
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/logout');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.manage_accounts,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '退出登录',
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}