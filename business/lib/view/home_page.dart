import 'package:flutter/material.dart';
import 'package:business/view/HomePage/emergent.dart';
import 'package:business/view/HomePage/work.dart';
class Home_pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[700], // 主题颜色设为绿色
        hintColor: Colors.greenAccent, // 按钮颜色设为浅蓝色
      ),
      routes: {
        // '/login': (context) => LoginPage(), //登录页面
      },
      home: Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 30),
            Emergent(),
            const SizedBox(height: 10),
            SameAs(),
            const SizedBox(height: 10),
            Monitor(),
            const SizedBox(height: 10),
            ThatPerson(),
            const SizedBox(height: 10),
            // Add more RowComponent widgets as needed
          ],
        ),
      ),
    );
  }
}






class SameAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 4, // 阴影效果
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 圆角弧度
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            // width: 200,
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '一般',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black54
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务D跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LeaveApprovalComponent()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.grading, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务D',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务B跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.grading, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务E',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务C跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.grading, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务F',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Monitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 4, // 阴影效果
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 圆角弧度
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            // width: 200,
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '监控',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black54
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务A跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.devices, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务G',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务B跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.devices, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务H',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务C跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.devices, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务I',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThatPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 4, // 阴影效果
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 圆角弧度
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            // width: 200,
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '个人',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black54
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务A跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务J',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务B跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务K',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // 点击事务C跳转到新的页面
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, size: 30, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text(
                            '事务L',
                              style: TextStyle(
                                fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          size: 30, color: Colors.black45),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新页面'),
      ),
      body: Center(
        child: Text('这是新的页面'),
      ),
    );
  }
}


class ContractSubmissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('合同提交'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 合同相关输入框
            TextFormField(
              decoration: InputDecoration(labelText: '合同标题'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '合同内容'),
              maxLines: 5,
            ),
            // 提交按钮
            ElevatedButton(
              onPressed: () {
                // 在此处处理合同提交逻辑
              },
              child: Text('提交合同'),
            ),
          ],
        ),
      ),
    );
  }
}
