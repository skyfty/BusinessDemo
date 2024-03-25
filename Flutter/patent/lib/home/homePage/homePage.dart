import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patent/home/homePage/addBusiness.dart';
import 'package:patent/home/homePage/addPersion.dart';
import 'editPage.dart';
import 'package:patent/home/homePage/editPersion.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); // 在页面初始化时获取数据
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://8.141.86.125/patent-app/subject.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        this.data = data;
        filteredData = data;
      });
      print(data);
      print(data[0]['name']);
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

      if (selectedOption == '企业主体') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addBusiness()),
        );
      } else if (selectedOption == '个人主体') {
        //添加个人主体
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExplorePagess()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主体'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchBox(
                  controller: searchController,
                  onChanged: (value) {
                    filterData(value);
                  },
                ),
              ),
              PopupMenuButton<String>(
                initialValue: selectedOption,
                onSelected: (value) => onOptionSelected(value),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '企业主体',
                    child: Text('添加企业主体'),
                  ),
                  PopupMenuItem<String>(
                    value: '个人主体',
                    child: Text('添加个人主体'),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (filteredData[index]['type'] == '企业主体') {
                      // 跳转到企业页面
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EnterprisePage(name: filteredData[index]['name']),
                        ),
                      );
                    } else if (filteredData[index]['type'] == '个人主体') {
                      // 跳转到个人页面
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PersonalPage(name: filteredData[index]['name']),
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
class CustomSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBox({
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
