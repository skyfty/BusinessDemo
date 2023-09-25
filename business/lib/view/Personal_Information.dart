import 'package:flutter/material.dart';
import 'package:business/view/PersonalSecondary/businesspage.dart';
import 'package:business/view/PersonalSecondary/medalpage.dart';
import 'package:business/view/PersonalSecondary/onjobpage.dart';
import 'package:business/view/PersonalSecondary/personal_infopage.dart';
import 'package:business/view/PersonalSecondary/setup/setup.dart';
import 'package:business/login.dart';
class Personal_Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        primaryColor: Colors.green[700], // 主题颜色设为绿色
        hintColor: Colors.greenAccent, // 按钮颜色设为浅蓝色
      ),
      routes: {
        '/login': (context) => LoginPage(), //登录页面
        '/business': (context) => BusinessPage(), //业务页面
        '/onJob': (context) => OnJobPage(), //在职页面
        '/medal': (context) => MedalPage(), //勋章页面
        '/personalInfo': (context) => PersonalInfoPage(), //个人资料页面
        '/setup': (context) => Setuppage(),
      },
      home: Scaffold(

        body: ListView(
          children: [
            const SizedBox(height: 50),
            RowComponent(),
            const SizedBox(height: 20),
            RowComponents(),
            const SizedBox(height: 10),
            PersonalInformationPage(),
            const SizedBox(height: 10),
            Agreement(),//协议
            const SizedBox(height: 10),
            Finance(),
            const SizedBox(height: 10),
            SetUp(),
            // Add more RowComponent widgets as needed
          ],
        ),
      ),
    );
  }
}

class RowComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = getGlobalName();
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            child: Container(

              width: 100, // 正方形的宽度
              height: 100, // 正方形的高度
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10), // 设置圆角弧度为10
                image: DecorationImage(
                  image: AssetImage('assets/4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          SizedBox(width: 10),
          GestureDetector(
            child: Text(
              '$name',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

class RowComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: GridView.count(
        crossAxisCount: 3, // 一行有三个框
        shrinkWrap: true, // 设置为true来避免滚动冲突
        physics: NeverScrollableScrollPhysics(), // 禁用滚动
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/business');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.business,
                      size: 30,
                      color: Colors.black45,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '业务',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                    SizedBox(height: 3),
                    Text('10/123',style: TextStyle(fontSize:13,color: Colors.black45),),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/onJob');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.work,
                      size: 30,
                      color: Colors.black45,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '在职',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                    SizedBox(height: 3),
                    Text('323天',style: TextStyle(fontSize: 13,color: Colors.black45),)
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/medal');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.black45,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '勋章',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                    SizedBox(height: 3),
                    Text('33',style: TextStyle(fontSize: 13,color: Colors.black45),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//person
class PersonalInformationPage extends StatelessWidget {
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
                  Icons.person,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '个人资料',
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
//description
class Agreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/medal');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '协议',
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
//attach_money
class Finance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/medal');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '财务',
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

class SetUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white, // 添加背景颜色
      child: InkWell(
        onTap: () {
          // 点击设置跳转到新的页面
          Navigator.pushNamed(context, '/setup');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.black45,
                ),
                SizedBox(width: 10),
                Text(
                  '设置',
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

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录界面'),
      ),
      body: Center(
        child: Text('这是登录界面'),
      ),
    );
  }
}








