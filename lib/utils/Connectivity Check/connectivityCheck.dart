
import 'package:connectivity_plus/connectivity_plus.dart';

class Networkcheck{


Future<bool> check()async{
  var connectivityResultcheck=await(Connectivity().checkConnectivity());

  if(connectivityResultcheck==ConnectivityResult.mobile||connectivityResultcheck==ConnectivityResult.wifi){
  return true;
  }return false;
}
}

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// void connectivity(context){
//   Connectivity().checkConnectivity().then((value) {
//     if(value==ConnectivityResult.none){
//       _showConnectionState(context);
//     }});
//   _connectivitySubscription = Connectivity()
//       .onConnectivityChanged
//       .listen((ConnectivityResult result) {
//     print('Current connectivity status: $result');
//     //appShowToast('Current connectivity status: $result');
//     if (result == ConnectivityResult.none) {
//       //appShowToast('No internet Connected');
//       setState(() {
//         print('true');
//         connection = true;
//       });
//       _showConnectionState();
//     } else if (result == ConnectivityResult.mobile ||
//         result == ConnectivityResult.wifi) {
//       setState(() {
//         print('false');
//         connection = false;
//       });
//     }}
//
// void _showConnectionState(context) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return WillPopScope(
//           onWillPop: () {
//             //connection == false ? Navigator.pop(context) : false;
//             return Future.value(false);
//           },
//           child: AlertDialog(
//             actions: [
//               FlatButton(color: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   onPressed: () {
//                     Connectivity().checkConnectivity().then((value) {
//                       print('abdur');
//                       print(value);
//                       if(value==ConnectivityResult.mobile||value==ConnectivityResult.wifi){
//                         Future.delayed(Duration.zero, () {
//                           provider.getDrProfile();
//                           provider.notifyListeners();
//                         });
//                         Navigator.pop(context);
//                       }
//                     });
//
//                   },
//                   child: Text('Retry',style: TextStyle(color: Colors.white),))
//             ],
//             title: new Text(
//               "No Internet Connection",
//               style: TextStyle(color: Colors.black),
//             ),
//             content: new Text(
//               "Please Check the internet connection",
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//             // actions: <Widget>[
//             //   // usually buttons at the bottom of the dialog
//             //   new FlatButton(
//             //     child: new Text(
//             //       "Close",
//             //       style: TextStyle(
//             //         color: Colors.redAccent,
//             //       ),
//             //     ),
//             //     onPressed: () {
//             //       Navigator.of(context).pop();
//             //     },
//             //   ),
//             //   FlatButton(
//             //     child: new Text(
//             //       "Confirm",
//             //       style: TextStyle(color: Colors.blueAccent),
//             //     ),
//             //     onPressed: () {
//             //       setState(() {
//             //         scheduleType = val;
//             //         MySharedPreferences.instance.setDoctorScheduleType(
//             //             'doctorScheduleType', scheduleType);
//             //         changeAvailabilityScheduleConfirmNotifier.changeAvailabilityConfirm(
//             //           doctorId,
//             //           scheduleType,
//             //         );
//             //       });
//             //       Navigator.of(context).pop();
//             //       Navigator.of(context).pop();
//             //     },
//             //   ),
//             // ],
//           ),
//         );
//       },
//     );
//   }
//
