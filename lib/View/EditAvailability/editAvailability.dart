import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/time_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/token_tab_screen.dart';
import 'package:doctor_clinic_token_app/core/request_response/timedoctorschedule/timedoctorscheduleNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditAvailability extends StatefulWidget {
  final scheduleDay;

  const EditAvailability({
    Key? key,
    this.scheduleDay,
  }) : super(key: key);

  @override
  _EditAvailabilityState createState() => _EditAvailabilityState();
}

class Tech {
  String label;

  Tech(this.label);
}

class _EditAvailabilityState extends State<EditAvailability> {
  bool isSwitched = false;
  bool textField1 = true;
  bool textField2 = false;
  bool textField3 = false;
  bool textField4 = false;
  bool morningCheck = false;
  bool afternoonCheck = false;
  bool eveningCheck = false;
  bool nightCheck = false;
  String checkTime1 = '';
  String checkTime2 = '';
  String checkTime3 = '';
  String checkTime4 = '';

  TimeOfDay? startTime1 = const TimeOfDay(hour: 08, minute: 0);
  TimeOfDay? startTime2 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? startTime3 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? startTime4 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime1 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? endTime2 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? endTime3 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime4 = const TimeOfDay(hour: 22, minute: 0);
  final _schedulerController = TextEditingController();
  final _slotTimeController = TextEditingController();
  final slotPerMembers = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  late TimeDoctorScheduleNotifier? timeDoctorScheduleNotifier;

  List<String> chips = [];

  final List<Tech> _chipsList = <Tech>[
    Tech("mon"),
    Tech("tue"),
    Tech("wed"),
    Tech("thu"),
    Tech("fri"),
    Tech("sat"),
    Tech("sun"),
  ];

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  String? dropDownValue = '15 min';

