// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class VolumeProvider with ChangeNotifier {
//   double _appVolume = 0.5;
//
//   double get appVolume => _appVolume;
//
//   void setAppVolume(double volume) {
//     _appVolume = volume;
//     notifyListeners();
//   }
// }
// class VolumePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final volumeProvider = Provider.of<VolumeProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('调节音量'),
//       ),
//       body: Center(
//         child: Slider(
//           value: volumeProvider.appVolume,
//           min: 0,
//           max: 1,
//           divisions: 100,
//           onChanged: (val) {
//             volumeProvider.setAppVolume(val);
//             print("App Volume: $val");
//           },
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume_control/volume_control.dart';

class VolumePage extends StatefulWidget {
  @override
  _VolumePageState createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  double _appVolume = 0.5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initVolumeState();
  }

  Future<void> initVolumeState() async {
    if (!mounted) return;

    // volume_control plugin does not have direct getAppVolume method.
    // You can set the initial app volume to 0.5 or any desired value.
    // For handling system volume, you can use the package in the platform code (Android/iOS).
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('调节音量'),
      ),
      body: Center(
        child: Slider(
          value: _appVolume,
          min: 0,
          max: 1,
          divisions: 100,
          onChanged: (val) {
            setState(() {
              _appVolume = val;
            });

            if (_timer != null) {
              _timer?.cancel();
            }

            _timer = Timer(Duration(milliseconds: 200), () {
              VolumeControl.setVolume(val);
            });

            print("App Volume: $_appVolume");
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import 'package:volume_control/volume_control.dart';
//
// class VolumePage extends StatefulWidget {
//   @override
//   _VolumePageState createState() => _VolumePageState();
// }
//
// class _VolumePageState extends State<VolumePage> {
//   double _appVolume = 0.5;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     initVolumeState();
//   }
//
//   Future<void> initVolumeState() async {
//     if (!mounted) return;
//
//     // 由于volume_control插件没有直接获取App音量的方法，因此这里设置默认音量为0.5
//     _appVolume = 0.5;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('调节音量'),
//       ),
//       body: Center(
//         child: Slider(
//           value: _appVolume,
//           min: 0,
//           max: 1,
//           divisions: 100,
//           onChanged: (val) {
//             setState(() {
//               _appVolume = val;
//             });
//
//             if (_timer != null) {
//               _timer?.cancel();
//             }
//
//             // 这里设置一个定时器来模拟音量调节，在实际应用中可以根据需要处理音量控制的逻辑
//             _timer = Timer(Duration(milliseconds: 200), () {
//               // 在这里实际上并没有直接影响系统音量，而是保存了Flutter内部的音量状态
//               print("App Volume: $_appVolume");
//             });
//           },
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:volume_control/volume_control.dart';
//
//
// //start entry
//
//
// //usage example
// class VolumePage extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// //usage example
// class _MyAppState extends State<VolumePage> {
//
//   @override
//   //init the plugin
//   void initState() {
//     super.initState();
//     initVolumeState();
//   }
//
//   //init volume_control plugin
//   Future<void> initVolumeState() async {
//     if (!mounted) return;
//
//     //read the current volume
//     _val = await VolumeControl.volume;
//     setState(() {
//     });
//   }
//
//   double _val = 0.5;
//   Timer? timer;
//   @override
//   //build a slider for example
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//           appBar: AppBar(
//             title: const Text('调节音量'),
//           ),
//           body: Center(
//               child: Slider(value:_val,min:0,max:1,divisions: 100,onChanged:(val){
//                 _val = val;
//                 setState(() {});
//                 if (timer!=null){
//                   timer?.cancel();
//                 }
//
//                 //use timer for the smoother sliding
//                 timer = Timer(Duration(milliseconds: 200), (){VolumeControl.setVolume(val);});
//
//                 print("val:$val");
//               })
//           )
//
//       );
//   }
// }