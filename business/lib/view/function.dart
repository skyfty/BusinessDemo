import 'package:flutter/material.dart';

class Function_file extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {},
      home: Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 15),
            SearchFor(),
            const SizedBox(height: 10),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}

class SearchFor extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    String searchText = _searchController.text;
    print('Performing search for: $searchText');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '请输入搜索内容',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _performSearch,
          ),
        ],
      ),
    );
  }
}
