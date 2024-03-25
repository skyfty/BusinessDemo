import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patent/home/proposer/showproposer.dart'; //申请人信息
import 'package:patent/home/proposer/addProposer.dart'; //个人申请添加
import 'package:patent/home/proposer/addProposerbusiness.dart'; //企业申请

class ProposerList extends StatefulWidget {
  @override
  _ProposerListState createState() => _ProposerListState();
}

class _ProposerListState extends State<ProposerList> {
  List<dynamic> data = []; // 存储接口返回的数据
  List<dynamic> filteredData = []; // 存储符合搜索条件的数据
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); // 在页面初始化时获取数据
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://8.141.86.125/patent-app/index/applicant/showList.php');
    final response = await http.post(url, body: {
      'surface': 'proposer',
    });
    if (response.statusCode == 200) {
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

  String selectedOption = '企业主体';
  void onOptionSelected(String value) {
    setState(() {
      selectedOption = value;
      // 根据选择的选项进行页面跳转
      if (selectedOption == '企业申请') {
        //添加企业主体
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addProposerBusiness()),
        );
      } else if (selectedOption == '个人申请') {
        //添加个人主体
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProposer()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('申请人'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: showListCustomSearchBox(
                  controller: searchController,
                  onChanged: (value) {
                    filterData(value);
                  },
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) => onOptionSelected(value),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '个人申请',
                    child: Text('添加个人申请'),
                  ),
                  PopupMenuItem<String>(
                    value: '企业申请',
                    child: Text('添加企业申请'),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final name = filteredData[index]['name'];
                if (name == null) {
                  return Container();
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => showProposerPage(name: name),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(name),
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
class showListCustomSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const showListCustomSearchBox({
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
              spreadRadius: 2, //设置阴影的扩散程度
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
                horizontal: 16.0, vertical: 14.0), 
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
