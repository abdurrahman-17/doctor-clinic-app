import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/View/List%20Of%20Availability/list_availability.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctorSchedule/addDoctorScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDaysStatus/availabilityDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusResponse.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TimeTabScreen extends StatefulWidget {
  const TimeTabScreen({Key? key}) : super(key: key);

  @override
  _TimeTabScreenState createState() => _TimeTabScreenState();
}

class Tech {
  String label;

  Tech(this.label);
}

class _TimeTabScreenState extends State<TimeTabScreen> {
  AvailabilityDayStatusNotifier provider = AvailabilityDayStatusNotifier();
  bool isSwitched = false;
  bool morningCheck = false;
  bool afternoonCheck = false;
  bool eveningCheck = false;
  bool nightCheck = false;
  int doctorId = 0;
  int doctorScheduleType = 1;
  int convertedMorningMinutes = 0;
  int convertedAfternoonMinutes = 0;
  int convertedEveningMinutes = 0;
  int convertedNightMinutes = 0;

  TimeOfDay? startTime1 = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay? startTime2 = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? startTime3 = TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? startTime4 = TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime1 = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? endTime2 = TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? endTime3 = TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime4 = TimeOfDay(hour: 22, minute: 0);
  final _schedulerController = TextEditingController();
  final _slotTimeController = TextEditingController();
  final _slotPerMemberController = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  AddDoctorScheduleNotifier addDoctorScheduleNotifier =
      AddDoctorScheduleNotifier();
  DoctorScheduleDayStatusNotifier doctorScheduleDayStatusNotifier =
      DoctorScheduleDayStatusNotifier();

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
  String? finaldropDownValue;
  String checkStartTime1 = '';
  String checkEndTime1 = '';
  String checkStartTime2 = '';
  String checkEndTime2 = '';
  String checkStartTime3 = '';
  String checkEndTime3 = '';
  String checkStartTime4 = '';
  String checkEndTime4 = '';

