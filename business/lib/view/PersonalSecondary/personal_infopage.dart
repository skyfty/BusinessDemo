import 'package:flutter/material.dart';
import 'package:business/login.dart';
import 'package:business/view/PersonalSecondary/persional/modify_persional.dart';

class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = getGlobalName();
    int age = getGlobalAge(); // Get the value of globalAge
    String job = getGlobalJob(); // Get the value of globalJob
    String phone = getGlobalPhone();
    String area = getGlobalArea();
    String sig = getGlobalSig();
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.badge,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '姓名: $name',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.agriculture,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '年龄: $age',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.room,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '地区: $area',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder_special,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '个性签名: $sig',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone_iphone,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '联系方式: $phone',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              child: InkWell(
                onTap: () {
                  // 点击设置跳转到新的页面
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Modifiy(), //BottomNavigationDemo(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '编写个人资料',
                          style: TextStyle(fontSize: 20, color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}



