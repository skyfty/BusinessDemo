import 'package:flutter/material.dart';

enum LeaveStatus {
  Pending,
  Approved,
  Rejected,
}

class LeaveApprovalComponent extends StatefulWidget {
  @override
  _LeaveApprovalComponentState createState() => _LeaveApprovalComponentState();
}

class _LeaveApprovalComponentState extends State<LeaveApprovalComponent> {
  String leaveType = '病假';
  DateTime? startDate;
  DateTime? endDate;
  String reason = '';
  List<LeaveStatus> approvalStatus = [
    LeaveStatus.Pending,
    LeaveStatus.Pending,
    LeaveStatus.Pending,
  ];

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startDateController.text = '';
    endDateController.text = '';
  }
  String formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return '$year-$month-$day';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Application'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: leaveType,
              hint: Text('Leave Type'),
              onChanged: (value) {
                setState(() {
                  leaveType = value!;
                });
              },
              items: <String>[
                '病假',
                '事假',
                '事假',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '开始日期',
                    ),
                    controller: startDateController,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          startDate = pickedDate;
                          startDateController.text = formatDate(pickedDate);
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '结束日期',
                    ),
                    controller: endDateController,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          endDate = pickedDate;
                          endDateController.text = formatDate(pickedDate);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Reason',
              ),
              onChanged: (value) {
                setState(() {
                  reason = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('提交'),
              onPressed: () {
// 提交请假申请逻辑
// 可以将请假信息发送到后端进行处理
// 根据后端返回的结果更新 leaveStatus 状态
                setState(() {
                  approvalStatus = [
                    LeaveStatus.Pending,
                    LeaveStatus.Pending,
                    LeaveStatus.Pending,
                  ];
                });


                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApprovalProgressPage(approvalStatus: approvalStatus),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Leave Status:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: approvalStatus.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 20.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: LinearProgressIndicator(
                    value: getProgressValue(index),
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(getProgressColor(index)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  double getProgressValue(int index) {
    if (approvalStatus[index] == LeaveStatus.Approved) {
      return 1.0;
    } else if (approvalStatus[index] == LeaveStatus.Rejected) {
      return 0.0;
    } else {
      return 0.5;
    }
  }

  Color getProgressColor(int index) {
    if (approvalStatus[index] == LeaveStatus.Approved) {
      return Colors.green;
    } else if (approvalStatus[index] == LeaveStatus.Rejected) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }
}

class ApprovalProgressPage extends StatelessWidget {
  final List<LeaveStatus> approvalStatus;

  const ApprovalProgressPage({required this.approvalStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approval Progress'),
      ),
      body: ListView.builder(
        itemCount: approvalStatus.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Leave ${index + 1}'),
            subtitle: Text(approvalStatus[index].toString()),
          );
        },
      ),
    );
  }
}


