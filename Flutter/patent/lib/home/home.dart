import 'package:flutter/material.dart';
import 'package:patent/home/homePage/homePage.dart';
import 'package:patent/home/proposer/showList.dart';
import 'package:patent/home/inventor/showList.dart';
import 'package:patent/home/register/registershow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patent/home/agentHome/agenthomepage.dart';
import 'package:patent/home/write/writeList.dart';
import 'package:patent/home/write/adminWrite.dart';

class AlipayHomePage extends StatefulWidget {
  final String token;
  final String peopleType;

  AlipayHomePage({required this.token, required this.peopleType});

  @override
  _AlipayHomePageState createState() => _AlipayHomePageState();
}

class _AlipayHomePageState extends State<AlipayHomePage> {
  void _navigateToSearchResultsPage(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(query: query),
      ),
    );
  }

  TextEditingController searchController = TextEditingController();

  List<GridItem> allItems = [
    GridItem(icon: Icons.create_new_folder, label: '主体'),
    GridItem(icon: Icons.flutter_dash, label: '申请人'),
    GridItem(icon: Icons.inventory, label: '发明人'),
    GridItem(icon: Icons.card_giftcard, label: '立案'),
    GridItem(icon: Icons.phone_android, label: '撰写'),
    GridItem(icon: Icons.directions_car, label: '汽车'),
    GridItem(icon: Icons.shopping_basket, label: '标题'),
    GridItem(icon: Icons.movie, label: '标题'),
  ];
  List<GridItem> filteredItems = [];

  void filterData(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredItems = allItems
            .where((item) =>
                item.label.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredItems = allItems;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 去掉返回箭头
        title: CustomSearchBoxs(
          controller: searchController,
          onChanged: (value) {
            _navigateToSearchResultsPage(value);
          },
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '你好,',
                  style: TextStyle(
                    fontSize: 20,
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  widget.token,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  '你是',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  widget.peopleType,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              // color: Colors.blue,
              width: double.infinity,
              height: 1000,

              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ), // 设置Row的外边距
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.peopleType == '超级管理员') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Principal()),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: '你没有权限，请联系管理员',
                                  );
                                }
                              },
                              child: GridItem(
                                icon: Icons.create_new_folder,
                                label: '主体',
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.peopleType == '超级管理员') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProposerList()),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: '你没有权限，请联系管理员',
                                  );
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => ProposerList()),
                                // );
                              },
                              child: GridItem(
                                icon: Icons.flutter_dash,
                                label: '申请人',
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.peopleType == '超级管理员') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InventorList()),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: '你没有权限，请联系管理员',
                                  );
                                }
                              },
                              child: GridItem(
                                icon: Icons.inventory,
                                label: '发明人',
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.peopleType == 'Admin group' ||
                                    widget.peopleType == '中联国智总部') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => registerList(
                                              token: widget.token,
                                              peopleType: widget.peopleType,
                                            )),
                                  );
                                } else if (widget.peopleType == '流程部') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgentHomePage(
                                              token: widget.token,
                                              peopleType: widget.peopleType,
                                            )),
                                  );
                                } else {}
                              },
                              child: GridItem(
                                icon: Icons.card_giftcard,
                                label: '立案',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              if (widget.peopleType == 'Admin group' ||
                                  widget.peopleType == '中联国智总部') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => adminList(
                                            token: widget.token,
                                            peopleType: widget.peopleType,
                                          )),
                                );
                              } else if (widget.peopleType == '流程部' ||
                                  widget.peopleType == '撰写部') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WriteHomePage(
                                            token: widget.token,
                                            peopleType: widget.peopleType,
                                          )),
                                );
                              } else {}
                            },
                            child: GridItem(
                              icon: Icons.phone_android,
                              label: '撰写',
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {},
                            child: GridItem(
                              icon: Icons.directions_car,
                              label: '汽车',
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {},
                            child: GridItem(
                              icon: Icons.shopping_basket,
                              label: '标题',
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {},
                            child: GridItem(
                              icon: Icons.movie,
                              label: '标题',
                            ),
                          )),
                        ],
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

//图标
class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const GridItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 48,
          color: Colors.green,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}

//搜索
class CustomSearchBoxs extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBoxs({
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
          borderRadius: BorderRadius.circular(10.0), //设置搜索框的圆角
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

class SearchResultsPage extends StatelessWidget {
  final String query;

  SearchResultsPage({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: Text('Display search results for $query'),
      ),
    );
  }
}
