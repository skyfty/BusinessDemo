import 'package:flutter/material.dart';

class Communication extends StatefulWidget {
  @override
  _CommunicationState createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  bool _isSystemExpanded = false;
  bool _isCustomerExpanded = false;
  bool _isInternalExpanded = false;

  void _toggleSystemExpansion() {
    setState(() {
      _isSystemExpanded = !_isSystemExpanded;
    });
  }

  void _toggleCustomerExpansion() {
    setState(() {
      _isCustomerExpanded = !_isCustomerExpanded;
    });
  }

  void _toggleInternalExpansion() {
    setState(() {
      _isInternalExpanded = !_isInternalExpanded;
    });
  }

  void _navigateToUserDetailPage(String user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailPage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户列表'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('系统',style: TextStyle(fontSize: 18, color: Colors.black45),),
            onTap: _toggleSystemExpansion,
            trailing: Icon(
              _isSystemExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
          _isSystemExpanded
              ? Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  child:Row(children: [

                    SizedBox(width: 10),
                    Text(
                      '系统用户1',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ],
                  ),
                  onTap: () => _navigateToUserDetailPage('系统用户1'),

                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('系统用户2'),
                  child:Row(children: [

                    SizedBox(width: 10),
                    Text(
                      '系统用户2',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('系统用户3'),
                  child:Row(children: [

                    SizedBox(width: 10),
                    Text(
                      '系统用户3',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: 20),
                // 更多系统用户
              ],
            ),
          )
              : SizedBox(),
          ListTile(
            title: Text('客户',style: TextStyle(fontSize: 18, color: Colors.black45),),
            onTap: _toggleCustomerExpansion,
            trailing: Icon(
              _isCustomerExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
          _isCustomerExpanded
              ? Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('客户用户1'),
                  child:Row(children: [

                    SizedBox(width: 10),
                    Text(
                      '客户用户1',
                      style: TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('客户用户2'),
                  child: Row(
                    children: [
                      SizedBox(width:10),
                      Text(
                        '客户用户2',style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('客户用户3'),
                  child: Row(
                    children: [
                      SizedBox(width:10),
                      Text('客户用户3',style:TextStyle(fontSize: 20, color: Colors.black45))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // 更多客户用户
              ],
            ),
          )
              : SizedBox(),
          ListTile(
            title: Text('内部',style: TextStyle(fontSize: 18, color: Colors.black45),),
            onTap: _toggleInternalExpansion,
            trailing: Icon(
              _isInternalExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
          _isInternalExpanded
              ? Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('内部用户1'),
                  child: Row(
                      children:[
                        SizedBox(width: 10,),
                        Text('内部用户1',style: TextStyle(fontSize: 20, color: Colors.black45),)
                      ]
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('内部用户2'),
                  child: Row(
                      children:[
                        SizedBox(width:10),
                        Text('内部用户2',style: TextStyle(fontSize: 20, color: Colors.black45),)
                      ]
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigateToUserDetailPage('内部用户3'),
                  child: Row(
                      children:[
                        SizedBox(width:10),
                        Text('内部用户3',style: TextStyle(fontSize: 20, color: Colors.black45),)
                      ]
                  ),
                ),
                const SizedBox(height: 20),
                // 更多内部用户
              ],
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final String user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('对话界面'),
      ),
      body: Center(
        child: Text('这是与 $user 的对话'),
      ),
    );
  }
}
