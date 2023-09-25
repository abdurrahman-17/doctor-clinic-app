import 'package:doctor_clinic_token_app/View/Add%20Availability/time_and_token_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/time_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/token_tab_screen.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDelete/availabilityDeleteNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDeleteConfirm/availabilityDeleteConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/listofavailability/listofavailabilityNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ListOfAVilability extends StatefulWidget {
  const ListOfAVilability({Key? key}) : super(key: key);

  @override
  _ListOfAVilabilityState createState() => _ListOfAVilabilityState();
}

class Tech {
  String label;

  Tech(this.label);
}

class _ListOfAVilabilityState extends State<ListOfAVilability> {
  ListOfAvailabilityNotifier listOfAvailability = ListOfAvailabilityNotifier();
  AvailabilityDeleteNotifier availabilityDeleteList =
      AvailabilityDeleteNotifier();
  AvailabilityDeleteConfirmNotifier availabilityDeleteConfirm =
      AvailabilityDeleteConfirmNotifier();
  int ismonSwitched = 0;
  int istueSwitched = 0;
  int iswedSwitched = 0;
  int isthuSwitched = 0;
  int isfriSwitched = 0;
  int issatSwitched = 0;
  int issunSwitched = 0;
  int doctorId = 0;
  int navigateBackCount = 0;
  int scheduleType = 0;
  Map dayName = {};
  List sortedDay = [];

  final reasonController = TextEditingController();

  // String? Dates ;
  List<String> Time = [];
  String fromTime = "";

