import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patent/home/write/detailWrite.dart';
import 'package:patent/home/homeRoute.dart';
import 'package:file_picker/file_picker.dart';

class WriteHomePage extends StatefulWidget {
  final String token;
  final String peopleType;

  WriteHomePage({required this.token, required this.peopleType});

  @override
  _WriteHomePageState createState() => _WriteHomePageState();
}

class _WriteHomePageState extends State<WriteHomePage> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  TextEditingController searchController = TextEditingController();

  bool showPending = true;
  bool showConfirmed = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://192.168.33.217:160/patent-app/write/showWriteList.php');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('撰写'),
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
                        builder: (context) => DetailWrite(
                          token: widget.token,
                          peopleType: widget.peopleType,
                          business_name: filteredData[index]['name'],
                        ), //唯一ID
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(height: 8),
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
                                          text: filteredData[index]['name'],
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
