import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patent/home/inventor/showinventor.dart'; //发明人信息
import 'package:patent/home/inventor/addInventor.dart';

class InventorList extends StatefulWidget {
  @override
  _InventorListState createState() => _InventorListState();
}

class _InventorListState extends State<InventorList> {
  List<dynamic> data = []; // 存储接口返回的数据
  List<dynamic> filteredData = []; // 存储符合搜索条件的数据
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); 
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://8.141.86.125/patent-app/index/applicant/showList.php');
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
     
      
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addInventor()),
        );

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发明人'),
      ),
      body: Column(
        children: [
        
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
              PopupMenuButton<String>(
               
                onSelected: (value) => onOptionSelected(value),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '发明',
                    child: Text('添加发明人'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            showInventorPage(name: filteredData[index]['name']),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Text(filteredData[index]['name']),
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
      padding: const EdgeInsets.all(14.0), //设置搜索框的位置
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0), //设置搜索框的圆角
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), //设置搜索框的阴影
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
                horizontal: 16.0, vertical: 14.0), //设置搜索框的内边距
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
