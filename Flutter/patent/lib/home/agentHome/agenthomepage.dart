import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patent/home/homeRoute.dart';
import 'package:file_picker/file_picker.dart';

class AgentHomePage extends StatefulWidget {
  final String token;
  final String peopleType;

  AgentHomePage({required this.token, required this.peopleType});

  @override
  _AgentHomePageState createState() => _AgentHomePageState();
}

class _AgentHomePageState extends State<AgentHomePage> {
  List<dynamic> data = []; // 存储接口返回的数据
  List<dynamic> filteredData = []; // 存储符合搜索条件的数据
  TextEditingController searchController = TextEditingController();

  bool showPending = true; // 控制是否显示待确认数据
  bool showConfirmed = true; // 控制是否显示已确认数据

  @override
  void initState() {
    super.initState();
    fetchData(); // 在页面初始化时获取数据
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://192.168.33.217:160/patent-app/agent/showAgentList.php');
    final response = await http.post(url, body: {
      'name': widget.token,
    });
    if (response.statusCode == 200) {
      print(widget.token);
      final dynamic jsonData = json.decode(response.body);
      print(jsonData);
      final List<dynamic> data = jsonData; // 将JSON对象转换为单元素列表
      setState(() {
        this.data = data;
        filteredData = data;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void filterData(String query) {
    setState(() {
      filteredData = data
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void togglePending() {
    setState(() {
      showPending = !showPending;
    });
  }

  void toggleConfirmed() {
    setState(() {
      showConfirmed = !showConfirmed;
    });
  }

  List<dynamic> getFilteredData() {
    if (showPending && showConfirmed) {
      return filteredData;
    } else if (showPending) {
      return filteredData.where((item) => item['status'] == '等待代理人确认').toList();
    } else if (showConfirmed) {
      return filteredData.where((item) => item['status'] == '代理人已确认').toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedData = getFilteredData(); // 获取符合条件的数据
    return Scaffold(
      appBar: AppBar(
        title: Text('业务处理'),
      ),
      body: Column(
        children: [
          // SizedBox(height: 40,),
          Row(
            children: [
              Expanded(
                child: inventorCustomSearchBox(
                  controller: searchController,
                  onChanged: (value) {
                    filterData(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: togglePending,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return showPending ? Colors.blue : Colors.grey;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), // 设置圆角程度
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(10, 50), // 设置按钮的高度
                    ),
                  ),
                  child: Text(
                    '待确认',
                    style: TextStyle(
                      color: Colors.white, // 设置字体颜色
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: toggleConfirmed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return showConfirmed ? Colors.blue : Colors.grey;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0), // 设置圆角程度
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(10, 50), // 设置按钮的高度
                    ),
                  ),
                  child: Text(
                    '已确认',
                    style: TextStyle(
                      color: Colors.white, // 设置字体颜色
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (displayedData[index]['status'] == '等待代理人确认') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgentNotarize(
                            token: widget.token,
                            name: displayedData[index]['name'],
                            status: displayedData[index]['status'],
                            peopleType: widget.peopleType,
                          ),
                        ),
                      );
                    } else if (displayedData[index]['status'] == '代理人已确认') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Accomplish(
                            token: widget.token,
                            name: displayedData[index]['name'],
                            status: displayedData[index]['status'],
                            peopleType: widget.peopleType,
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Text(filteredData[index]['name']), // 根据您的数据结构调整此处
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//搜索框
class inventorCustomSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const inventorCustomSearchBox({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5, //设置阴影的模糊程度
              offset: Offset(0, 3), //设置阴影的偏移量
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: '输入要搜索的内容',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 14.0), //设置搜索框的内边距
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

class AgentNotarize extends StatefulWidget {
  final String token;
  final String name;
  final String status;
  final String peopleType;
  AgentNotarize(
      {required this.token,
      required this.name,
      required this.status,
      required this.peopleType});

  @override
  _AgentNotarizeState createState() => _AgentNotarizeState();
}

class _AgentNotarizeState extends State<AgentNotarize> {
  bool isChecked = false; // 勾选框的选中状态
  Future<void> agentNext() async {
    print(widget.token);
    final url = Uri.parse(
        'http://192.168.33.217:160/patent-app/agent/agentNotarize.php');

    final response = await http.post(url, body: {
      'token': widget.token,
      'name': widget.name,
      'status': widget.status,
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      if (jsonData['success'] == '更新成功') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Accomplish(
              token: widget.token,
              name: widget.name,
              status: jsonData['status'],
              peopleType: widget.peopleType,
            ),
            // showInventorPage(name: filteredData[index]['name']),
          ),
        );
        print(jsonData);
      } else if (jsonData['success'] == '更新失败') {
        print('请稍后再试');
      } else {
        print('返回错误');
      }
    } else {
      print('请求失败');
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('${widget.status}'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 100,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 250.0,
              width: 300.0,
              child: Card(
                color: Colors.white24,
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(child: SizedBox(width: 20.0)),
                            TextSpan(
                              text: '你好',
                              style: TextStyle(fontSize: 18),
                              children: [
                                TextSpan(
                                  text: '${widget.token}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(
                                  text: '，你现在被分配到专利立案业务',
                                ),
                                TextSpan(
                                  text: '${widget.name}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(
                                  text: '的代理人，请你确认！\n',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 40,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },

                                    checkColor: Colors.black, //勾选标记颜色
                                    activeColor: Colors.white, //勾选后背景
                                  ),
                                  Text('我已确认'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isChecked
                                  ? () {
                                      agentNext();
                                    }
                                  : null,
                              child: Text(
                                '确认',
                                style: TextStyle(color: Colors.black87),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Accomplish extends StatefulWidget {
  final String token;
  final String name;
  final String status;
  final String peopleType;
  Accomplish(
      {required this.token,
      required this.name,
      required this.status,
      required this.peopleType});

  @override
  _AccomplishState createState() => _AccomplishState();
}

class _AccomplishState extends State<Accomplish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.status}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationDemo(
                  token: widget.token,
                  peopleType: widget.peopleType,
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text('${widget.name}'),
            Text('${widget.token}'),
          ],
        ),
      ),
    );
  }
}

//撰写上传文档
class AgentUpWord extends StatefulWidget {
  final String token;
  final String name;
  final String status;
  final String peopleType;
  AgentUpWord(
      {required this.token,
      required this.name,
      required this.status,
      required this.peopleType});

  @override
  _AgentUpWordState createState() => _AgentUpWordState();
}

class _AgentUpWordState extends State<AgentUpWord> {
  void pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.status}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationDemo(
                  token: widget.token,
                  peopleType: widget.peopleType,
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text('${widget.name}'),
            ElevatedButton(
              onPressed: pickAndUploadFile,
              child: Text('选择并上传文件'),
            ),
            Text('${widget.token}'),
          ],
        ),
      ),
    );
  }
}
