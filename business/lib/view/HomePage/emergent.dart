import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:business/view/home_page.dart';
import 'package:business/login.dart';
class Task {
  String title;
  String contend;
  String taskobjectid;
  String tasks;
  Task(this.title, this.contend,this.tasks,this.taskobjectid);
}
String phone = getGlobalPhone();
class Emergent extends StatefulWidget {
  @override
  _EmergentState createState() => _EmergentState();
}

class _EmergentState extends State<Emergent> {
  List<Task> urgentItems = [];

  @override
  void initState() {
    super.initState();
    _loadTasksFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '紧急',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _showAddDialog();
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: urgentItems.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 0); // 调整间距的高度
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final task = urgentItems[index];

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsPage(
                                title: task.title ?? '',
                                content: task.contend ?? '',
                              ),
                            ),
                          );
                        },
                        title: Text(
                          task.title ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                          ),
                        ),
                        subtitle: Text(
                          task.contend ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        leading: Icon(
                          Icons.star,
                          size: 22,
                          color: Colors.blueAccent,
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: Colors.black45,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String newTasktitle = '';
  String newTaskcontend = '';
  String selectedOption = '选项一';

  void _handleOptionChanged(String newValue) {
    setState(() {
      selectedOption = newValue;
    });
  }
  Future<void> _showAddDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('添加紧急事务'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownSelect(
                options: ['选项一', '选项二', '选项三'],
                selectedOption: selectedOption,
                onChanged: _handleOptionChanged,
              ),
              TextField(
                onChanged: (value) {
                  newTasktitle = value;
                },
                decoration: InputDecoration(hintText: '输入事务名称'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  newTaskcontend = value;
                },
                decoration: InputDecoration(hintText: '输入事务描述'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (newTasktitle.isNotEmpty && newTaskcontend.isNotEmpty) {
                  await _addTaskToDatabase(newTasktitle, newTaskcontend);
                  setState(() {
                    urgentItems.add(Task(newTasktitle, newTaskcontend,newTasktitle, newTaskcontend));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('确认'),
            ),
          ],
        );
      },
    );
  }

  // int _id = getGlobalId();

  Future<void> _loadTasksFromDatabase() async {
    final url = Uri.parse('http://192.168.33.217:8081/php/PHP/business/statuschange.php?phone=$phone');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final rawResponse = response.body;
        // final jsonResult = json.decode(response.body);
        final decodedResponse = utf8.decode(rawResponse.runes.toList());
        final responseData = jsonDecode(decodedResponse);
        print(responseData);
        if (responseData is List) {
          final tasksData = responseData;
          setState(() {
            urgentItems = tasksData.map((taskData) {
              if (taskData is Map<String, dynamic>) {
                return Task(taskData['taskobject'], taskData['taskstatus'],taskData['task'],taskData['id']);
              } else {
                return null;
              }
            }).whereType<Task>().toList();
          });
        }
        print('Tasks loaded successfully');
      } else {
        print('Failed to load tasks');
      }
    } catch (error) {
      print('Error loading tasks: $error');
    }
  }

  Future<void> _addTaskToDatabase(String title, String contend) async {
    final url = Uri.parse('http://192.168.33.217:8081/php/PHP/business/businesses.php'); // 替换为你的后端API URL
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8', // 设置Content-Type和字符编码
    };
    final body = jsonEncode({
      'title': title,
      'contend': contend,
    });
    try {
      // final response = await http.post(url, headers: headers, body: body);
      final response = await http.post(url, headers: headers, body: body, encoding: utf8);
      if (response.statusCode == 200) {
        print('Task added successfully');
      } else {
        print('Failed to add task');
      }
    } catch (error) {
      print('Error adding task: $error');
    }
  }
}




class DropdownSelect extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onChanged;

  DropdownSelect({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  _DropdownSelectState createState() => _DropdownSelectState();
}

class _DropdownSelectState extends State<DropdownSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedOption,
      onChanged: (String? newValue) {
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
      items: widget.options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
//二级页面
class TaskDetailsPage extends StatefulWidget {
  final String title;
  final String content;

  TaskDetailsPage({required this.title, required this.content});

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  bool showButtons = false;
  String? add;
  @override
  void initState() {
    super.initState();
    _checkTaskObject();
  }

  void _checkTaskObject() async {
    final url = Uri.parse(
        'http://192.168.33.217:8081/php/PHP/business/taskobject/pretreatment.php?phone=15110055954&taskobject=${widget.title}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final result = jsonResult['result'];
      print(result);

      setState(() {
        add = jsonResult['name']; // 将add赋值为jsonResult['name']
        if (result == '相同') {
          showButtons = true;
        } else {
          showButtons = false;
        }
      });
    } else {
      print('请求失败: ${response.statusCode}');
    }
  }

  void _submitTask(BuildContext context) async {
    final url = Uri.parse(
        'http://192.168.33.217:8081/php/PHP/business/process.php?phone=15110055954&taskobject=${widget.title}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('提交成功');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_pages()),
      );
    } else {
      print('提交失败');
    }
  }

  void _rejectTask(BuildContext context) async {
    final url = Uri.parse(
        'http://192.168.33.217:8081/php/PHP/business/taskobject/reject.php?phone=15110055954&taskobject=${widget.title}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('驳回成功');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_pages()),
      );
    } else {
      print('驳回失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '业务: ${widget.title}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '当前状态: ${widget.content}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            if (add != null) // 检查add是否有值
              Text(
                '当前处理人: $add',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            if (showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _submitTask(context);
                    },
                    child: Text('提交'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _rejectTask(context);
                    },
                    child: Text('驳回'),
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}