  var slotTimeItems = [
    '15 min',
    '30 min',
    '1 hour',
  ];

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    // TODO: implement initState
    super.initState();
    setState(() {
      // _schedulerController.text = widget.schedulerName.toString();
      // _slotTimeController.text = widget.slotTime.toString();
      // slotPerMembers.text = widget.slotPerMember.toString();
    });
  }

  _showEndTime1(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endTime1!,
    );
    if (newtime != null) {
      setState(() {
        endTime1 = newtime;
      });
    }
  }

  _showEndTime2(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: startTime2!,
    );
    if (newtime != null) {
      setState(() {
        endTime2 = newtime;
      });
    }
  }

  _showEndTime3(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: startTime3!,
    );
    if (newtime != null) {
      setState(() {
        endTime3 = newtime;
      });
    }
  }

  _showEndTime4(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: startTime4!,
    );
    if (newtime != null) {
      setState(() {
        endTime4 = newtime;
      });
    }
  }

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
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'Retry',
                  ))
            ],
            title: Text(
              "No Internet Connection",
              style: const TextStyle(color: Colors.black),
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
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage(
              'assets/verysmall.png',
            ),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              backButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              headingTextAndViewButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              // tabBarControl(context),
              // const SizedBox(
              //   height: 20,
              // ),
              // tabBarChild(context),
              dayText(context),
              const SizedBox(
                height: 35,
              ),
              schedulerTxtfield(context),
              const SizedBox(
                height: 35,
              ),
              slotTokenField(context),
              const SizedBox(
                height: 35,
              ),
              slotPerMember(context),
              const SizedBox(
                height: 50,
              ),
              // sameEveryDaySwitch(context),
              // const SizedBox(
              //   height: 40,
              // ),
              const Text(
                'Consulting Time',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              morningStartAndEnd(context),
              const SizedBox(
                height: 10,
              ),
              afternoonStartAndEnd2(context),
              const SizedBox(
                height: 10,
              ),
              eveningStartAndEnd3(context),
              const SizedBox(
                height: 10,
              ),
              nightStartAndEnd4(context),
              const SizedBox(
                height: 45,
              ),
              // weekDaySelect(context),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.03,
              // ),
              submitButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
      child: Row(
        children: [
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
            'Add Availability',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget headingTextAndViewButton(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 25,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutePaths.ListAvailability);
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
              'View Availability',
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

  Widget tabBarControl(context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff68A1F8), width: 2),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TabBar(
          tabs: const [
            Tab(
              text: 'Time Based',
            ),
            Tab(
              text: 'Token Based',
            ),
          ],
          indicator: BoxDecoration(
            color: const Color(0xff68A1F8),
            borderRadius: BorderRadius.circular(35),
          ),
          unselectedLabelColor: const Color(0xff68A0F8),
        ),
      ),
    );
  }

  Widget tabBarChild(context) {
    return const Flexible(
      child: TabBarView(
        children: [
          TimeTabScreen(),
          TokenTabScreen(),
        ],
      ),
    );
  }

  Widget dayText(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Text(
          widget.scheduleDay,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget schedulerTxtfield(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Scheduler',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: _schedulerController,
              decoration: const InputDecoration(
                hintText: 'Time #1',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff69A1F8),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff69A1F8),
                    width: 2,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget slotTokenField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Slot Time',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            width: 150,
            height: 47,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff68A1F8), width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: dropDownValue,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value;
                    });
                  },
                  items: slotTimeItems.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget slotPerMember(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Slot Per Member',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: _slotTimeController,
              decoration: const InputDecoration(
                hintText: '5 Member',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff69A1F8),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff69A1F8),
                    width: 2,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sameEveryDaySwitch(context) {
    return Container(
      height: 55,
      width: 260,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff68A1F8), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            const Text(
              'Same Every Day',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            FlutterSwitch(
              width: 45,
              height: 22,
              toggleSize: 15,
              value: isSwitched,
              onToggle: toggleSwitch,
              borderRadius: 7,
              activeColor: const Color(0xff68A1F8),
            ),
          ],
        ),
      ),
    );
  }

  Widget morningStartAndEnd(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blueAccent,
        value: morningCheck,
        onChanged: (bool? value) {
          setState(() {
            morningCheck = value!;
          });
        },
      ),
      const Text(
        'Morning    :',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              startTime1!.format(context),
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: startTime1!,
          );
          if (newtime != null) {
            setState(() {
              startTime1 = newtime;
              checkTime1 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('To'),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              endTime1!.format(context),
            ),
          ),
        ),
        onTap: () async {
          checkTime1 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime1(context);
        },
      ),
    ]);

    // textField1 == true
    //   ?
    //         textField2 == true && textField3 == true && textField4 == true
    //             ? IconButton(
    //                 onPressed: null,
    //                 icon: Icon(
    //                   Icons.add_circle_outline,
    //                   color: Colors.transparent,
    //                   size: 30,
    //                 ),
    //               )
    //             : IconButton(
    //                 onPressed: () {
    //                   if (textField2 == true && textField3 == true) {
    //                     setState(() {
    //                       textField4 = true;
    //                     });
    //                   } else if (textField2 == true) {
    //                     setState(() {
    //                       textField3 = true;
    //                     });
    //                   } else {
    //                     setState(() {
    //                       textField2 = true;
    //                     });
    //                   }
    //                 },
    //                 icon: Icon(
    //                   Icons.add_circle_outline,
    //                   color: Colors.blueAccent,
    //                   size: 30,
    //                 ),
    //               ),
    //       ],
    //     )
    //   : Container();
  }

  Widget afternoonStartAndEnd2(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Checkbox(
        checkColor: Colors.white,
        value: afternoonCheck,
        activeColor: Colors.blueAccent,
        onChanged: (bool? value) {
          setState(() {
            afternoonCheck = value!;
          });
        },
      ),
      const Text(
        'Afternoon :',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              startTime2!.format(context),
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: startTime2!,
          );
          if (newtime != null) {
            setState(() {
              startTime2 = newtime;
              checkTime2 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('To'),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              endTime2!.format(context),
            ),
          ),
        ),
        onTap: () async {
          checkTime2 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime2(context);
        },
      ),
    ]);

    // textField2 == true
    //   ? Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         GestureDetector(
    //           child: Container(
    //             height: 35,
    //             width: 85,
    //             decoration: BoxDecoration(
    //               border:
    //                   Border.all(color: const Color(0xff68A1F8), width: 2),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 startTime!.format(context),
    //               ),
    //             ),
    //           ),
    //           onTap: () async {
    //             TimeOfDay? newtime = await showTimePicker(
    //               context: context,
    //               initialTime: startTime!,
    //             );
    //             if (newtime != null) {
    //               setState(() {
    //                 startTime = newtime;
    //               });
    //             }
    //           },
    //         ),
    //         const SizedBox(
    //           width: 20,
    //         ),
    //         const Text('To'),
    //         const SizedBox(
    //           width: 20,
    //         ),
    //         GestureDetector(
    //           child: Container(
    //             height: 35,
    //             width: 85,
    //             decoration: BoxDecoration(
    //               border:
    //                   Border.all(color: const Color(0xff68A1F8), width: 2),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 endTime!.format(context),
    //               ),
    //             ),
    //           ),
    //           onTap: () async {
    //             TimeOfDay? newtime = await showTimePicker(
    //               context: context,
    //               initialTime: endTime!,
    //             );
    //             if (newtime != null) {
    //               setState(() {
    //                 endTime = newtime;
    //               });
    //             }
    //           },
    //         ),
    //         textField2 == true
    //             ? IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     textField2 = false;
    //                   });
    //                 },
    //                 icon: Icon(
    //                   Icons.cancel_outlined,
    //                   color: Colors.blueAccent,
    //                   size: 30,
    //                 ),
    //               )
    //             : Container(),
    //       ],
    //     )
    //   : Container();
  }

  Widget eveningStartAndEnd3(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blueAccent,
        value: eveningCheck,
        onChanged: (bool? value) {
          setState(() {
            eveningCheck = value!;
          });
        },
      ),
      const Text(
        'Evening     :',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              startTime3!.format(context),
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: startTime3!,
          );
          if (newtime != null) {
            setState(() {
              startTime3 = newtime;
              checkTime3 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('To'),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              endTime3!.format(context),
            ),
          ),
        ),
        onTap: () async {
          checkTime3 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime3(context);
        },
      ),
    ]);

    // textField3 == true
    //     ? Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           GestureDetector(
    //             child: Container(
    //               height: 35,
    //               width: 85,
    //               decoration: BoxDecoration(
    //                 border:
    //                     Border.all(color: const Color(0xff68A1F8), width: 2),
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text(
    //                   startTime!.format(context),
    //                 ),
    //               ),
    //             ),
    //             onTap: () async {
    //               TimeOfDay? newtime = await showTimePicker(
    //                 context: context,
    //                 initialTime: startTime!,
    //               );
    //               if (newtime != null) {
    //                 setState(() {
    //                   startTime = newtime;
    //                 });
    //               }
    //             },
    //           ),
    //           const SizedBox(
    //             width: 20,
    //           ),
    //           const Text('To'),
    //           const SizedBox(
    //             width: 20,
    //           ),
    //           GestureDetector(
    //             child: Container(
    //               height: 35,
    //               width: 85,
    //               decoration: BoxDecoration(
    //                 border:
    //                     Border.all(color: const Color(0xff68A1F8), width: 2),
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text(
    //                   endTime!.format(context),
    //                 ),
    //               ),
    //             ),
    //             onTap: () async {
    //               TimeOfDay? newtime = await showTimePicker(
    //                 context: context,
    //                 initialTime: endTime!,
    //               );
    //               if (newtime != null) {
    //                 setState(() {
    //                   endTime = newtime;
    //                 });
    //               }
    //             },
    //           ),
    //           textField3 == true
    //               ? IconButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       textField3 = false;
    //                     });
    //                   },
    //                   icon: Icon(
    //                     Icons.cancel_outlined,
    //                     color: Colors.blueAccent,
    //                     size: 30,
    //                   ),
    //                 )
    //               : Container(),
    //         ],
    //       )
    //     : Container();
  }

  Widget nightStartAndEnd4(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Checkbox(
        checkColor: Colors.white,
        value: nightCheck,
        activeColor: Colors.blueAccent,
        onChanged: (bool? value) {
          setState(() {
            nightCheck = value!;
          });
        },
      ),
      const Text(
        'Night         :',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              startTime4!.format(context),
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: startTime4!,
          );
          if (newtime != null) {
            setState(() {
              startTime4 = newtime;
              checkTime4 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('To'),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Container(
          height: 35,
          width: 85,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff68A1F8), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              endTime4!.format(context),
            ),
          ),
        ),
        onTap: () async {
          checkTime4 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime4(context);
        },
      ),
    ]);

    // textField4 == true
    //   ? Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         GestureDetector(
    //           child: Container(
    //             height: 35,
    //             width: 85,
    //             decoration: BoxDecoration(
    //               border:
    //                   Border.all(color: const Color(0xff68A1F8), width: 2),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 startTime!.format(context),
    //               ),
    //             ),
    //           ),
    //           onTap: () async {
    //             TimeOfDay? newtime = await showTimePicker(
    //               context: context,
    //               initialTime: startTime!,
    //             );
    //             if (newtime != null) {
    //               setState(() {
    //                 startTime = newtime;
    //               });
    //             }
    //           },
    //         ),
    //         const SizedBox(
    //           width: 20,
    //         ),
    //         const Text('To'),
    //         const SizedBox(
    //           width: 20,
    //         ),
    //         GestureDetector(
    //           child: Container(
    //             height: 35,
    //             width: 85,
    //             decoration: BoxDecoration(
    //               border:
    //                   Border.all(color: const Color(0xff68A1F8), width: 2),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 endTime!.format(context),
    //               ),
    //             ),
    //           ),
    //           onTap: () async {
    //             TimeOfDay? newTime = await showTimePicker(
    //               context: context,
    //               initialTime: endTime!,
    //             );
    //             if (newTime != null) {
    //               setState(() {
    //                 endTime = newTime;
    //               });
    //             }
    //           },
    //         ),
    //         textField4 == true
    //             ? IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     textField4 = false;
    //                   });
    //                 },
    //                 icon: Icon(
    //                   Icons.cancel_outlined,
    //                   color: Colors.blueAccent,
    //                   size: 30,
    //                 ),
    //               )
    //             : Container(),
    //       ],
    //     )
    //   : Container();
  }

  Widget weekDaySelect(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: listChip.toList(),
      ),
    );
  }

  Widget submitButton(context) {
    timeDoctorScheduleNotifier =
        Provider.of<TimeDoctorScheduleNotifier?>(context, listen: false);
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton(
        style: getButtonStyle(context),
        onPressed: () async {
          final now = DateTime.now();
          final st1 = DateTime(now.year, now.month, now.day, startTime1!.hour,
              startTime1!.minute);
          final st12 = DateTime(now.year, now.month, now.day, startTime2!.hour,
              startTime2!.minute);
          final st3 = DateTime(now.year, now.month, now.day, startTime3!.hour,
              startTime3!.minute);
          final st4 = DateTime(now.year, now.month, now.day, startTime4!.hour,
              startTime4!.minute);
          final et1 = DateTime(
              now.year, now.month, now.day, endTime1!.hour, endTime1!.minute);
          final et2 = DateTime(
              now.year, now.month, now.day, endTime2!.hour, endTime2!.minute);
          final et3 = DateTime(
              now.year, now.month, now.day, endTime3!.hour, endTime3!.minute);
          final et4 = DateTime(
              now.year, now.month, now.day, endTime4!.hour, endTime4!.minute);
          final Time = DateFormat('HH:mm'); //"6:00 AM"

          timeDoctorScheduleNotifier?.timeDoctorSchedule(
              1,
              _schedulerController.text,
              int.parse(_slotTimeController.text),
              1,
              Time.format(st1).toString(),
              Time.format(et1).toString(),
              chips);
        },
        child: Text(
          'Submit',
          style: TextButtonStyle(context),
        ),
      ),
    );
  }

  Iterable<Widget> get listChip sync* {
    for (final Tech chip in _chipsList) {
      yield Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: FilterChip(
          label: Container(
            height: 45,
            width: 30,
            child: Center(
              child: FittedBox(
                child: Text(
                  chip.label,
                  style: TextStyle(
                    fontSize: 16,
                    color: chips.contains(chip.label)
                        ? Colors.white
                        : const Color(0xff68A0F8),
                  ),
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Color(0xff68A0F8), width: 2)),
          backgroundColor: Colors.transparent,
          selectedColor: const Color(0xff68A0F8),
          showCheckmark: false,
          selected: chips.contains(chip.label),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                chips.add(chip.label);
              } else {
                chips.removeWhere((String name) {
                  return name == chip.label;
                });
              }
            });
          },
        ),
      );
    }
  }
}
