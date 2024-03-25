import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patent/home/register/register_detail.dart';
import 'package:pinyin/pinyin.dart';

class registerList extends StatefulWidget {
  final String token;
  final String peopleType;
  registerList({required this.token, required this.peopleType});
  @override
  _registerListState createState() => _registerListState();
}

class _registerListState extends State<registerList> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://192.168.33.217:160/patent-app/register/registershow.php');
    final response = await http.post(url, body: {
      'surface': 'inventor',
    });
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);

      final List<dynamic> data = jsonData; // 将JSON对象转换为单元素列表
      setState(() {
        this.data = data;
        filteredData = data;
      });
      print(jsonData);
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

  void onOptionSelected(String value) {
    setState(() {
      // selectedOption = value;

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterAdd(
                  token: widget.token,
                  peopleType: widget.peopleType,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('立案列表'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 设置滚动时的背景颜色
          ),
        ),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterAdd(
                              token: widget.token,
                              peopleType: widget.peopleType,
                            )),
                  );
                },
                child: Text('添加'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterDetail(
                                token: widget.token,
                                peopleType: widget.peopleType,
                                status: filteredData[index]['status'],
                                registerName: filteredData[index]['name'],
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)), //圆角程度
                      ),
                      elevation: 4,
                      color: Colors.blueGrey[100],
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blueAccent,
                              Colors.greenAccent
                            ], // 调整渐变色
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredData[index]['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '创建时间: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: filteredData[index]['time'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '状态: ${filteredData[index]['status']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
              blurRadius: 5,
              offset: Offset(0, 3),
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

//registeradd立案添加

class RegisterAdd extends StatefulWidget {
  final String token;
  final String peopleType;

  RegisterAdd({required this.token, required this.peopleType});

  @override
  _RegisterAddState createState() => _RegisterAddState();
}

class _RegisterAddState extends State<RegisterAdd> {
  TextEditingController input1Controller = TextEditingController(); //交底书名称
  TextEditingController input2Controller = TextEditingController(); //案件类型
  TextEditingController input3Controller = TextEditingController(); //立案周期
  TextEditingController input4Controller = TextEditingController(); //对方案号
  DateTime? selectedDate;

  Subject? selectedSubject;
  Department? selectedDepartment;
  Agent? selectedAgent;
  Contact? selectedContact;

  Client? selectedClient;
  Technology? selectedTechnology;
  teContact? selectedteContact;

  @override
  void initState() {
    super.initState();
    fetchData(); // 在页面打开时自动请求数据
    DateTime? selectedDate;
  }

  List<Subject> subjects = [];
  List<Department> departments = [];
  List<Agent> agents = [];
  List<Contact> contacts = [];
  List<Client> clients = [];
  List<Technology> technologys = [];
  List<teContact> tecontacts = [];

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://192.168.33.217:160/patent-app/register/registerAdd.php'); //请求下拉数据
    final response = await http.post(url, body: {
      // 'surface': 'inventor',
    });
    if (response.statusCode == 200) {
      final aa = json.decode(response.body);
      print(aa);
      final List<dynamic> jsonList = aa['names'];
      for (var json in jsonList) {
        final subject = Subject(name: json['name']);
        setState(() {
          subjects.add(subject);
        });
      }
      final List<dynamic> departmentss = aa['agents'];
      for (var departmentA in departmentss) {
        final department = Department(
            name: departmentA['department'],
            organization: departmentA['organization']);
        setState(() {
          departments.add(department);
        });
      }
      final List<dynamic> agentss = aa['agents'];
      for (var agentA in agentss) {
        final agent = Agent(
            people: agentA['agent_name'],
            ername: agentA['organization'],
            telephone: agentA['telephone'],
            deparment: agentA['department']);
        setState(() {
          agents.add(agent);
        });
      }
      final List<dynamic> contactsss = aa['agents'];
      for (var contactA in contactsss) {
        final contact = Contact(name: contactA['telephone']);
        setState(() {
          contacts.add(contact);
        });
      }
      final List<dynamic> clientss = aa['companys'];
      for (var clientA in clientss) {
        final client = Client(client_name: clientA['company']);
        setState(() {
          clients.add(client);
        });
      }
      final List<dynamic> technologyss = aa['technologys'];
      for (var technologyA in technologyss) {
        final technology = Technology(
            technologyName: technologyA['technology_name'],
            technologyClient: technologyA['client_name'],
            technologyPhone: technologyA['telephone']);
        setState(() {
          technologys.add(technology);
        });
      }
      final List<dynamic> tecontactss = aa['technologys'];
      for (var tecontactA in tecontactss) {
        final tecontact = teContact(tePhone: tecontactA['telephone']);
        setState(() {
          tecontacts.add(tecontact);
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void updateSelectedValues(
    Subject? subject,
    Department? department,
    Agent? agent,
    Contact? contact,
  ) {
    setState(() {
      selectedSubject = subject;
      selectedDepartment = department;
      selectedAgent = agent;
      selectedContact = contact;
    });
  }

  void updateSelectClient(
      Client? client, Technology? technology, teContact? tecontact) {
    setState(() {
      selectedClient = client;
      selectedTechnology = technology;
      selectedteContact = tecontact;
    });
  }

  Future<void> submitData() async {
    String input1 = input1Controller.text; //交底书名称
    String input2 = input2Controller.text; //案件类型
    String input3 = input3Controller.text; //立案周期
    String input4 = input4Controller.text; //对方案号

    if (selectedSubject != null &&
        selectedAgent != null &&
        selectedContact != null) {
      print(input1);
      print(input2);
      print(input3);
      print('已提交：');
      print('Subject: ${selectedSubject!.name}'); //代理机构
      print('Agent: ${selectedAgent!.people}'); //代理人
      print('Contact: ${selectedContact!.name}'); //代理人联系方式
      print('${selectedClient!.client_name}');
      print('${selectedTechnology!.technologyName}');
      print('${selectedteContact!.tePhone}');
      print(_value); //版权类型
      print(_inventDecide); //发明专利是否提前公开
      print(_fast); //是否加快
      print(selectedDate);
      String subjectName = selectedSubject!.name;
      String firstTwoLetters = '';
      if (subjectName.length >= 2) {
        String firstLetter = subjectName.substring(0, 1);
        String secondLetter = subjectName.substring(1, 2);
        firstTwoLetters =
            '${firstLetter.toUpperCase()}${secondLetter.toUpperCase()}';
      } else if (subjectName.length == 1) {
        firstTwoLetters = subjectName.toUpperCase();
      }

      String aa = PinyinHelper.getShortPinyin(firstTwoLetters)
          .toUpperCase(); //前两个汉字大写首字母

      final url =
          Uri.http('192.168.33.217:160', '/patent-app/register/Add.php');
      final response = await http.post(url, body: {
        'token': widget.token,
        'register_name': input1,
        'case_time': selectedDate.toString(), //立案日期
        'my_case_number': aa,
        'other_case_number': input4,
        'fast': _fast,
        'organization': selectedSubject!.name,
        'department': selectedDepartment!.name,
        'agent': selectedAgent!.people,
        'agent_phone': selectedContact!.name,
        'client_name': selectedClient!.client_name,
        'technology': selectedTechnology!.technologyName,
        'technology_phone': selectedteContact!.tePhone,
        'invent_open': _inventDecide,
        'copyright_type': _value,
        'register_cycle': input3,
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print('Changes submitted successfully.');
      } else {
        print('Failed to submit changes. Status code: ${response.statusCode}.');
      }
    } else {
      Fluttertoast.showToast(msg: '请填完所有必填字段');
      print('请先选择所有字段');
    }
  }

  String _value = 'I'; // 版权类型
  String _inventDecide = '是';
  String _fast = '是';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加立案业务'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Column(
                  children: [
                    // Text('添加立案业务'),
                    CustomInputField(
                      controller: input1Controller,
                      hintText: '请输入交底书名称',
                      title: '交底书名称',
                      isRequired: true,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    CustomInputField(
                      controller: input2Controller,
                      hintText: '请输入案件类型',
                      title: '案件类型',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomInputField(
                      controller: input3Controller,
                      hintText: '请输入立案周期',
                      title: '立案周期',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomInputField(
                      controller: input4Controller,
                      hintText: '请输入对方案号',
                      title: '对方案号',
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 80,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  '是否加快:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 200, // 添加具有有限宽度约束的SizedBox
                                child: DropdownButtonFormField<String>(
                                  value: _fast,
                                  decoration: InputDecoration(
                                    // labelText: '版权类型', // 在左侧显示版权类型文本
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('是'),
                                      value: '是',
                                    ),
                                    DropdownMenuItem(
                                        child: Text('否'), value: '否'),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _fast = value!;
                                    });
                                  },
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  '立案日期:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      selectedDate = pickedDate;
                                    });
                                  }
                                },
                                child: Container(
                                  // color: Colors.white,
                                  width: 200,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    selectedDate != null
                                        ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
                                        : '请选择日期',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 80,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  '版权类型:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 200,
                                child: DropdownButtonFormField<String>(
                                  value: _value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('发明'),
                                      value: 'I',
                                    ),
                                    DropdownMenuItem(
                                        child: Text('实用新型'), value: 'U'),
                                    DropdownMenuItem(
                                        child: Text('外观设计'), value: 'D'),
                                    DropdownMenuItem(
                                        child: Text('商标'), value: 'R'),
                                    DropdownMenuItem(
                                        child: Text('软著'), value: 'C'),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                    });
                                  },
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),

                    CustomDropdownFields(
                      subjects: subjects,
                      departments: departments,
                      agents: agents,
                      contacts: contacts,
                      onSelectionChanged: updateSelectedValues,
                      isRequired: true,
                    ),
                    TechnologyFields(
                      clients: clients,
                      technologys: technologys,
                      tecontacts: tecontacts,
                      onChanged: updateSelectClient,
                      isRequired: true,
                    ),

                    Container(
                      height: 80,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  '发明专利是否提前公开:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 200,
                                child: DropdownButtonFormField<String>(
                                  value: _inventDecide,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('是'),
                                      value: '是',
                                    ),
                                    DropdownMenuItem(
                                        child: Text('否'), value: '否'),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _inventDecide = value!;
                                    });
                                  },
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 56,
            // bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: submitData,
              child: Text(
                '提交',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//普通文本输入框组件
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final bool isRequired;
  CustomInputField(
      {required this.controller,
      required this.hintText,
      required this.title,
      this.isRequired = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 130,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  '${title}:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none, // 移除输入框下面的线
                    ),
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

//动态下拉框
class Subject {
  final String name;

  Subject({required this.name});
}

class Department {
  //部门
  final String name;
  final String organization;
  Department({required this.name, required this.organization});
}

class Agent {
  final String people;
  final String ername; //代理机构
  final String telephone;
  final String deparment;

  Agent(
      {required this.people,
      required this.ername,
      required this.telephone,
      required this.deparment});
}

class Contact {
  final String name;

  Contact({required this.name});
}

class CustomDropdownFields extends StatefulWidget {
  final List<Subject> subjects; //代理机构
  final List<Agent> agents; //代理人
  final List<Contact> contacts; //代理人电话
  final List<Department> departments; //部门
  final bool isRequired;
  final Function(Subject?, Department?, Agent?, Contact?)? onSelectionChanged;

  CustomDropdownFields({
    required this.subjects,
    required this.agents,
    required this.contacts,
    required this.departments,
    this.onSelectionChanged,
    this.isRequired = false,
  });

  @override
  _CustomDropdownFieldsState createState() => _CustomDropdownFieldsState();
}

class _CustomDropdownFieldsState extends State<CustomDropdownFields> {
  Subject? selectedSubject;
  Department? selectedDepartment;
  Agent? selectedAgent;
  Contact? selectedContact;

  List<DropdownMenuItem<Subject>> buildSubjectDropdownItems() {
    //代理机构
    return widget.subjects.map((subject) {
      return DropdownMenuItem<Subject>(
        value: subject,
        child: Text(subject.name),
      );
    }).toList();
  }

  List<DropdownMenuItem<Department>> buildDepartmentDropdownItems() {
    //部门
    if (selectedSubject == null) {
      return [];
    }
    return widget.departments.where((department) {
      return department.organization == selectedSubject!.name;
    }).map((department) {
      return DropdownMenuItem<Department>(
        value: department,
        child: Text(department.name),
      );
    }).toList();
  }

  List<DropdownMenuItem<Agent>> buildAgentDropdownItems() {
    //代理人

    if (selectedDepartment == null) {
      return [];
    }
    return widget.agents.where((agent) {
      return agent.deparment == selectedDepartment!.name;
    }).map((agent) {
      return DropdownMenuItem<Agent>(
        value: agent,
        child: Text(agent.people),
      );
    }).toList();
  }

  List<DropdownMenuItem<Contact>> buildContactDropdownItems() {
    if (selectedAgent == null) {
      return [];
    }
    return widget.contacts.where((contact) {
      return contact.name == selectedAgent!.telephone;
    }).map((contact) {
      return DropdownMenuItem<Contact>(
        value: contact,
        child: Text(contact.name),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '代理机构:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: IntrinsicWidth(
                        child: DropdownButtonFormField<Subject>(
                          value: selectedSubject,
                          items: buildSubjectDropdownItems(),
                          hint: Text('请选择代理机构'),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none, // 移除输入框下面的线
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedSubject = value;
                              selectedDepartment = null;
                              selectedAgent = null;
                              selectedContact = null;
                            });

                            if (widget.onSelectionChanged != null) {
                              widget.onSelectionChanged!(
                                  selectedSubject,
                                  selectedDepartment,
                                  selectedAgent,
                                  selectedContact);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '代理部门:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: IntrinsicWidth(
                        child: DropdownButtonFormField<Department>(
                          value: selectedDepartment,
                          items: buildDepartmentDropdownItems(),
                          hint: Text('请选择代理机构'),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none, // 移除输入框下面的线
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedDepartment = value;
                              selectedAgent = null;
                              selectedContact = null;
                            });

                            if (widget.onSelectionChanged != null) {
                              widget.onSelectionChanged!(
                                  selectedSubject,
                                  selectedDepartment,
                                  selectedAgent,
                                  selectedContact);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(children: [
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    '代理人:',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              if (widget.isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<Agent>(
                      value: selectedAgent,
                      items: buildAgentDropdownItems(),
                      hint: Text('请选择代理人'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none, // 移除输入框下面的线
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedAgent = value;
                          selectedContact = null;
                        });

                        if (widget.onSelectionChanged != null) {
                          widget.onSelectionChanged!(
                              selectedSubject,
                              selectedDepartment,
                              selectedAgent,
                              selectedContact);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '电话号码:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<Contact>(
                        value: selectedContact,
                        items: buildContactDropdownItems(),
                        hint: Text('请选择联系方式'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedContact = value;
                          });

                          if (widget.onSelectionChanged != null) {
                            widget.onSelectionChanged!(
                                selectedSubject,
                                selectedDepartment,
                                selectedAgent,
                                selectedContact);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//客户动态下拉
class Client {
  //客户
  final String client_name;
  Client({required this.client_name});
}

class Technology {
  //技术
  final String technologyName;
  final String technologyClient;
  final String technologyPhone;

  Technology(
      {required this.technologyName,
      required this.technologyClient,
      required this.technologyPhone});
}

class teContact {
  final String tePhone;
  teContact({required this.tePhone});
}

class TechnologyFields extends StatefulWidget {
  final List<Client> clients;
  final List<Technology> technologys;
  final List<teContact> tecontacts;
  final bool isRequired;
  final Function(Client?, Technology?, teContact?)? onChanged;
  TechnologyFields(
      {required this.clients,
      required this.technologys,
      required this.tecontacts,
      this.onChanged,
      this.isRequired = false});
  @override
  _TechnologyFieldsState createState() => _TechnologyFieldsState();
}

class _TechnologyFieldsState extends State<TechnologyFields> {
  Client? selectedClient;
  Technology? selectedTechnology;
  teContact? selectedteContact;
  List<DropdownMenuItem<Client>> buildClientDropdownItems() {
    return widget.clients.map((client) {
      return DropdownMenuItem<Client>(
        value: client,
        child: Text(client.client_name),
      );
    }).toList();
  }

  List<DropdownMenuItem<Technology>> buildTechnologyDropdownItems() {
    if (selectedClient == null) {
      return [];
    }

    return widget.technologys.where((technology) {
      return technology.technologyClient == selectedClient!.client_name;
    }).map((technology) {
      return DropdownMenuItem<Technology>(
        value: technology,
        child: Text(technology.technologyName),
      );
    }).toList();
  }

  List<DropdownMenuItem<teContact>> buildteContactDropdownItems() {
    if (selectedTechnology == null) {
      return [];
    }

    return widget.tecontacts.where((tecontact) {
      return tecontact.tePhone == selectedTechnology!.technologyPhone;
    }).map((tecontact) {
      return DropdownMenuItem<teContact>(
        value: tecontact,
        child: Text(tecontact.tePhone),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '客户:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<Client>(
                        isExpanded: true,
                        value: selectedClient,
                        items: buildClientDropdownItems(),
                        hint: Text('请选择客户'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none, // 移除输入框下面的线
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedClient = value;
                            selectedTechnology = null;
                            selectedteContact = null;
                          });

                          if (widget.onChanged != null) {
                            widget.onChanged!(selectedClient,
                                selectedTechnology, selectedteContact);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(children: [
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    '技术人员:',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              if (widget.isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<Technology>(
                      value: selectedTechnology,
                      items: buildTechnologyDropdownItems(),
                      hint: Text('请选择技术人员'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none, // 移除输入框下面的线
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedTechnology = value;
                          selectedteContact = null;
                        });

                        if (widget.onChanged != null) {
                          widget.onChanged!(selectedClient, selectedTechnology,
                              selectedteContact);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '技术电话:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<teContact>(
                        value: selectedteContact,
                        items: buildteContactDropdownItems(),
                        hint: Text('请选择联系方式'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedteContact = value;
                          });

                          if (widget.onChanged != null) {
                            widget.onChanged!(selectedClient,
                                selectedTechnology, selectedteContact);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