  var slotTimeItems = [
    '15 min',
    '30 min',
    '1 hour',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
      Future.delayed(Duration.zero, () {
        doctorScheduleDayStatusNotifier
            .doctorScheduleStatus(doctorId)
            .then((value) {
          doctorScheduleDayStatusNotifier.notifyListeners();
          print(doctorScheduleDayStatusNotifier.dayScheduleStatusClass[0].day);
        });
      });
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
        checkEndTime1 = newtime.toString();
      });
    }
  }

  _showEndTime2(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endTime2!,
    );
    if (newtime != null) {
      setState(() {
        endTime2 = newtime;
        checkEndTime2 = newtime.toString();
      });
    }
  }

  _showEndTime3(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endTime3!,
    );
    if (newtime != null) {
      setState(() {
        endTime3 = newtime;
        checkEndTime3 = newtime.toString();
      });
    }
  }

  _showEndTime4(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endTime4!,
    );
    if (newtime != null) {
      setState(() {
        endTime4 = newtime;
        checkEndTime4 = newtime.toString();
      });
    }
  }

  minutesConverterMorning(String start_time, String end_time) {
    if (start_time != '' && end_time != '') {
      var format = DateFormat("HH:mm");
      var start = format.parse(start_time);
      var end = format.parse(end_time);

      if (start.isAfter(end)) {
        end = end.add(Duration(days: 1));
        Duration diff = end.difference(start);
        convertedMorningMinutes = diff.inMinutes % 60;
        print(convertedAfternoonMinutes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<AddDoctorScheduleNotifier>(
      builder: (context, provider2, _) {
        addDoctorScheduleNotifier = provider2;
        return ModalProgressHUD(
          inAsyncCall: provider2.isLoading,
          color: Colors.transparent,
          child: SafeArea(
            child: Scaffold(
              body: mainBuildBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget mainBuildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage(
              'assets/Home screen.png',
            ),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.height * 0.22
                : MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              backButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              //selectionCheckBox(context),
              buildBody(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 0, left: 5.0, right: 15.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Add Availability',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Spacer(),
          SizedBox(
            height: 25,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ListOfAVilability(),
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
                'Availability',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
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
          height: 30,
        ),
        Text(
          'Consulting Time',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        morningStartAndEnd(context),
        SizedBox(
          height: 10,
        ),
        afternoonStartAndEnd2(context),
        SizedBox(
          height: 10,
        ),
        eveningStartAndEnd3(context),
        SizedBox(
          height: 10,
        ),
        nightStartAndEnd4(context),
        const SizedBox(
          height: 35,
        ),
        weekDaySelect(context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        submitButton(context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ],
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
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            height: 45,
            child: TextFormField(
              controller: _schedulerController,
              validator: validateText,
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
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: 150,
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 8),
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
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
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
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            height: 45,
            child: TextFormField(
              controller: _slotPerMemberController,
              validator: validateText,
              keyboardType: TextInputType.number,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
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
      Text(
        'Morning    :',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(
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
              style: TextStyle(
                color: checkStartTime1 == '' ? Colors.grey : Colors.black,
              ),
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
              checkStartTime1 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('to'),
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
              style: TextStyle(
                color: checkEndTime1 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          checkStartTime1 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
      Text(
        'Afternoon :',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(
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
              style: TextStyle(
                color: checkStartTime2 == '' ? Colors.grey : Colors.black,
              ),
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
              checkStartTime2 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('to'),
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
              style: TextStyle(
                color: checkEndTime2 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          checkStartTime2 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
    //         const Text('to'),
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
      Text(
        'Evening     :',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(
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
              style: TextStyle(
                color: checkStartTime3 == '' ? Colors.grey : Colors.black,
              ),
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
              checkStartTime3 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('to'),
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
              style: TextStyle(
                color: checkEndTime3 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          checkStartTime3 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
    //           const Text('to'),
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
      Text(
        'Night         :',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(
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
              style: TextStyle(
                color: checkStartTime4 == '' ? Colors.grey : Colors.black,
              ),
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
              checkStartTime4 = newtime.toString();
            });
          }
        },
      ),
      const SizedBox(
        width: 10,
      ),
      const Text('to'),
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
              style: TextStyle(
                color: checkEndTime4 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          checkStartTime4 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
    //         const Text('to'),
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
    return Consumer<DoctorScheduleDayStatusNotifier>(
      builder: (context, provider, _) {
        doctorScheduleDayStatusNotifier = provider;
        return doctorScheduleDayStatusNotifier.isLoading
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  children: listChip.toList(),
                ),
              );
      },
    );
  }

  Widget submitButton(context) {
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton(
        style: getButtonStyle(context),
        onPressed: () async {
          final now = new DateTime.now();
          final st1 = DateTime(now.year, now.month, now.day, startTime1!.hour,
              startTime1!.minute);
          final st2 = DateTime(now.year, now.month, now.day, startTime2!.hour,
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

          if (dropDownValue == '15 min') {
            finaldropDownValue = '15';
          } else if (dropDownValue == '30 min') {
            finaldropDownValue = '30';
          } else {
            finaldropDownValue = '1';
          }

          // print(finaldropDownValue);
          // print(chips);
          // print(st1);
          // print(st2);
          // print(st3);
          // print(
          //   Time.format(st4).toString(),
          // );
          //
          // print(morningCheck);
          // print(afternoonCheck);
          // print(eveningCheck);
          // print(nightCheck);
          //
          // print(int.parse(checkEndTime1.substring(10, 12)));
          // print(int.parse(checkStartTime1.substring(10, 12)));

          tokenBasedApiHit() {
            addDoctorScheduleNotifier.addDoctorSchedule(
              doctorId,
              _schedulerController.text,
              int.parse(finaldropDownValue!),
              doctorScheduleType,
              int.parse(_slotPerMemberController.text),
              morningCheck == true ? Time.format(st1).toString() : 'null',
              morningCheck == true ? Time.format(et1).toString() : 'null',
              afternoonCheck == true ? Time.format(st2).toString() : 'null',
              afternoonCheck == true ? Time.format(et2).toString() : 'null',
              eveningCheck == true ? Time.format(st3).toString() : 'null',
              eveningCheck == true ? Time.format(et3).toString() : 'null',
              nightCheck == true ? Time.format(st4).toString() : 'null',
              nightCheck == true ? Time.format(et4).toString() : 'null',
              chips,
            );
          }

          if (_schedulerController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Schedule name is Empty')));
          } else if (_schedulerController.text.length < 5) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Schedule name should be atleast 5 character')));
          } else {
            if (_slotPerMemberController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('slot per member is Empty')));
            } else {
              if (chips.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please, Select Day')));
              } else {
                if (morningCheck == false &&
                    afternoonCheck == false &&
                    eveningCheck == false &&
                    nightCheck == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please, Select Session')));
                } else {
                  if (morningCheck == false &&
                      afternoonCheck == false &&
                      eveningCheck == false) {
                    if (checkStartTime4 == "" && checkEndTime4 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Night Time')));
                    } else {
                      if (int.parse(checkEndTime4.substring(10, 12)) >=
                          int.parse(checkStartTime4.substring(10, 12))) {
                        if ((int.parse(checkStartTime4.substring(10, 12))) >=
                                19 &&
                            (int.parse(checkEndTime4.substring(10, 12))) <=
                                23) {
                          tokenBasedApiHit();
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Night Time should be between 7pm to 11:59pm')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Night From Time is Less than Night To Time')));
                      }
                    }
                  } else if (afternoonCheck == false &&
                      eveningCheck == false &&
                      nightCheck == false) {
                    if (checkStartTime1 != "" && checkEndTime1 != "") {
                      if (int.parse(checkEndTime1.substring(10, 12)) >=
                          int.parse(checkStartTime1.substring(10, 12))) {
                        if ((int.parse(checkStartTime1.substring(10, 12))) >=
                                00 &&
                            (int.parse(checkEndTime1.substring(10, 12))) <=
                                12) {
                          tokenBasedApiHit();
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Morning Time should be between 12am to 11:59am')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Morning From Time is Less than Morning To Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Morning Time')));
                    }
                  } else if (eveningCheck == false &&
                      nightCheck == false &&
                      morningCheck == false) {
                    if (checkStartTime2 == "" && checkEndTime2 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please Enter Afternoon Time')));
                    } else {
                      if (int.parse(checkEndTime2.substring(10, 12)) >=
                          int.parse(checkStartTime2.substring(10, 12))) {
                        if ((int.parse(checkStartTime2.substring(10, 12))) >=
                                12 &&
                            (int.parse(checkEndTime2.substring(10, 12))) <=
                                17) {
                          tokenBasedApiHit();
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Afternoon Time should be between 12pm to 4:59pm')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Afternoon From Time is Less than Afternoon To Time')));
                      }
                    }
                  } else if (afternoonCheck == false &&
                      nightCheck == false &&
                      morningCheck == false) {
                    if (checkStartTime3 != "" && checkEndTime3 != "") {
                      if (int.parse(checkEndTime3.substring(10, 12)) >=
                          int.parse(checkStartTime3.substring(10, 12))) {
                        if ((int.parse(checkStartTime3.substring(10, 12))) >=
                                17 &&
                            (int.parse(checkEndTime3.substring(10, 12))) <=
                                19) {
                          tokenBasedApiHit();
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Evening Time should be between 5pm to 6:59pm')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Evening From Time is Less than Evening To Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Evening Time')));
                    }
                  } else if (morningCheck == false && afternoonCheck == false) {
                    if (checkStartTime4 != "" && checkStartTime4 != "") {
                      if (checkStartTime3 != "" && checkEndTime3 != "") {
                        if (int.parse(checkEndTime4.substring(10, 12)) >=
                            int.parse(checkStartTime4.substring(10, 12))) {
                          if (int.parse(checkEndTime3.substring(10, 12)) >=
                              int.parse(checkStartTime3.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime3.substring(10, 12))) >=
                                    17 &&
                                (int.parse(checkEndTime3.substring(10, 12))) <=
                                    19) {
                              if ((int.parse(
                                          checkStartTime4.substring(10, 12))) >=
                                      19 &&
                                  (int.parse(
                                          checkEndTime4.substring(10, 12))) <=
                                      23) {
                                tokenBasedApiHit();
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Night Time should be between 7pm to 11:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Night From Time is Less than Night To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Night Time')));
                    }
                  } else if (afternoonCheck == false && eveningCheck == false) {
                    if (checkStartTime1 != "" && checkEndTime1 != "") {
                      if (checkStartTime4 != "" && checkEndTime4 != "") {
                        if (int.parse(checkEndTime1.substring(10, 12)) >=
                            int.parse(checkStartTime1.substring(10, 12))) {
                          if (int.parse(checkEndTime4.substring(10, 12)) >=
                              int.parse(checkStartTime4.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime4.substring(10, 12))) >=
                                    19 &&
                                (int.parse(checkEndTime4.substring(10, 12))) <=
                                    23) {
                              if ((int.parse(
                                          checkStartTime1.substring(10, 12))) >=
                                      00 &&
                                  (int.parse(
                                          checkEndTime1.substring(10, 12))) <=
                                      12) {
                                tokenBasedApiHit();
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Morning Time should be between 12am to 11:59am')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Night Time should be between 7pm to 11:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please Enter Night Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Morning Time')));
                    }
                  } else if (morningCheck == false && eveningCheck == false) {
                    if (checkStartTime4 != "" && checkEndTime4 != "") {
                      if (checkStartTime2 != "" && checkEndTime2 == "") {
                        if (int.parse(checkEndTime2.substring(10, 12)) >=
                            int.parse(checkStartTime2.substring(10, 12))) {
                          if (int.parse(checkEndTime4.substring(10, 12)) >=
                              int.parse(checkStartTime4.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime2.substring(10, 12))) >=
                                    12 &&
                                (int.parse(checkEndTime2.substring(10, 12))) <=
                                    17) {
                              if ((int.parse(
                                          checkStartTime4.substring(10, 12))) >=
                                      19 &&
                                  (int.parse(
                                          checkEndTime4.substring(10, 12))) <=
                                      23) {
                                tokenBasedApiHit();
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Night Time should be between 7pm to 11:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Afternoon Time should be between 1pm to 4:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Afternoon From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Night Time')));
                    }
                  } else if (afternoonCheck == false && nightCheck == false) {
                    if (checkStartTime3 != "" && checkEndTime3 != "") {
                      if (checkStartTime1 != "" && checkEndTime1 != "") {
                        if (int.parse(checkEndTime1.substring(10, 12)) >=
                            int.parse(checkStartTime1.substring(10, 12))) {
                          if (int.parse(checkEndTime3.substring(10, 12)) >=
                              int.parse(checkStartTime3.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime1.substring(10, 12))) >=
                                    00 &&
                                (int.parse(checkEndTime1.substring(10, 12))) <=
                                    12) {
                              if ((int.parse(
                                          checkStartTime3.substring(10, 12))) >=
                                      17 &&
                                  (int.parse(
                                          checkEndTime3.substring(10, 12))) <=
                                      19) {
                                tokenBasedApiHit();
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Evening Time should be between 5pm to 6:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Morning Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Evening Time')));
                    }
                  } else if (eveningCheck == false && nightCheck == false) {
                    if (checkStartTime1 != "" && checkEndTime1 != "") {
                      if (checkStartTime2 != "" && checkEndTime2 != "") {
                        if (int.parse(checkEndTime1.substring(10, 12)) >=
                            int.parse(checkStartTime1.substring(10, 12))) {
                          if (int.parse(checkEndTime2.substring(10, 12)) >=
                              int.parse(checkStartTime2.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime1.substring(10, 12))) >=
                                    00 &&
                                (int.parse(checkEndTime1.substring(10, 12))) <=
                                    12) {
                              if ((int.parse(
                                          checkStartTime2.substring(10, 12))) >=
                                      12 &&
                                  (int.parse(
                                          checkEndTime2.substring(10, 12))) <=
                                      17) {
                                tokenBasedApiHit();
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Afternoon Time should be between 12pm to 4:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Afternoon From Time is Less than Afternoon To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Morning Time')));
                    }
                  } else if (morningCheck == false && nightCheck == false) {
                    if (checkStartTime3 != "" && checkEndTime3 != "") {
                      if (checkStartTime2 != "" && checkEndTime2 != "") {
                        if (int.parse(checkEndTime2.substring(10, 12)) >=
                            int.parse(checkStartTime2.substring(10, 12))) {
                          if (int.parse(checkEndTime3.substring(10, 12)) >=
                              int.parse(checkStartTime3.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime3.substring(10, 12))) >=
                                    17 &&
                                (int.parse(checkEndTime3.substring(10, 12))) <=
                                    19) {
                              if ((int.parse(
                                          checkStartTime2.substring(10, 12))) >=
                                      13 &&
                                  (int.parse(
                                          checkEndTime2.substring(10, 12))) <=
                                      17) {
                                tokenBasedApiHit();
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Afternoon Time should be between 12pm to 4:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Evening \'From Time\' is Lesser than \'To Time\'')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Afternoon From Time is Less than Afternoon To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Evening Time')));
                    }
                  } else if (morningCheck == false) {
                    if (checkStartTime4 != "" && checkEndTime4 != "") {
                      if (checkStartTime3 != "" && checkEndTime3 != "") {
                        if (checkStartTime2 != "" && checkEndTime2 != "") {
                          if (int.parse(checkEndTime4.substring(10, 12)) >=
                              int.parse(checkStartTime4.substring(10, 12))) {
                            if (int.parse(checkEndTime3.substring(10, 12)) >=
                                int.parse(checkStartTime3.substring(10, 12))) {
                              if (int.parse(checkEndTime2.substring(10, 12)) >=
                                  int.parse(
                                      checkStartTime2.substring(10, 12))) {
                                if ((int.parse(checkStartTime3.substring(
                                            10, 12))) >=
                                        17 &&
                                    (int.parse(
                                            checkEndTime3.substring(10, 12))) <=
                                        19) {
                                  if ((int.parse(checkStartTime4.substring(
                                              10, 12))) >=
                                          19 &&
                                      (int.parse(checkEndTime4.substring(
                                              10, 12))) <=
                                          23) {
                                    if ((int.parse(checkStartTime2.substring(
                                                10, 12))) >=
                                            12 &&
                                        (int.parse(checkEndTime2.substring(
                                                10, 12))) <=
                                            17) {
                                      tokenBasedApiHit();
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Night Time should be between 7pm to 11:59pm')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please Enter Afternoon Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Night Time')));
                    }
                  } else if (afternoonCheck == false) {
                    if (checkStartTime4 != "" && checkEndTime4 != "") {
                      if (checkStartTime3 != "" && checkEndTime3 != "") {
                        if (checkStartTime1 != "" && checkEndTime1 != "") {
                          if (int.parse(checkEndTime4.substring(10, 12)) >=
                              int.parse(checkStartTime4.substring(10, 12))) {
                            if (int.parse(checkEndTime3.substring(10, 12)) >=
                                int.parse(checkStartTime3.substring(10, 12))) {
                              if (int.parse(checkEndTime1.substring(10, 12)) >=
                                  int.parse(
                                      checkStartTime1.substring(10, 12))) {
                                if ((int.parse(checkStartTime3.substring(
                                            10, 12))) >=
                                        17 &&
                                    (int.parse(
                                            checkEndTime3.substring(10, 12))) <=
                                        19) {
                                  if ((int.parse(checkStartTime4.substring(
                                              10, 12))) >=
                                          19 &&
                                      (int.parse(checkEndTime4.substring(
                                              10, 12))) <=
                                          23) {
                                    if ((int.parse(checkStartTime1.substring(
                                                10, 12))) >=
                                            00 &&
                                        (int.parse(checkEndTime1.substring(
                                                10, 12))) <=
                                            12) {
                                      tokenBasedApiHit();
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Morning Time should be between 12am to 11:59am')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Night Time should be between 7pm to 11:59pm')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Morning From Time is Less than Morning To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Night Time')));
                    }
                  } else if (eveningCheck == false) {
                    if (checkStartTime4 != "" && checkEndTime4 != "") {
                      if (checkStartTime2 != "" && checkEndTime2 != "") {
                        if (checkStartTime1 != "" && checkEndTime1 != "") {
                          if (int.parse(checkEndTime4.substring(10, 12)) >=
                              int.parse(checkStartTime4.substring(10, 12))) {
                            if (int.parse(checkEndTime1.substring(10, 12)) >=
                                int.parse(checkStartTime1.substring(10, 12))) {
                              if (int.parse(checkEndTime2.substring(10, 12)) >=
                                  int.parse(
                                      checkStartTime2.substring(10, 12))) {
                                if ((int.parse(checkStartTime4.substring(
                                            10, 12))) >=
                                        19 &&
                                    (int.parse(
                                            checkEndTime4.substring(10, 12))) <=
                                        23) {
                                  if ((int.parse(checkStartTime1.substring(
                                              10, 12))) >=
                                          00 &&
                                      (int.parse(checkEndTime1.substring(
                                              10, 12))) <=
                                          12) {
                                    if ((int.parse(checkStartTime2.substring(
                                                10, 12))) >=
                                            12 &&
                                        (int.parse(checkEndTime2.substring(
                                                10, 12))) <=
                                            17) {
                                      tokenBasedApiHit();
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Morning Time should be between 12am to 11:59am')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Night Time should be between 7pm to 11:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Morning From Time is Less than Morning To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Night Time')));
                    }
                  } else if (nightCheck == false) {
                    if (checkStartTime3 != "" && checkEndTime3 != "") {
                      if (checkStartTime2 != "" && checkEndTime2 != "") {
                        if (checkStartTime1 != "" && checkEndTime1 != "") {
                          if (int.parse(checkEndTime1.substring(10, 12)) >=
                              int.parse(checkStartTime1.substring(10, 12))) {
                            if (int.parse(checkEndTime3.substring(10, 12)) >=
                                int.parse(checkStartTime3.substring(10, 12))) {
                              if (int.parse(checkEndTime2.substring(10, 12)) >=
                                  int.parse(
                                      checkStartTime2.substring(10, 12))) {
                                if ((int.parse(checkStartTime3.substring(
                                            10, 12))) >=
                                        17 &&
                                    (int.parse(
                                            checkEndTime3.substring(10, 12))) <=
                                        19) {
                                  if ((int.parse(checkStartTime1.substring(
                                              10, 12))) >=
                                          00 &&
                                      (int.parse(checkEndTime1.substring(
                                              10, 12))) <=
                                          12) {
                                    if ((int.parse(checkStartTime2.substring(
                                                10, 12))) >=
                                            12 &&
                                        (int.parse(checkEndTime2.substring(
                                                10, 12))) <=
                                            17) {
                                      tokenBasedApiHit();
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Morning Time should be between 12am to 11:59am')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Morning From Time is Less than Morning To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Evening Time')));
                    }
                  } else {
                    if (checkStartTime1 != "" && checkEndTime1 != "") {
                      if (checkStartTime2 != "" && checkEndTime2 != "") {
                        if (checkStartTime3 != "" && checkEndTime3 != "") {
                          if (checkStartTime4 != "" && checkEndTime4 != "") {
                            if (int.parse(checkEndTime4.substring(10, 12)) >=
                                int.parse(checkStartTime4.substring(10, 12))) {
                              if (int.parse(checkEndTime3.substring(10, 12)) >=
                                  int.parse(
                                      checkStartTime3.substring(10, 12))) {
                                if (int.parse(
                                        checkEndTime2.substring(10, 12)) >=
                                    int.parse(
                                        checkStartTime2.substring(10, 12))) {
                                  if (int.parse(
                                          checkEndTime1.substring(10, 12)) >=
                                      int.parse(
                                          checkStartTime1.substring(10, 12))) {
                                    if ((int.parse(checkStartTime3.substring(
                                                10, 12))) >=
                                            17 &&
                                        (int.parse(checkEndTime3.substring(
                                                10, 12))) <=
                                            19) {
                                      if ((int.parse(checkStartTime4.substring(
                                                  10, 12))) >=
                                              19 &&
                                          (int.parse(checkEndTime4.substring(
                                                  10, 12))) <=
                                              23) {
                                        if ((int.parse(checkStartTime1
                                                    .substring(10, 12))) >=
                                                00 &&
                                            (int.parse(checkEndTime1.substring(
                                                    10, 12))) <=
                                                12) {
                                          if ((int.parse(checkStartTime2
                                                      .substring(10, 12))) >=
                                                  12 &&
                                              (int.parse(checkEndTime2
                                                      .substring(10, 12))) <=
                                                  17) {
                                            tokenBasedApiHit();
                                          } else {
                                            print('nice');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Afternoon Time should be between 12pm to 4:59pm')));
                                          }
                                        } else {
                                          print('nice');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Morning Time should be between 12am to 11:59am')));
                                        }
                                      } else {
                                        print('nice');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Night Time should be between 7pm to 11:59pm')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Evening Time should be between 5pm to 6:59pm')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Morning From Time is Less than Morning To Time')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Afternoon From Time is Less than Afternoon To Time')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Evening From Time is Less than Evening To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Night From Time is Less than Night To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Enter Night Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please Enter Evening Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Enter Morning Time')));
                    }
                  }
                }
              }
            }
          }

          // addDoctorScheduleNotifier!.addDoctorSchedule(
          //   doctorId,
          //   _schedulerController.text,
          //   int.parse(finaldropDownValue!),
          //   doctorScheduleType,
          //   int.parse(_slotPerMemberController.text),
          //   morningCheck == true ? Time.format(st1).toString() : 'null',
          //   morningCheck == true ? Time.format(et1).toString() : 'null',
          //   afternoonCheck == true ? Time.format(st2).toString() : 'null',
          //   afternoonCheck == true ? Time.format(et2).toString() : 'null',
          //   eveningCheck == true ? Time.format(st3).toString() : 'null',
          //   eveningCheck == true ? Time.format(et3).toString() : 'null',
          //   nightCheck == true ? Time.format(st4).toString() : 'null',
          //   nightCheck == true ? Time.format(et4).toString() : 'null',
          //   chips,
          // );

          // addDoctorScheduleNotifier?.timeDoctorSchedule(
          //     1,
          //     _schedulerController.text,
          //     int.parse(_slotTimeController.text),
          //     1,
          //     Time.format(st1).toString(),
          //     Time.format(et1).toString(),
          //     chips);
        },
        child: Text(
          'Submit',
          style: TextButtonStyle(context),
        ),
      ),
    );
  }

  Iterable<Widget> get listChip sync* {
    for (final Day chip
        in doctorScheduleDayStatusNotifier.dayScheduleStatusClass) {
      yield Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: FilterChip(
          label: SizedBox(
            height: 40,
            width: 25,
            child: Center(
              child: FittedBox(
                child: Text(
                  chip.day.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: chips.contains(chip.day)
                        ? Colors.white
                        : chip.status == 1
                            ? Colors.white
                            : const Color(0xff68A0F8),
                  ),
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
                color: chip.status == 1 ? Colors.grey : Color(0xff68A0F8),
                width: 2),
          ),
          backgroundColor: Colors.transparent,
          disabledColor: Colors.grey,
          selectedColor: const Color(0xff68A0F8),
          showCheckmark: false,
          selected: chips.contains(chip.day),
          onSelected: chip.status == 1
              ? null
              : (bool value) {
                  setState(() {
                    if (value) {
                      chips.add(chip.day!);
                    } else {
                      chips.removeWhere((String name) {
                        return name == chip.day;
                      });
                    }
                  });
                },
        ),
      );
    }
  }
}
