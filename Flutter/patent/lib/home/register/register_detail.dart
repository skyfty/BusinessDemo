import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert'

//立案业务详细信息
class RegisterDetail extends StatefulWidget {
  final String token;
  final String peopleType;
  final String status;
  final String registerName;
  RegisterDetail(
      {required this.token,
      required this.peopleType,
      required this.status,
      required this.registerName});
  @override
  _RegisterDetailState createState() => _RegisterDetailState();
}

class _RegisterDetailState extends State<RegisterDetail> {
  String register_name = ''; //交底书名称
  String case_type = ''; //案件类型
  String now_status = ''; //当前状态
  String period = ''; //立案周期
  String other_case_number = ''; //对方案号
  String fast = ''; //是否加快
  String copyright_type = ''; //版权类型
  String organization = ''; //代理机构
  String department = ''; //代理部门
  String agent = ''; //代理人
  String agent_phone = ''; //代理人电话
  String client_name = ''; //客户
  String technology = ''; //技术人员
  String technology_phone = ''; //技术人员电话
  String invent_open = ''; //发明专利是否提前公开

  @override
  void initState() {
    super.initState();
    fetchData(); // 在页面打开时自动请求数据
  }

  Future<void> fetchData() async {
    final url =
        Uri.http('192.168.33.217:160', '/patent-app/register/showregister.php');
    final response = await http.post(url, body: {
      'token': widget.token,
      'register_name': widget.registerName,
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      print(jsonData[0]['agent']);
      setState(() {
        register_name = jsonData[0]['name'];
        case_type = jsonData[0]['case_type'];
        now_status = jsonData[0]['now_status'];
        period = jsonData[0]['period'];
        other_case_number = jsonData[0]['other_case_number'];
        fast = jsonData[0]['fast'];
        copyright_type = jsonData[0]['copyright_type'];
        organization = jsonData[0]['organization'];
        department = jsonData[0]['department']; //代理部门
        agent = jsonData[0]['agent']; //代理人
        agent_phone = jsonData[0]['agent_phone']; //代理人电话
        client_name = jsonData[0]['client_name']; //客户
        technology = jsonData[0]['technology']; //技术人员
        technology_phone = jsonData[0]['technology_phone']; //技术人员电话
        invent_open = jsonData[0]['invent_open'];
      });
    } else {
      print(1243);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.registerName),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterEdit(
                        token: widget.token,
                        peopleType: widget.peopleType,
                        title: widget.registerName)),
              );
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              '修改',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 0),
          child: Column(
            children: [
              // CustomRow 组件列表
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomRow(
                      title: '交底书名称：',
                      status: register_name,
                    ),
                    CustomRow(
                      title: '案件类型：',
                      status: case_type,
                    ),
                    CustomRow(
                      title: '当前状态：',
                      status: '${widget.status}',
                    ),
                    CustomRow(
                      title: '立案周期：',
                      status: period,
                    ),
                    CustomRow(
                      title: '对方案号：',
                      status: other_case_number,
                    ),
                    CustomRow(
                      title: '是否加快：',
                      status: fast,
                    ),
                    CustomRow(
                      title: '版权类型：',
                      status: copyright_type,
                    ),
                    CustomRow(
                      title: '代理机构：',
                      status: organization,
                    ),
                    CustomRow(
                      title: '代理人：',
                      status: agent,
                    ),
                    CustomRow(
                      title: '代理人电话：',
                      status: agent_phone,
                    ),
                    CustomRow(
                      title: '客户：',
                      status: client_name,
                    ),
                    CustomRow(
                      title: '技术人员：',
                      status: technology,
                    ),
                    CustomRow(
                      title: '技术人员电话：',
                      status: technology_phone,
                    ),
                    CustomRow(
                      title: '发明专利是否提前公开：',
                      status: invent_open,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//一行信息组件
class CustomRow extends StatefulWidget {
  final String status;
  final String title;

  CustomRow({required this.status, required this.title});

  @override
  @override
  _CustomRowState createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                widget.status,
                style: TextStyle(fontSize: 15, color: Colors.red),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//修改页面
class RegisterEdit extends StatefulWidget {
  final String token;
  final String peopleType;
  final String title;

  RegisterEdit(
      {required this.token, required this.peopleType, required this.title});

  @override
  _RegisterEditState createState() => _RegisterEditState();
}

class _RegisterEditState extends State<RegisterEdit> {
  Client? selectedClient;
  Technology? selectedTechnology;
  teContact? selectedteContact;
  List<Client> clients = [];
  List<Technology> technologys = [];
  List<teContact> tecontacts = [];
  void updateSelectClient(
      Client? client, Technology? technology, teContact? tecontact) {
    setState(() {
      selectedClient = client;
      selectedTechnology = technology;
      selectedteContact = tecontact;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // 在页面打开时自动请求数据
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('http://8.141.86.125/patent-app/register/registerAdd.php');
    final response = await http.post(url, body: {
      // 'surface': 'inventor',
    });
    if (response.statusCode == 200) {
      final aa = json.decode(response.body);
      print(aa);

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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
        ),
        body: Stack(children: [
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Column(
                        children: [
                          TechnologyFields(
                            clients: clients,
                            technologys: technologys,
                            tecontacts: tecontacts,
                            onChanged: updateSelectClient,
                            isRequired: true,
                          ),
                        ],
                      ))))
        ]));
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

  TechnologyFields({
    required this.clients,
    required this.technologys,
    required this.tecontacts,
    this.onChanged,
    this.isRequired = false,
  });
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
  void initState() {
    super.initState();
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
                        border: InputBorder.none,
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