  // String? toTime;
  String formatted = "";

  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    MySharedPreferences.instance
        .getDoctorScheduleType('doctorScheduleType')
        .then((value) {
      setState(() {
        scheduleType = value;
        print(scheduleType);
      });
    });
    Future.delayed(Duration.zero, () {
      listOfAvailability
          .listAvailabilty(doctorId, 'null', 'null')
          .then((value) {
        listOfAvailability.notifyListeners();

        for (int i = 0;
            i < listOfAvailability.listOfAvailabilityClass.length;
            i++) {
          if (listOfAvailability.listOfAvailabilityClass[i].days == 'mon') {
            dayName['mon'] = {'id': 1, 'name': 'Monday'};
          } else if (listOfAvailability.listOfAvailabilityClass[i].days ==
              'tue') {
            dayName['tue'] = {'id': 2, 'name': 'Tuesday'};
          } else if (listOfAvailability.listOfAvailabilityClass[i].days ==
              'wed') {
            dayName['wed'] = {'id': 3, 'name': 'Wednesday'};
          } else if (listOfAvailability.listOfAvailabilityClass[i].days ==
              'thu') {
            dayName['thu'] = {'id': 4, 'name': 'Thursday'};
          } else if (listOfAvailability.listOfAvailabilityClass[i].days ==
              'fri') {
            dayName['fri'] = {'id': 5, 'name': 'Friday'};
          } else if (listOfAvailability.listOfAvailabilityClass[i].days ==
              'sat') {
            dayName['sat'] = {'id': 6, 'name': 'Saturday'};
          } else if (listOfAvailability.listOfAvailabilityClass[i].days ==
              'sun') {
            dayName['sun'] = {'id': 7, 'name': 'Sunday'};
          }
        }

        dayName.values.forEach((k) {
          sortedDay.add(k['id']);
        });

        sortedDay = sortedDay..sort();
      });
    });
    date();
    super.initState();
  }

  void date() {
    // final DateFormat formatter=DateFormat("dd-MMMM-yyy");
    // formatted=formatter.format(Dates);
    // print(formatted);

    var inputFormat = DateFormat('HH:mm:ss');
    var inputDate = inputFormat.parse('19:00:00'); // <-- dd/MM 24H format

    var outputFormat = DateFormat('hh:mm a');
    fromTime = outputFormat.format(inputDate);
    // toTime = outputFormat.format(inputDate);
    print('Hello');
    print(Time);
    print(fromTime); // 12/31/2000 11:59 PM <-- MM/dd 12H format
    // print(toTime);
  }

  List<String> chips = <String>[];

  final List<Tech> _chipsList = <Tech>[
    Tech("M"),
    Tech("T"),
    Tech("W"),
    Tech("T"),
    Tech("F"),
    Tech("S"),
    Tech("S"),
  ];

  void _showConnectionState() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () {
            //connection == false ? Navigator.pop(context) : false;
            return Future.value(false);
          },
          child: AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Networkcheck().check().then((value) {
                      print(value);
                      if (value == true) {
                        Future.delayed(Duration.zero, () {
                          listOfAvailability
                              .listAvailabilty(doctorId, 'null', 'null')
                              .then((value) {
                            listOfAvailability.notifyListeners();
                            // for (int i = 0; i < provider.listOfAvailabilityClass.length; i++) {
                            //   Time = provider.listOfAvailabilityClass[i].fromTime as List<String>;
                            //   // print('Abdul');
                            //   // print(provider.listOfAvailabilityClass[i].fromTime.toString());
                            //   // print('why');
                            //   print('hellksdnjcfn');
                            //   //print(provider.listOfAvailabilityClass[i].finalDays);
                            //   print('dskjdvcn');
                            // }
                          });
                        });
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'Retry',
                  ))
            ],
            title: const Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              "Please Check the internet connection",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<ListOfAvailabilityNotifier>(
      builder: (context, provider, _) {
        this.listOfAvailability = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: SafeArea(
            child: Scaffold(
              body: buildBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/Home screen.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.22
              : MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          children: [
            backButton(context),
            const SizedBox(
              height: 40,
            ),
            listViewBuilder(context),
            //sevenDaysCard(context),
          ],
        ),
      ],
    );
  }

  Widget backButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 15.0),
      child: Row(children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'List of Availability',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 25,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      scheduleType == 1
                          ? const TimeTabScreen()
                          : const TokenTabScreen(),
                ),
              );
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            child: const Text(
              'Add New',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget headingText(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, right: 25),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 25,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TimeAndTokenScreen(),
                ),
              );
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Color(0xff6EA7FA),
                  width: 2,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            child: const Text(
              'Add New Availability',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xff6EA7FA),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sevenDaysCard(context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //mondayCard(context),
            // tuesdayCard(context),
            // wednesdayCard(context),
            // thursdayCard(context),
            // fridayCard(context),
            // saturdayCard(context),
            // sundayCard(context),
          ],
        ),
      ),
    );
  }

  // Widget mondayCard(context) {
  //   return provider.listOfAvailabilityClass.mon!.session!.isEmpty ? Container() :Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.mon!.session!.isEmpty ? '' : provider.listOfAvailabilityClass.mon!.days
  //               .toString() ,
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Monday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   for(var item in provider.listOfAvailabilityClass.mon!.session! )
  //                       Text(
  //                        item,
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                   const Spacer(),
  //                   IconButton(
  //                     onPressed: null,
  //                     icon: Icon(
  //                       Icons.delete,
  //                       size: 30,
  //                       color: Colors.redAccent,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget tuesdayCard(context) {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.tue!.scheduleName == null
  //                         ? '---'
  //                         : provider.listOfAvailabilityClass.tue!.scheduleName
  //                             .toString(),
  //                     // provider.listOfAvailabilityClass[index].scheduleName
  //                     //     .toString(),
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Tuesday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         fromTime + ' - ' + '09:00 PM',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(
  //                         provider.listOfAvailabilityClass.tue!.updatedAt ==
  //                                 null
  //                             ? '---'
  //                             : provider.listOfAvailabilityClass.tue!.updatedAt
  //                                 .toString(),
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   FlutterSwitch(
  //                     width: 45,
  //                     height: 22,
  //                     toggleSize: 15,
  //                     value: provider.listOfAvailabilityClass.tue!.status == 0
  //                         ? false
  //                         : true,
  //                     onToggle: (value) {
  //                       if (value == false) {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.tue!.status = 0;
  //                           isthuSwitched = 0;
  //                           provider.listAvailabilty(
  //                               doctorId, 'tue', isthuSwitched.toString());
  //                         });
  //                       } else {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.tue!.status = 1;
  //                           isthuSwitched = 1;
  //                           provider.listAvailabilty(
  //                               doctorId, 'tue', isthuSwitched.toString());
  //                         });
  //                       }
  //                     },
  //                     borderRadius: 7,
  //                     activeColor: Color(0xff5A95FD),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget wednesdayCard(context) {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.wed!.scheduleName == null
  //                         ? '---'
  //                         : provider.listOfAvailabilityClass.wed!.scheduleName
  //                             .toString(),
  //                     // provider.listOfAvailabilityClass[index].scheduleName
  //                     //     .toString(),
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Wednesday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         fromTime + ' - ' + '09:00 PM',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(
  //                         provider.listOfAvailabilityClass.wed!.updatedAt ==
  //                                 null
  //                             ? '---'
  //                             : provider.listOfAvailabilityClass.wed!.updatedAt
  //                                 .toString(),
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   FlutterSwitch(
  //                     width: 45,
  //                     height: 22,
  //                     toggleSize: 15,
  //                     value: provider.listOfAvailabilityClass.wed!.status == 0
  //                         ? false
  //                         : true,
  //                     onToggle: (value) {
  //                       if (value == false) {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.wed!.status = 0;
  //                           isthuSwitched = 0;
  //                           provider.listAvailabilty(
  //                               doctorId, 'wed', isthuSwitched.toString());
  //                         });
  //                       } else {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.wed!.status = 1;
  //                           isthuSwitched = 1;
  //                           provider.listAvailabilty(
  //                               doctorId, 'wed', isthuSwitched.toString());
  //                         });
  //                       }
  //                     },
  //                     borderRadius: 7,
  //                     activeColor: Color(0xff5A95FD),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget thursdayCard(context) {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.thu!.scheduleName == null
  //                         ? '---'
  //                         : provider.listOfAvailabilityClass.thu!.scheduleName
  //                             .toString(),
  //                     // provider.listOfAvailabilityClass[index].scheduleName
  //                     //     .toString(),
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Thursday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         fromTime + ' - ' + '09:00 PM',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(
  //                         provider.listOfAvailabilityClass.thu!.updatedAt ==
  //                                 null
  //                             ? '---'
  //                             : provider.listOfAvailabilityClass.thu!.updatedAt
  //                                 .toString(),
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   FlutterSwitch(
  //                     width: 45,
  //                     height: 22,
  //                     toggleSize: 15,
  //                     value: provider.listOfAvailabilityClass.thu!.status == 0
  //                         ? false
  //                         : true,
  //                     onToggle: (value) {
  //                       if (value == false) {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.thu!.status = 0;
  //                           isthuSwitched = 0;
  //                           provider.listAvailabilty(
  //                               doctorId, 'thu', isthuSwitched.toString());
  //                         });
  //                       } else {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.thu!.status = 1;
  //                           isthuSwitched = 1;
  //                           provider.listAvailabilty(
  //                               doctorId, 'thu', isthuSwitched.toString());
  //                         });
  //                       }
  //                     },
  //                     borderRadius: 7,
  //                     activeColor: Color(0xff5A95FD),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget fridayCard(context) {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.fri!.scheduleName == null
  //                         ? '---'
  //                         : provider.listOfAvailabilityClass.fri!.scheduleName
  //                             .toString(),
  //                     // provider.listOfAvailabilityClass[index].scheduleName
  //                     //     .toString(),
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Friday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         fromTime + ' - ' + '09:00 PM',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(
  //                         provider.listOfAvailabilityClass.fri!.updatedAt ==
  //                                 null
  //                             ? '---'
  //                             : provider.listOfAvailabilityClass.fri!.updatedAt
  //                                 .toString(),
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   FlutterSwitch(
  //                     width: 45,
  //                     height: 22,
  //                     toggleSize: 15,
  //                     value: provider.listOfAvailabilityClass.fri!.status == 0
  //                         ? false
  //                         : true,
  //                     onToggle: (value) {
  //                       if (value == false) {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.fri!.status = 0;
  //                           isthuSwitched = 0;
  //                           provider.listAvailabilty(
  //                               doctorId, 'fri', isthuSwitched.toString());
  //                         });
  //                       } else {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.fri!.status = 1;
  //                           isthuSwitched = 1;
  //                           provider.listAvailabilty(
  //                               doctorId, 'fri', isthuSwitched.toString());
  //                         });
  //                       }
  //                     },
  //                     borderRadius: 7,
  //                     activeColor: Color(0xff5A95FD),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget saturdayCard(context) {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.sat!.scheduleName == null
  //                         ? '---'
  //                         : provider.listOfAvailabilityClass.sat!.scheduleName
  //                             .toString(),
  //                     // provider.listOfAvailabilityClass[index].scheduleName
  //                     //     .toString(),
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Saturday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         fromTime + ' - ' + '09:00 PM',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(
  //                         provider.listOfAvailabilityClass.sat!.updatedAt ==
  //                                 null
  //                             ? '---'
  //                             : provider.listOfAvailabilityClass.sat!.updatedAt
  //                                 .toString(),
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   FlutterSwitch(
  //                     width: 45,
  //                     height: 22,
  //                     toggleSize: 15,
  //                     value: provider.listOfAvailabilityClass.sat!.status == 0
  //                         ? false
  //                         : true,
  //                     onToggle: (value) {
  //                       if (value == false) {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.sat!.status = 0;
  //                           isthuSwitched = 0;
  //                           provider.listAvailabilty(
  //                               doctorId, 'sat', isthuSwitched.toString());
  //                         });
  //                       } else {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.sat!.status = 1;
  //                           isthuSwitched = 1;
  //                           provider.listAvailabilty(
  //                               doctorId, 'sat', isthuSwitched.toString());
  //                         });
  //                       }
  //                     },
  //                     borderRadius: 7,
  //                     activeColor: Color(0xff5A95FD),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget sundayCard(context) {
  //   return Padding(
  //     padding:
  //         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25, top: 10),
  //     child: GestureDetector(
  //       onTap: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => EditAvailability(
  //         //       schedulerName: provider
  //         //           .listOfAvailabilityClass[index].scheduleName ??
  //         //           "",
  //         //       slotTime:
  //         //       provider.listOfAvailabilityClass[index].slotTime ??
  //         //           "",
  //         //     ),
  //         //   ),
  //         // );
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff3284E5).withOpacity(0.25),
  //               blurRadius: 6,
  //               offset: const Offset(2, 2),
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     provider.listOfAvailabilityClass.sun!.scheduleName == null
  //                         ? '---'
  //                         : provider.listOfAvailabilityClass.sun!.scheduleName
  //                             .toString(),
  //                     // provider.listOfAvailabilityClass[index].scheduleName
  //                     //     .toString(),
  //                     style: TextStyle(fontSize: 18, color: Color(0xff959090)),
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.blueAccent,
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 5.0, horizontal: 10.0),
  //                       child: Text(
  //                         'Sunday',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               //weekDaySelect(context, index),
  //               // const Padding(
  //               //   padding: EdgeInsets.symmetric(vertical: 5.0),
  //               //   child: Divider(
  //               //     thickness: 1,
  //               //     color: Color(0xffC4C4C4),
  //               //   ),
  //               // ),
  //
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         fromTime + ' - ' + '09:00 PM',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       Text(
  //                         provider.listOfAvailabilityClass.sun!.updatedAt ==
  //                                 null
  //                             ? '---'
  //                             : provider.listOfAvailabilityClass.sun!.updatedAt
  //                                 .toString(),
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   FlutterSwitch(
  //                     width: 45,
  //                     height: 22,
  //                     toggleSize: 15,
  //                     value: provider.listOfAvailabilityClass.sun!.status == 0
  //                         ? false
  //                         : true,
  //                     onToggle: (value) {
  //                       if (value == false) {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.sun!.status = 0;
  //                           isthuSwitched = 0;
  //                           provider.listAvailabilty(
  //                               doctorId, 'sun', isthuSwitched.toString());
  //                         });
  //                       } else {
  //                         setState(() {
  //                           provider.listOfAvailabilityClass.sun!.status = 1;
  //                           isthuSwitched = 1;
  //                           provider.listAvailabilty(
  //                               doctorId, 'sun', isthuSwitched.toString());
  //                         });
  //                       }
  //                     },
  //                     borderRadius: 7,
  //                     activeColor: Color(0xff5A95FD),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget listViewBuilder(context) {
    return Expanded(
      child: sortedDay.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.event_busy,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'No Availability Added Yet',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedDay.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 25, right: 25, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditAvailability(
                      //       scheduleDay: provider
                      //                   .listOfAvailabilityClass[index].days ==
                      //               'mon'
                      //           ? "Monday"
                      //           : provider.listOfAvailabilityClass[index].days ==
                      //                   'tue'
                      //               ? 'Tuesday'
                      //               : provider.listOfAvailabilityClass[index].days ==
                      //                       'wed'
                      //                   ? 'Wednesday'
                      //                   : provider.listOfAvailabilityClass[index]
                      //                               .days ==
                      //                           'thu'
                      //                       ? 'Thursday'
                      //                       : provider.listOfAvailabilityClass[index]
                      //                                   .days ==
                      //                               'fri'
                      //                           ? 'Friday'
                      //                           : provider
                      //                                       .listOfAvailabilityClass[
                      //                                           index]
                      //                                       .days ==
                      //                                   'sat'
                      //                               ? 'Saturday'
                      //                               : 'Sunday',
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff3284E5).withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sortedDay[index] == 1
                                  ? "Monday"
                                  : sortedDay[index] == 2
                                      ? 'Tuesday'
                                      : sortedDay[index] == 3
                                          ? 'Wednesday'
                                          : sortedDay[index] == 4
                                              ? 'Thursday'
                                              : sortedDay[index] == 5
                                                  ? 'Friday'
                                                  : sortedDay[index] == 6
                                                      ? 'Saturday'
                                                      : 'Sunday',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                availabilityDeleteList.avialbilityDelete(
                                  doctorId,
                                  sortedDay[index] == 1
                                      ? "mon"
                                      : sortedDay[index] == 2
                                          ? 'tue'
                                          : sortedDay[index] == 3
                                              ? 'wed'
                                              : sortedDay[index] == 4
                                                  ? 'thu'
                                                  : sortedDay[index] == 5
                                                      ? 'fri'
                                                      : sortedDay[index] == 6
                                                          ? 'sat'
                                                          : 'sun',
                                );
                                listOfPatient(
                                    context,
                                    sortedDay[index] == 1
                                        ? "mon"
                                        : sortedDay[index] == 2
                                            ? 'tue'
                                            : sortedDay[index] == 3
                                                ? 'wed'
                                                : sortedDay[index] == 4
                                                    ? 'thu'
                                                    : sortedDay[index] == 5
                                                        ? 'fri'
                                                        : sortedDay[index] == 6
                                                            ? 'sat'
                                                            : 'sun');
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Widget weekDaySelect(context, int index) {
  //   return Center(
  //     child: SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.08,
  //       child: ListView.builder(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: provider.listOfAvailabilityClass[index].finalDays!.length,
  //         itemBuilder: (context, index2) {
  //           return Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 3.0, vertical: 5.0),
  //                 child: Container(
  //                   height: 35,
  //                   width: 35,
  //                   decoration: BoxDecoration(
  //                     color: Colors.blue,
  //                     borderRadius: BorderRadius.circular(50),
  //                   ),
  //                   child: Center(
  //                     child: FittedBox(
  //                       child: Text(
  //                         provider.listOfAvailabilityClass[index]
  //                             .finalDays![index2],
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Wrap(
  // direction: Axis.horizontal,
  // children: listChip.toList(),
  // );
  Iterable<Widget> get listChip sync* {
    for (final Tech chip in _chipsList) {
      yield FilterChip(
        label: Container(
          height: 25,
          width: 20,
          child: Center(
            child: Text(
              chip.label,
              style: TextStyle(
                fontSize: 12,
                color: chips.contains(chip.label)
                    ? Colors.white
                    : const Color(0xff68A0F8),
              ),
            ),
          ),
        ),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: Color(0xff68A0F8), width: 2)),
        backgroundColor: Colors.transparent,
        selectedColor: const Color(0xff68A0F8),
        showCheckmark: false,
        selected: chips.contains(chip.label),
        onSelected: (bool value) {
          setState(
            () {
              if (value) {
                chips.add(chip.label);
              } else {
                chips.removeWhere((String name) {
                  return name == chip.label;
                });
              }
            },
          );
        },
      );
    }
  }

  listOfPatient(context, String day) {
    Future.delayed(Duration.zero, () {
      availabilityDeleteList.avialbilityDelete(
        doctorId,
        day,
      );
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration.zero, () {
          availabilityDeleteList.avialbilityDelete(
            doctorId,
            day,
          );
        });
        return Consumer<AvailabilityDeleteNotifier>(
          builder: (context, provider, _) {
            availabilityDeleteList = provider;
            return ModalProgressHUD(
              inAsyncCall: provider.isLoading,
              color: Colors.transparent,
              child: AlertDialog(
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      headingDialog(context),
                      const SizedBox(
                        height: 25,
                      ),
                      totalPatientBooked(context),
                      const SizedBox(
                        height: 20,
                      ),
                      bookedPatientList(context),
                      const SizedBox(
                        height: 30,
                      ),
                      confirmTitle(context),
                      const SizedBox(
                        height: 20,
                      ),
                      submitAndCancelButton(context, day),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget addReason(context) {
    return const Text(
      'Add Reason',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget headingDialog(context) {
    return const Text(
      'Patient Booked On This Date',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget totalPatientBooked(context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Total Booked Patient : ' +
            availabilityDeleteList.avialbilityDeleteClass.length.toString(),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget bookedPatientList(context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: availabilityDeleteList.avialbilityDeleteClass.isEmpty
            ? const Center(
                child: Text('No Patient Booked'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: availabilityDeleteList.avialbilityDeleteClass.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffCAE7FC),
                            offset: Offset(0, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  availabilityDeleteList
                                      .avialbilityDeleteClass[index].patientName
                                      .toString(),
                                  // provider1
                                  //     .todayConsultationClass[index].patientName
                                  //     .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.local_hospital,
                                  size: 18,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  availabilityDeleteList
                                      .avialbilityDeleteClass[index]
                                      .mobileNumber
                                      .toString(),
                                  // provider1
                                  //     .todayConsultationClass[index].patientName
                                  //     .toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget confirmTitle(context) {
    return Text(
      "Are you sure you want to Cancel the Appointments on this date?",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey.shade700),
    );
  }

  Widget submitAndCancelButton(context, String day) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 18,
              color: Colors.redAccent,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: const Text(
            "Confirm",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            availabilityDeleteConfirm.availabilityDeleteConfirm(
              doctorId,
              day,
            );
            // Navigator.of(context).popUntil((route) => navigateBackCount++ >= 1);
          },
        ),
      ],
    );
  }

  reasonBox(context, String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalProgressHUD(
          inAsyncCall: listOfAvailability.isLoading,
          color: Colors.transparent,
          child: AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  addReason(context),
                  const SizedBox(
                    height: 35,
                  ),
                  reasonField(context),
                  const SizedBox(
                    height: 30,
                  ),
                  submitReasonButton(context, day)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget reasonField(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffCAE7FC),
            offset: Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: reasonController,
        //validator: validateText,
        maxLines: 5,
        maxLength: 200,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintText: 'Reason',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget submitReasonButton(context, String day) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
          child: const Text(
            "Submit",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            availabilityDeleteConfirm.availabilityDeleteConfirm(
              doctorId,
              day,
            );
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OutOfOffice()));
          },
        ),
      ],
    );
  }
}
