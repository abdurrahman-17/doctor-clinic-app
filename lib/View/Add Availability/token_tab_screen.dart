import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/View/List%20Of%20Availability/list_availability.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctorScheduleToken/addDoctorScheduleTokenNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusResponse.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TokenTabScreen extends StatefulWidget {
  const TokenTabScreen({Key? key}) : super(key: key);

  @override
  _TokenTabScreenState createState() => _TokenTabScreenState();
}

class Tech {
  String label;

  Tech(this.label);
}

class _TokenTabScreenState extends State<TokenTabScreen> {
  bool isSwitched = false;
  int scheduleType = 1;
  DoctorScheduleDayStatusNotifier doctorScheduleDayStatusNotifier =
      DoctorScheduleDayStatusNotifier();
  AddDoctorScheduleTokenNotifier addDoctorScheduleTokenNotifier =
      AddDoctorScheduleTokenNotifier();
  String? _chosenValue;

  bool morningCheck = false;
  bool afternoonCheck = false;
  bool eveningCheck = false;
  bool nightCheck = false;

  bool distCheck1 = false;
  bool distCheck2 = false;
  bool distCheck3 = false;
  bool distCheck4 = false;
  int doctorId = 0;
  int doctorScheduleType = 2;
  bool distributionCheck = false;

  TimeOfDay? startTime1 = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay? startTime2 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? startTime3 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? startTime4 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime1 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? endTime2 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? endTime3 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime4 = const TimeOfDay(hour: 22, minute: 0);

  TimeOfDay? startDistTime1 = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay? startDistTime2 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? startDistTime3 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? startDistTime4 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endDistTime1 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? endDistTime2 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? endDistTime3 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endDistTime4 = const TimeOfDay(hour: 22, minute: 0);

  final _schedulerController = TextEditingController();
  final _morningTokenController = TextEditingController();
  final _afternoonTokenController = TextEditingController();
  final _eveningTokenController = TextEditingController();
  final _nightTokenController = TextEditingController();
  final _distribution1TokenController = TextEditingController();
  final _distribution2TokenController = TextEditingController();
  final _distribution3TokenController = TextEditingController();
  final _distribution4TokenController = TextEditingController();

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

  String checkDistStartTime1 = '';
  String checkDistEndTime1 = '';
  String checkDistStartTime2 = '';
  String checkDistEndTime2 = '';
  String checkDistStartTime3 = '';
  String checkDistEndTime3 = '';
  String checkDistStartTime4 = '';
  String checkDistEndTime4 = '';

  List<String> chips = <String>[];

  final List<Tech> _chipsList = <Tech>[
    Tech("mon"),
    Tech("tue"),
    Tech("wed"),
    Tech("thu"),
    Tech("fri"),
    Tech("sat"),
    Tech("sun"),
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
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
      MySharedPreferences.instance
          .getDoctorScheduleType('doctorScheduleType')
          .then((value) => setState(() {
                scheduleType = value;
                Future.delayed(Duration.zero, () {
                  doctorScheduleDayStatusNotifier
                      .doctorScheduleStatus(doctorId)
                      .then((value) {
                    doctorScheduleDayStatusNotifier.notifyListeners();
                    print(doctorScheduleDayStatusNotifier
                        .dayScheduleStatusClass[0].day);
                  });
                });
              }));
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

  _showDistEndTime1(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endDistTime1!,
    );
    if (newtime != null) {
      setState(() {
        endDistTime1 = newtime;
        checkDistEndTime1 = newtime.toString();
      });
    }
  }

  _showDistEndTime2(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endDistTime2!,
    );
    if (newtime != null) {
      setState(() {
        endDistTime2 = newtime;
        checkDistEndTime2 = newtime.toString();
      });
    }
  }

  _showDistEndTime3(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endDistTime3!,
    );
    if (newtime != null) {
      setState(() {
        endDistTime3 = newtime;
        checkDistEndTime3 = newtime.toString();
      });
    }
  }

  _showDistEndTime4(context) async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: endDistTime4!,
    );
    if (newtime != null) {
      setState(() {
        endDistTime4 = newtime;
        checkDistEndTime4 = newtime.toString();
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
                        MySharedPreferences.instance
                            .getDoctorId('doctorID')
                            .then((value) {
                          setState(() {
                            doctorId = value;
                            print(doctorId);
                          });
                          MySharedPreferences.instance
                              .getDoctorScheduleType('doctorScheduleType')
                              .then((value) => setState(() {
                                    scheduleType = value;
                                    Future.delayed(Duration.zero, () {
                                      doctorScheduleDayStatusNotifier
                                          .doctorScheduleStatus(doctorId)
                                          .then((value) {
                                        doctorScheduleDayStatusNotifier
                                            .notifyListeners();
                                        print(doctorScheduleDayStatusNotifier
                                            .dayScheduleStatusClass[0].day);
                                      });
                                    });
                                  }));
                        });
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'Retry',
                  ))
            ],
            title: new Text(
              "No Internet Connection",
              style: const TextStyle(color: Colors.black),
            ),
            content: new Text(
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
    return Consumer<AddDoctorScheduleTokenNotifier>(
      builder: (context, provider2, _) {
        addDoctorScheduleTokenNotifier =
            Provider.of<AddDoctorScheduleTokenNotifier>(context, listen: false);
        return ModalProgressHUD(
          inAsyncCall: addDoctorScheduleTokenNotifier.isLoading,
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
          const Spacer(),
          SizedBox(
            height: 25,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ListOfAVilability(),
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
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        schedulerTxtfield(context),
        const SizedBox(
          height: 30,
        ),
        distributionCheckBox(context),
        const SizedBox(
          height: 15,
        ),
        distributionCheck == true
            ? Column(
                children: [
                  const Text(
                    'Distribution Time',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  distributionCheck == true &&
                          morningCheck == false &&
                          afternoonCheck == false &&
                          eveningCheck == false &&
                          nightCheck == false
                      ? Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.event_busy,
                                size: 50,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Select any session',
                              ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(
                              //     horizontal: 10,
                              //     vertical: 8,
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: Colors.blueAccent,
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child: Text(
                              //     'Select any session',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      : Container(),
                  distributionCheck == true && morningCheck == true
                      ? distributionStartAndEnd1(context)
                      : Container(),
                  distributionCheck == true && afternoonCheck == true
                      ? const SizedBox(
                          height: 10,
                        )
                      : Container(),
                  distributionCheck == true && afternoonCheck == true
                      ? distributionStartAndEnd2(context)
                      : Container(),
                  distributionCheck == true && eveningCheck == true
                      ? const SizedBox(
                          height: 10,
                        )
                      : Container(),
                  distributionCheck == true && eveningCheck == true
                      ? distributionStartAndEnd3(context)
                      : Container(),
                  distributionCheck == true && nightCheck == true
                      ? const SizedBox(
                          height: 10,
                        )
                      : Container(),
                  distributionCheck == true && nightCheck == true
                      ? distributionStartAndEnd4(context)
                      : Container(),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              )
            : Container(),
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

  Widget distributionCheckBox(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: distributionCheck,
          activeColor: Colors.blueAccent,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (bool? value) {
            setState(() {
              distributionCheck = value!;
              _distribution1TokenController.text = "";
              _distribution2TokenController.text = "";
              _distribution3TokenController.text = "";
              _distribution4TokenController.text = "";

              checkDistStartTime1 = '';
              checkDistEndTime1 = '';
              checkDistStartTime2 = '';
              checkDistEndTime2 = '';
              checkDistStartTime3 = '';
              checkDistEndTime3 = '';
              checkDistStartTime4 = '';
              checkDistEndTime4 = '';
            });
          },
        ),
        const Text(
          'Add Token Distribution Time',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget morningStartAndEnd(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.blueAccent,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: morningCheck,
        onChanged: (bool? value) {
          setState(() {
            morningCheck = value!;
          });
        },
      ),
      const Text(
        'Mor :',
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
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime1(context);
        },
      ),
      distributionCheck == false
          ? Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 40,
                  height: 35,
                  child: TextFormField(
                    controller: _morningTokenController,
                    validator: validateText,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: '',
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
            )
          : Container(),
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
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: (bool? value) {
          setState(() {
            afternoonCheck = value!;
          });
        },
      ),
      const Text(
        'Aft   :',
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
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime2(context);
        },
      ),
      distributionCheck == false
          ? Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 40,
                  height: 35,
                  child: TextFormField(
                    controller: _afternoonTokenController,
                    validator: validateText,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: '',
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
            )
          : Container(),
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
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: eveningCheck,
        onChanged: (bool? value) {
          setState(() {
            eveningCheck = value!;
          });
        },
      ),
      const Text(
        'Eve  :',
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
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showEndTime3(context);
        },
      ),
      distributionCheck == false
          ? Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 40,
                  height: 35,
                  child: TextFormField(
                    controller: _eveningTokenController,
                    validator: validateText,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: '',
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
            )
          : Container(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: nightCheck,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: Colors.blueAccent,
          onChanged: (bool? value) {
            setState(() {
              nightCheck = value!;
            });
          },
        ),
        const Text(
          'Nig  :',
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
                    const SnackBar(
                      content: Text('Select From Time First'),
                    ),
                  )
                : _showEndTime4(context);
          },
        ),
        distributionCheck == false
            ? Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 40,
                    height: 35,
                    child: TextFormField(
                      controller: _nightTokenController,
                      validator: validateText,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        counterText: '',
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
              )
            : Container(),
      ],
    );

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

  Widget distributionStartAndEnd1(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                startDistTime1!.format(context),
                style: TextStyle(
                  color: checkDistStartTime1 == '' ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          onTap: () async {
            TimeOfDay? newtime = await showTimePicker(
              context: context,
              initialTime: startDistTime1!,
            );
            if (newtime != null) {
              setState(() {
                startDistTime1 = newtime;
                checkDistStartTime1 = newtime.toString();
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
                endDistTime1!.format(context),
                style: TextStyle(
                  color: checkDistEndTime1 == '' ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          onTap: () async {
            checkDistStartTime1 == ''
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select From Time First'),
                    ),
                  )
                : _showDistEndTime1(context);
          },
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          '-',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 40,
          height: 35,
          child: TextFormField(
            controller: _distribution1TokenController,
            validator: validateText,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              counterText: '',
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
        // distCheck2 == false || distCheck3 == false || distCheck4 == false
        //     ? IconButton(
        //         onPressed: () {
        //           if (distCheck3 == true) {
        //             setState(() {
        //               distCheck4 = true;
        //             });
        //           }
        //           if (distCheck2 == true) {
        //             setState(() {
        //               distCheck3 = true;
        //             });
        //           }
        //           if (distCheck1 == true) {
        //             setState(() {
        //               distCheck2 = true;
        //             });
        //           }
        //         },
        //         icon: Icon(
        //           Icons.add_circle_outline,
        //           size: 25,
        //           color: Color(0xff69A1F8),
        //         ),
        //       )
        //     : IconButton(
        //         splashRadius: 0.1,
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.add_circle_outline,
        //           size: 25,
        //           color: Colors.transparent,
        //         ),
        //       ),
      ],
    );

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

  Widget distributionStartAndEnd2(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              startDistTime2!.format(context),
              style: TextStyle(
                color: checkDistStartTime2 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: startDistTime2!,
          );
          if (newtime != null) {
            setState(() {
              startDistTime2 = newtime;
              checkDistStartTime2 = newtime.toString();
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
              endDistTime2!.format(context),
              style: TextStyle(
                color: checkDistEndTime2 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          checkDistStartTime2 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showDistEndTime2(context);
        },
      ),
      const SizedBox(
        width: 5,
      ),
      const Text(
        '-',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      SizedBox(
        width: 40,
        height: 35,
        child: TextFormField(
          controller: _distribution2TokenController,
          validator: validateText,
          maxLength: 2,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            counterText: '',
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
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ),
      // IconButton(
      //   onPressed: () {
      //     setState(() {
      //       distCheck2 = false;
      //     });
      //   },
      //   icon: Icon(
      //     Icons.cancel_outlined,
      //     size: 25,
      //     color: Colors.redAccent,
      //   ),
      // ),
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

  Widget distributionStartAndEnd3(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              startDistTime3!.format(context),
              style: TextStyle(
                color: checkDistStartTime3 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          TimeOfDay? newtime = await showTimePicker(
            context: context,
            initialTime: startDistTime3!,
          );
          if (newtime != null) {
            setState(() {
              startDistTime3 = newtime;
              checkDistStartTime3 = newtime.toString();
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
              endDistTime3!.format(context),
              style: TextStyle(
                color: checkDistEndTime3 == '' ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
        onTap: () async {
          checkDistStartTime3 == ''
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select From Time First'),
                  ),
                )
              : _showDistEndTime3(context);
        },
      ),
      const SizedBox(
        width: 5,
      ),
      const Text(
        '-',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      SizedBox(
        width: 40,
        height: 35,
        child: TextFormField(
          controller: _distribution3TokenController,
          validator: validateText,
          maxLength: 2,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            counterText: '',
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
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ),
      // IconButton(
      //   onPressed: () {
      //     setState(() {
      //       distCheck3 = false;
      //     });
      //   },
      //   icon: Icon(
      //     Icons.cancel_outlined,
      //     size: 25,
      //     color: Colors.redAccent,
      //   ),
      // ),
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

  Widget distributionStartAndEnd4(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                startDistTime4!.format(context),
                style: TextStyle(
                  color: checkDistStartTime4 == '' ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          onTap: () async {
            TimeOfDay? newtime = await showTimePicker(
              context: context,
              initialTime: startDistTime4!,
            );
            if (newtime != null) {
              setState(() {
                startDistTime4 = newtime;
                checkDistStartTime4 = newtime.toString();
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
                endDistTime4!.format(context),
                style: TextStyle(
                  color: checkDistEndTime4 == '' ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          onTap: () async {
            checkDistStartTime4 == ''
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select From Time First'),
                    ),
                  )
                : _showDistEndTime4(context);
          },
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          '-',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 40,
          height: 35,
          child: TextFormField(
            controller: _distribution4TokenController,
            validator: validateText,
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: const InputDecoration(
              counterText: '',
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
        // IconButton(
        //   onPressed: () {
        //     setState(() {
        //       distCheck4 = false;
        //     });
        //   },
        //   icon: Icon(
        //     Icons.cancel_outlined,
        //     size: 25,
        //     color: Colors.redAccent,
        //   ),
        // ),
      ],
    );

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
                child: const Center(
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
          //Distribution Time
          final std1 = DateTime(now.year, now.month, now.day,
              startDistTime1!.hour, startDistTime1!.minute);
          final std2 = DateTime(now.year, now.month, now.day,
              startDistTime2!.hour, startDistTime2!.minute);
          final std3 = DateTime(now.year, now.month, now.day,
              startDistTime3!.hour, startDistTime3!.minute);
          final std4 = DateTime(now.year, now.month, now.day,
              startDistTime4!.hour, startDistTime4!.minute);
          final etd1 = DateTime(now.year, now.month, now.day,
              endDistTime1!.hour, endDistTime1!.minute);
          final etd2 = DateTime(now.year, now.month, now.day,
              endDistTime2!.hour, endDistTime2!.minute);
          final etd3 = DateTime(now.year, now.month, now.day,
              endDistTime3!.hour, endDistTime3!.minute);
          final etd4 = DateTime(now.year, now.month, now.day,
              endDistTime4!.hour, endDistTime4!.minute);
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
            addDoctorScheduleTokenNotifier.addDoctorScheduleToken(
              doctorId,
              _schedulerController.text,
              doctorScheduleType,
              _morningTokenController.text.isNotEmpty
                  ? int.parse(_morningTokenController.text)
                  : 0,
              _afternoonTokenController.text.isNotEmpty
                  ? int.parse(_afternoonTokenController.text)
                  : 0,
              _eveningTokenController.text.isNotEmpty
                  ? int.parse(_eveningTokenController.text)
                  : 0,
              _nightTokenController.text.isNotEmpty
                  ? int.parse(_nightTokenController.text)
                  : 0,
              _distribution1TokenController.text.isNotEmpty
                  ? int.parse(_distribution1TokenController.text)
                  : 0,
              _distribution2TokenController.text.isNotEmpty
                  ? int.parse(_distribution2TokenController.text)
                  : 0,
              _distribution3TokenController.text.isNotEmpty
                  ? int.parse(_distribution3TokenController.text)
                  : 0,
              _distribution4TokenController.text.isNotEmpty
                  ? int.parse(_distribution4TokenController.text)
                  : 0,
              distributionCheck,
              morningCheck == true ? Time.format(std1).toString() : 'null',
              morningCheck == true ? Time.format(etd1).toString() : 'null',
              afternoonCheck == true ? Time.format(std2).toString() : 'null',
              afternoonCheck == true ? Time.format(etd2).toString() : 'null',
              eveningCheck == true ? Time.format(std3).toString() : 'null',
              eveningCheck == true ? Time.format(etd3).toString() : 'null',
              nightCheck == true ? Time.format(std4).toString() : 'null',
              nightCheck == true ? Time.format(etd4).toString() : 'null',
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
                const SnackBar(content: Text('Schedule name is Empty')));
          } else if (_schedulerController.text.length < 5) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Schedule name should be atleast 5 character')));
          } else {
            if (chips.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please, Select Day')));
            } else {
              if (distributionCheck == false) {
                if (morningCheck == false &&
                    afternoonCheck == false &&
                    eveningCheck == false &&
                    nightCheck == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please, Select Session')));
                } else {
                  if (morningCheck == false &&
                      afternoonCheck == false &&
                      eveningCheck == false) {
                    if (checkStartTime4 == "" && checkEndTime4 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
                    } else {
                      if (int.parse(checkEndTime4.substring(10, 12)) >=
                          int.parse(checkStartTime4.substring(10, 12))) {
                        if ((int.parse(checkStartTime4.substring(10, 12))) >=
                                19 &&
                            (int.parse(checkEndTime4.substring(10, 12))) <=
                                23) {
                          if (_nightTokenController.text.isNotEmpty) {
                            tokenBasedApiHit();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter Night Token Field')));
                          }
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Night Time should be between 7pm to 11:59pm')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                          if (_morningTokenController.text.isNotEmpty) {
                            tokenBasedApiHit();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Enter Morning Token Field')));
                          }
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning Time should be between 12am to 11:59am')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Morning From Time is Less than Morning To Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
                    }
                  } else if (eveningCheck == false &&
                      nightCheck == false &&
                      morningCheck == false) {
                    if (checkStartTime2 == "" && checkEndTime2 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Afternoon Time')));
                    } else {
                      if (int.parse(checkEndTime2.substring(10, 12)) >=
                          int.parse(checkStartTime2.substring(10, 12))) {
                        if ((int.parse(checkStartTime2.substring(10, 12))) >=
                                12 &&
                            (int.parse(checkEndTime2.substring(10, 12))) <=
                                17) {
                          if (_afternoonTokenController.text.isNotEmpty) {
                            tokenBasedApiHit();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Enter Afternoon Token Field')));
                          }
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Afternoon Time should be between 12pm to 4:59pm')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                          if (_eveningTokenController.text.isNotEmpty) {
                            tokenBasedApiHit();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Enter Evening Token Field')));
                          }
                        } else {
                          print('nice');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Evening Time should be between 5pm to 6:59pm')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Evening From Time is Less than Evening To Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                if (_nightTokenController.text.isNotEmpty) {
                                  if (_eveningTokenController.text.isNotEmpty) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter Evening Token Field')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Enter Night Token Field')));
                                }
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Night Time should be between 7pm to 11:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Night From Time is Less than Night To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                if (_nightTokenController.text.isNotEmpty) {
                                  if (_morningTokenController.text.isNotEmpty) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter Morning Token Field')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Enter Night Token Field')));
                                }
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Morning Time should be between 12am to 11:59am')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Night Time should be between 7pm to 11:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Night Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
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
                                if (_nightTokenController.text.isNotEmpty) {
                                  if (_afternoonTokenController
                                      .text.isNotEmpty) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter Afternoon Token Field')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Enter Night Token Field')));
                                }
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Night Time should be between 7pm to 11:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Afternoon Time should be between 1pm to 4:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Afternoon From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                if (_morningTokenController.text.isNotEmpty) {
                                  if (_eveningTokenController.text.isNotEmpty) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter Evening Token Field')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Enter Morning Token Field')));
                                }
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Evening Time should be between 5pm to 6:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Morning Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                if (_morningTokenController.text.isNotEmpty) {
                                  if (_afternoonTokenController
                                      .text.isNotEmpty) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter Afternoon Token Field')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Enter Morning Token Field')));
                                }
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon Time should be between 12pm to 4:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Afternoon From Time is Less than Afternoon To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
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
                                      12 &&
                                  (int.parse(
                                          checkEndTime2.substring(10, 12))) <=
                                      17) {
                                if (_afternoonTokenController.text.isNotEmpty) {
                                  if (_eveningTokenController.text.isNotEmpty) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Enter Evening Token Field')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Enter Afternoon Token Field')));
                                }
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon Time should be between 12pm to 4:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening \'From Time\' is Lesser than \'To Time\'')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Afternoon From Time is Less than Afternoon To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                      if (_afternoonTokenController
                                          .text.isNotEmpty) {
                                        if (_eveningTokenController
                                            .text.isNotEmpty) {
                                          if (_nightTokenController
                                              .text.isNotEmpty) {
                                            tokenBasedApiHit();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Enter Night Token Field')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Enter Evening Token Field')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Enter Afternoon Token Field')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Night Time should be between 7pm to 11:59pm')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please Enter Afternoon Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                      if (_morningTokenController
                                          .text.isNotEmpty) {
                                        if (_eveningTokenController
                                            .text.isNotEmpty) {
                                          if (_nightTokenController
                                              .text.isNotEmpty) {
                                            tokenBasedApiHit();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Enter Night Token Field')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Enter Evening Token Field')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Enter Morning Token Field')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Morning Time should be between 12am to 11:59am')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Night Time should be between 7pm to 11:59pm')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Morning From Time is Less than Morning To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                      if (_afternoonTokenController
                                          .text.isNotEmpty) {
                                        if (_morningTokenController
                                            .text.isNotEmpty) {
                                          if (_nightTokenController
                                              .text.isNotEmpty) {
                                            tokenBasedApiHit();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Enter Night Token Field')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Enter Morning Token Field')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Enter Afternoon Token Field')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Morning Time should be between 12am to 11:59am')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Night Time should be between 7pm to 11:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning From Time is Less than Morning To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                      if (_afternoonTokenController
                                          .text.isNotEmpty) {
                                        if (_eveningTokenController
                                            .text.isNotEmpty) {
                                          if (_morningTokenController
                                              .text.isNotEmpty) {
                                            tokenBasedApiHit();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Enter Morning Token Field')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Enter Evening Token Field')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Enter Afternoon Token Field')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Morning Time should be between 12am to 11:59am')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Morning From Time is Less than Morning To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                            if (_afternoonTokenController
                                                .text.isNotEmpty) {
                                              if (_eveningTokenController
                                                  .text.isNotEmpty) {
                                                if (_nightTokenController
                                                    .text.isNotEmpty) {
                                                  if (_morningTokenController
                                                      .text.isNotEmpty) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Enter Morning Token Field')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Enter Night Token Field')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Enter Evening Token Field')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Enter Afternoon Token Field')));
                                            }
                                          } else {
                                            print('nice');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Afternoon Time should be between 12pm to 4:59pm')));
                                          }
                                        } else {
                                          print('nice');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Morning Time should be between 12am to 11:59am')));
                                        }
                                      } else {
                                        print('nice');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Night Time should be between 7pm to 11:59pm')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Evening Time should be between 5pm to 6:59pm')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Morning From Time is Less than Morning To Time')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Afternoon From Time is Less than Afternoon To Time')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Evening From Time is Less than Evening To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Night From Time is Less than Night To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please Enter Night Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Evening Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
                    }
                  }
                }
              } else {
                //Distribution Check Start
                if (morningCheck == false &&
                    afternoonCheck == false &&
                    eveningCheck == false &&
                    nightCheck == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please, Select Session')));
                } else {
                  if (morningCheck == false &&
                      afternoonCheck == false &&
                      eveningCheck == false) {
                    if (checkStartTime4 == "" && checkEndTime4 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
                    } else {
                      if (checkDistStartTime4 != "" &&
                          checkDistEndTime4 != "") {
                        if (_distribution4TokenController.text.isNotEmpty) {
                          if (int.parse(checkEndTime4.substring(10, 12)) >=
                              int.parse(checkStartTime4.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime4.substring(10, 12))) >=
                                    19 &&
                                (int.parse(checkEndTime4.substring(10, 12))) <=
                                    23) {
                              if (int.parse(
                                      checkDistEndTime4.substring(10, 12)) >=
                                  int.parse(
                                      checkDistStartTime4.substring(10, 12))) {
                                if (int.parse(
                                        checkDistEndTime4.substring(10, 12)) <=
                                    int.parse(
                                        checkEndTime4.substring(10, 12))) {
                                  if (int.parse(checkDistStartTime4.substring(
                                          10, 12)) <=
                                      int.parse(
                                          checkStartTime4.substring(10, 12))) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time4 should be Less than Consulting From Time4')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Distribution To Time4 should be Less than Consulting To Time4')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Distribution From Time4 should be Less than Distribution To Time4')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Night Time should be between 7pm to 11:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Distribution Token4 should not be empty')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please Enter Distribution Time')));
                      }
                    }
                  } else if (afternoonCheck == false &&
                      eveningCheck == false &&
                      nightCheck == false) {
                    if (checkStartTime1 != "" && checkEndTime1 != "") {
                      if (checkDistStartTime1 != "" &&
                          checkDistEndTime1 != "") {
                        if (_distribution1TokenController.text.isNotEmpty) {
                          if (int.parse(checkEndTime1.substring(10, 12)) >=
                              int.parse(checkStartTime1.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime1.substring(10, 12))) >=
                                    00 &&
                                (int.parse(checkEndTime1.substring(10, 12))) <=
                                    12) {
                              if (int.parse(
                                      checkDistEndTime1.substring(10, 12)) >=
                                  int.parse(
                                      checkDistStartTime1.substring(10, 12))) {
                                if (int.parse(
                                        checkDistEndTime1.substring(10, 12)) <=
                                    int.parse(
                                        checkEndTime1.substring(10, 12))) {
                                  if (int.parse(checkDistStartTime1.substring(
                                          10, 12)) <=
                                      int.parse(
                                          checkStartTime1.substring(10, 12))) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time1 should be Less than Consulting From Time1')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Distribution To Time1 should be Less than Consulting To Time1')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Distribution From Time1 should be Less than Distribution To Time1')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Morning From Time is Less than Morning To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Distribution Token1 should not be empty')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please Enter Distribution Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
                    }
                  } else if (eveningCheck == false &&
                      nightCheck == false &&
                      morningCheck == false) {
                    if (checkStartTime2 == "" && checkEndTime2 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Afternoon Time')));
                    } else {
                      if (checkDistStartTime2 != "" &&
                          checkDistEndTime2 != "") {
                        if (_distribution2TokenController.text.isNotEmpty) {
                          if (int.parse(checkEndTime2.substring(10, 12)) >=
                              int.parse(checkStartTime2.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime2.substring(10, 12))) >=
                                    12 &&
                                (int.parse(checkEndTime2.substring(10, 12))) <=
                                    17) {
                              if (int.parse(
                                      checkDistEndTime2.substring(10, 12)) >=
                                  int.parse(
                                      checkDistStartTime2.substring(10, 12))) {
                                if (int.parse(
                                        checkDistEndTime2.substring(10, 12)) <=
                                    int.parse(
                                        checkEndTime2.substring(10, 12))) {
                                  if (int.parse(checkDistStartTime2.substring(
                                          10, 12)) <=
                                      int.parse(
                                          checkStartTime2.substring(10, 12))) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time2 should be Less than Consulting From Time2')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Distribution To Time2 should be Less than Consulting To Time2')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Distribution From Time2 should be Less than Distribution To Time2')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Afternoon Time should be between 12pm to 4:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Afternoon From Time is Less than Afternoon To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Distribution Token2 should not be empty')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please Enter Distribution Time')));
                      }
                    }
                  } else if (afternoonCheck == false &&
                      nightCheck == false &&
                      morningCheck == false) {
                    if (checkStartTime3 != "" && checkEndTime3 != "") {
                      if (checkDistStartTime3 != "" &&
                          checkDistEndTime3 != "") {
                        if (_distribution3TokenController.text.isNotEmpty) {
                          if (int.parse(checkEndTime3.substring(10, 12)) >=
                              int.parse(checkStartTime3.substring(10, 12))) {
                            if ((int.parse(
                                        checkStartTime3.substring(10, 12))) >=
                                    17 &&
                                (int.parse(checkEndTime3.substring(10, 12))) <=
                                    19) {
                              if (int.parse(
                                      checkDistEndTime3.substring(10, 12)) >=
                                  int.parse(
                                      checkDistStartTime3.substring(10, 12))) {
                                if (int.parse(
                                        checkDistEndTime3.substring(10, 12)) <=
                                    int.parse(
                                        checkEndTime3.substring(10, 12))) {
                                  if (int.parse(checkDistStartTime3.substring(
                                          10, 12)) <=
                                      int.parse(
                                          checkStartTime3.substring(10, 12))) {
                                    tokenBasedApiHit();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time3 should be Less than Consulting From Time3')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Distribution To Time3 should be Less than Consulting To Time3')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Distribution From Time3 should be Less than Distribution To Time3')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Distribution Token3 should not be empty')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please Enter Distribution Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                //
                                if (checkDistStartTime4 != "" &&
                                    checkDistEndTime4 != "") {
                                  if (int.parse(checkDistEndTime4.substring(
                                          10, 12)) >=
                                      int.parse(checkDistStartTime4.substring(
                                          10, 12))) {
                                    if (int.parse(checkDistEndTime4.substring(
                                            10, 12)) <=
                                        int.parse(
                                            checkEndTime4.substring(10, 12))) {
                                      if (int.parse(checkDistStartTime4
                                              .substring(10, 12)) <=
                                          int.parse(checkStartTime4.substring(
                                              10, 12))) {
                                        if (_distribution4TokenController
                                            .text.isNotEmpty) {
                                          //
                                          if (checkDistStartTime3 != "" &&
                                              checkDistEndTime3 != "") {
                                            if (_distribution3TokenController
                                                .text.isNotEmpty) {
                                              if (int.parse(checkDistEndTime3
                                                      .substring(10, 12)) >=
                                                  int.parse(checkDistStartTime3
                                                      .substring(10, 12))) {
                                                if (int.parse(checkDistEndTime3
                                                        .substring(10, 12)) <=
                                                    int.parse(checkEndTime3
                                                        .substring(10, 12))) {
                                                  if (int.parse(
                                                          checkDistStartTime3
                                                              .substring(
                                                                  10, 12)) <=
                                                      int.parse(checkStartTime3
                                                          .substring(10, 12))) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution From Time3 should be Less than Consulting From Time3')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution To Time3 should be Less than Consulting To Time3')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution From Time3 should be Less than Distribution To Time3')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution Token3 should not be empty')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please Enter Distribution Time')));
                                          }
                                          //
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution Token4 should not be empty')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Distribution From Time4 should be Less than Consulting From Time4')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Distribution To Time4 should be Less than Consulting To Time4')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time4 should be Less than Distribution To Time4')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please Enter Distribution Time')));
                                }
                                //
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Night Time should be between 7pm to 11:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Night From Time is Less than Night To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                //
                                if (checkDistStartTime4 != "" &&
                                    checkDistEndTime4 != "") {
                                  if (int.parse(checkDistEndTime4.substring(
                                          10, 12)) >=
                                      int.parse(checkDistStartTime4.substring(
                                          10, 12))) {
                                    if (int.parse(checkDistEndTime4.substring(
                                            10, 12)) <=
                                        int.parse(
                                            checkEndTime4.substring(10, 12))) {
                                      if (int.parse(checkDistStartTime4
                                              .substring(10, 12)) <=
                                          int.parse(checkStartTime4.substring(
                                              10, 12))) {
                                        if (_distribution4TokenController
                                            .text.isNotEmpty) {
                                          //
                                          if (checkDistStartTime1 != "" &&
                                              checkDistEndTime1 != "") {
                                            if (int.parse(checkDistEndTime1
                                                    .substring(10, 12)) >=
                                                int.parse(checkDistStartTime1
                                                    .substring(10, 12))) {
                                              if (int.parse(checkDistEndTime1
                                                      .substring(10, 12)) <=
                                                  int.parse(checkEndTime1
                                                      .substring(10, 12))) {
                                                if (int.parse(
                                                        checkDistStartTime1
                                                            .substring(
                                                                10, 12)) <=
                                                    int.parse(checkStartTime1
                                                        .substring(10, 12))) {
                                                  if (_distribution1TokenController
                                                      .text.isNotEmpty) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution Token1 should not be empty')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution From Time1 should be Less than Consulting From Time1')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution To Time1 should be Less than Consulting To Time1')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time1 should be Less than Distribution To Time1')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please Enter Distribution Time')));
                                          }
                                          //
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution Token4 should not be empty')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Distribution From Time4 should be Less than Consulting From Time4')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Distribution To Time4 should be Less than Consulting To Time4')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time4 should be Less than Distribution To Time4')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please Enter Distribution Time')));
                                }
                                //
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Morning Time should be between 12am to 11:59am')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Night Time should be between 7pm to 11:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Night Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
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
                                //
                                if (checkDistStartTime4 != "" &&
                                    checkDistEndTime4 != "") {
                                  if (int.parse(checkDistEndTime4.substring(
                                          10, 12)) >=
                                      int.parse(checkDistStartTime4.substring(
                                          10, 12))) {
                                    if (int.parse(checkDistEndTime4.substring(
                                            10, 12)) <=
                                        int.parse(
                                            checkEndTime4.substring(10, 12))) {
                                      if (int.parse(checkDistStartTime4
                                              .substring(10, 12)) <=
                                          int.parse(checkStartTime4.substring(
                                              10, 12))) {
                                        if (_distribution4TokenController
                                            .text.isNotEmpty) {
                                          //
                                          if (checkDistStartTime2 != "" &&
                                              checkDistEndTime2 != "") {
                                            if (int.parse(checkDistEndTime2
                                                    .substring(10, 12)) >=
                                                int.parse(checkDistStartTime2
                                                    .substring(10, 12))) {
                                              if (int.parse(checkDistEndTime2
                                                      .substring(10, 12)) <=
                                                  int.parse(checkEndTime2
                                                      .substring(10, 12))) {
                                                if (int.parse(
                                                        checkDistStartTime2
                                                            .substring(
                                                                10, 12)) <=
                                                    int.parse(checkStartTime2
                                                        .substring(10, 12))) {
                                                  if (_distribution2TokenController
                                                      .text.isNotEmpty) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution Token2 should not be empty')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution From Time2 should be Less than Consulting From Time2')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution To Time2 should be Less than Consulting To Time2')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time2 should be Less than Distribution To Time2')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please Enter Distribution Time')));
                                          }
                                          //
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution Token4 should not be empty')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Distribution From Time4 should be Less than Consulting From Time4')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Distribution To Time4 should be Less than Consulting To Time4')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time4 should be Less than Distribution To Time4')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please Enter Distribution Time')));
                                }
                                //
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Night Time should be between 7pm to 11:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Afternoon Time should be between 1pm to 4:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Afternoon From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                //
                                if (checkDistStartTime1 != "" &&
                                    checkDistEndTime1 != "") {
                                  if (int.parse(checkDistEndTime1.substring(
                                          10, 12)) >=
                                      int.parse(checkDistStartTime1.substring(
                                          10, 12))) {
                                    if (int.parse(checkDistEndTime1.substring(
                                            10, 12)) <=
                                        int.parse(
                                            checkEndTime1.substring(10, 12))) {
                                      if (int.parse(checkDistStartTime1
                                              .substring(10, 12)) <=
                                          int.parse(checkStartTime1.substring(
                                              10, 12))) {
                                        if (_distribution1TokenController
                                            .text.isNotEmpty) {
                                          //
                                          if (checkDistStartTime3 != "" &&
                                              checkDistEndTime3 != "") {
                                            if (int.parse(checkDistEndTime3
                                                    .substring(10, 12)) >=
                                                int.parse(checkDistStartTime3
                                                    .substring(10, 12))) {
                                              if (int.parse(checkDistEndTime3
                                                      .substring(10, 12)) <=
                                                  int.parse(checkEndTime3
                                                      .substring(10, 12))) {
                                                if (int.parse(
                                                        checkDistStartTime3
                                                            .substring(
                                                                10, 12)) <=
                                                    int.parse(checkStartTime3
                                                        .substring(10, 12))) {
                                                  if (_distribution3TokenController
                                                      .text.isNotEmpty) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution Token3 should not be empty')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution From Time3 should be Less than Consulting From Time3')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution To Time3 should be Less than Consulting To Time3')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time3 should be Less than Distribution To Time3')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please Enter Distribution Time')));
                                          }
                                          //
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution Token1 should not be empty')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Distribution From Time1 should be Less than Consulting From Time1')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Distribution To Time1 should be Less than Consulting To Time1')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time1 should be Less than Distribution To Time1')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please Enter Distribution Time')));
                                }
                                //
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Evening Time should be between 5pm to 6:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening From Time is Less than Evening To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Morning Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                //
                                if (checkDistStartTime1 != "" &&
                                    checkDistEndTime1 != "") {
                                  if (int.parse(checkDistEndTime1.substring(
                                          10, 12)) >=
                                      int.parse(checkDistStartTime1.substring(
                                          10, 12))) {
                                    if (int.parse(checkDistEndTime1.substring(
                                            10, 12)) <=
                                        int.parse(
                                            checkEndTime1.substring(10, 12))) {
                                      if (int.parse(checkDistStartTime1
                                              .substring(10, 12)) <=
                                          int.parse(checkStartTime1.substring(
                                              10, 12))) {
                                        if (_distribution1TokenController
                                            .text.isNotEmpty) {
                                          //
                                          if (checkDistStartTime2 != "" &&
                                              checkDistEndTime2 != "") {
                                            if (int.parse(checkDistEndTime2
                                                    .substring(10, 12)) >=
                                                int.parse(checkDistStartTime2
                                                    .substring(10, 12))) {
                                              if (int.parse(checkDistEndTime2
                                                      .substring(10, 12)) <=
                                                  int.parse(checkEndTime2
                                                      .substring(10, 12))) {
                                                if (int.parse(
                                                        checkDistStartTime2
                                                            .substring(
                                                                10, 12)) <=
                                                    int.parse(checkStartTime2
                                                        .substring(10, 12))) {
                                                  if (_distribution2TokenController
                                                      .text.isNotEmpty) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution Token2 should not be empty')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution From Time2 should be Less than Consulting From Time2')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution To Time2 should be Less than Consulting To Time2')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time2 should be Less than Distribution To Time2')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please Enter Distribution Time')));
                                          }
                                          //
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution Token1 should not be empty')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Distribution From Time1 should be Less than Consulting From Time1')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Distribution To Time1 should be Less than Consulting To Time1')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time1 should be Less than Distribution To Time1')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please Enter Distribution Time')));
                                }
                                //
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon Time should be between 12pm to 4:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning Time should be between 12am to 11:59am')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Afternoon From Time is Less than Afternoon To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Morning From Time is Less than Morning To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
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
                                      12 &&
                                  (int.parse(
                                          checkEndTime2.substring(10, 12))) <=
                                      17) {
                                //
                                if (checkDistStartTime2 != "" &&
                                    checkDistEndTime2 != "") {
                                  if (int.parse(checkDistEndTime2.substring(
                                          10, 12)) >=
                                      int.parse(checkDistStartTime2.substring(
                                          10, 12))) {
                                    if (int.parse(checkDistEndTime2.substring(
                                            10, 12)) <=
                                        int.parse(
                                            checkEndTime2.substring(10, 12))) {
                                      if (int.parse(checkDistStartTime2
                                              .substring(10, 12)) <=
                                          int.parse(checkStartTime2.substring(
                                              10, 12))) {
                                        if (_distribution2TokenController
                                            .text.isNotEmpty) {
                                          //
                                          if (checkDistStartTime3 != "" &&
                                              checkDistEndTime3 != "") {
                                            if (int.parse(checkDistEndTime3
                                                    .substring(10, 12)) >=
                                                int.parse(checkDistStartTime3
                                                    .substring(10, 12))) {
                                              if (int.parse(checkDistEndTime3
                                                      .substring(10, 12)) <=
                                                  int.parse(checkEndTime3
                                                      .substring(10, 12))) {
                                                if (int.parse(
                                                        checkDistStartTime3
                                                            .substring(
                                                                10, 12)) <=
                                                    int.parse(checkStartTime3
                                                        .substring(10, 12))) {
                                                  if (_distribution3TokenController
                                                      .text.isNotEmpty) {
                                                    tokenBasedApiHit();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution Token3 should not be empty')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution From Time3 should be Less than Consulting From Time3')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution To Time3 should be Less than Consulting To Time3')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time3 should be Less than Distribution To Time3')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Please Enter Distribution Time')));
                                          }
                                          //
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution Token2 should not be empty')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Distribution From Time2 should be Less than Consulting From Time2')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Distribution To Time2 should be Less than Consulting To Time2')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Distribution From Time2 should be Less than Distribution To Time2')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please Enter Distribution Time')));
                                }
                                //
                              } else {
                                print('nice');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon Time should be between 12pm to 4:59pm')));
                              }
                            } else {
                              print('nice');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening Time should be between 5pm to 6:59pm')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Evening \'From Time\' is Lesser than \'To Time\'')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Afternoon From Time is Less than Afternoon To Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                      //
                                      if (checkDistStartTime4 != "" &&
                                          checkDistEndTime4 != "") {
                                        if (int.parse(checkDistEndTime4
                                                .substring(10, 12)) >=
                                            int.parse(checkDistStartTime4
                                                .substring(10, 12))) {
                                          if (int.parse(checkDistEndTime4
                                                  .substring(10, 12)) <=
                                              int.parse(checkEndTime4.substring(
                                                  10, 12))) {
                                            if (int.parse(checkDistStartTime4
                                                    .substring(10, 12)) <=
                                                int.parse(checkStartTime4
                                                    .substring(10, 12))) {
                                              if (_distribution4TokenController
                                                  .text.isNotEmpty) {
                                                //
                                                if (checkDistStartTime3 != "" &&
                                                    checkDistEndTime3 != "") {
                                                  if (int.parse(
                                                          checkDistEndTime3
                                                              .substring(
                                                                  10, 12)) >=
                                                      int.parse(
                                                          checkDistStartTime3
                                                              .substring(
                                                                  10, 12))) {
                                                    if (int.parse(
                                                            checkDistEndTime3
                                                                .substring(
                                                                    10, 12)) <=
                                                        int.parse(checkEndTime3
                                                            .substring(
                                                                10, 12))) {
                                                      if (int.parse(
                                                              checkDistStartTime3
                                                                  .substring(10,
                                                                      12)) <=
                                                          int.parse(
                                                              checkStartTime3
                                                                  .substring(10,
                                                                      12))) {
                                                        if (_distribution3TokenController
                                                            .text.isNotEmpty) {
                                                          //
                                                          if (checkDistStartTime2 !=
                                                                  "" &&
                                                              checkDistEndTime2 !=
                                                                  "") {
                                                            if (int.parse(checkDistEndTime2
                                                                    .substring(
                                                                        10,
                                                                        12)) >=
                                                                int.parse(checkDistStartTime2
                                                                    .substring(
                                                                        10,
                                                                        12))) {
                                                              if (int.parse(checkDistEndTime2
                                                                      .substring(
                                                                          10,
                                                                          12)) <=
                                                                  int.parse(checkEndTime2
                                                                      .substring(
                                                                          10,
                                                                          12))) {
                                                                if (int.parse(checkDistStartTime2
                                                                        .substring(
                                                                            10,
                                                                            12)) <=
                                                                    int.parse(checkStartTime2
                                                                        .substring(
                                                                            10,
                                                                            12))) {
                                                                  if (_distribution2TokenController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    tokenBasedApiHit();
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Distribution Token2 should not be empty')));
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time2 should be Less than Consulting From Time2')));
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Distribution To Time2 should be Less than Consulting To Time2')));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time2 should be Less than Distribution To Time2')));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Please Enter Distribution Time')));
                                                          }
                                                          //
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Distribution Token3 should not be empty')));
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Distribution From Time3 should be Less than Consulting From Time3')));
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Distribution To Time3 should be Less than Consulting To Time3')));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution From Time3 should be Less than Distribution To Time3')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please Enter Distribution Time')));
                                                }
                                                //
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution Token4 should not be empty')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time4 should be Less than Consulting From Time4')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Distribution To Time4 should be Less than Consulting To Time4')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution From Time4 should be Less than Distribution To Time4')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please Enter Distribution Time')));
                                      }
                                      //
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Night Time should be between 7pm to 11:59pm')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please Enter Afternoon Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                      //
                                      if (checkDistStartTime4 != "" &&
                                          checkDistEndTime4 != "") {
                                        if (int.parse(checkDistEndTime4
                                                .substring(10, 12)) >=
                                            int.parse(checkDistStartTime4
                                                .substring(10, 12))) {
                                          if (int.parse(checkDistEndTime4
                                                  .substring(10, 12)) <=
                                              int.parse(checkEndTime4.substring(
                                                  10, 12))) {
                                            if (int.parse(checkDistStartTime4
                                                    .substring(10, 12)) <=
                                                int.parse(checkStartTime4
                                                    .substring(10, 12))) {
                                              if (_distribution4TokenController
                                                  .text.isNotEmpty) {
                                                //
                                                if (checkDistStartTime3 != "" &&
                                                    checkDistEndTime3 != "") {
                                                  if (int.parse(
                                                          checkDistEndTime3
                                                              .substring(
                                                                  10, 12)) >=
                                                      int.parse(
                                                          checkDistStartTime3
                                                              .substring(
                                                                  10, 12))) {
                                                    if (int.parse(
                                                            checkDistEndTime3
                                                                .substring(
                                                                    10, 12)) <=
                                                        int.parse(checkEndTime3
                                                            .substring(
                                                                10, 12))) {
                                                      if (int.parse(
                                                              checkDistStartTime3
                                                                  .substring(10,
                                                                      12)) <=
                                                          int.parse(
                                                              checkStartTime3
                                                                  .substring(10,
                                                                      12))) {
                                                        if (_distribution3TokenController
                                                            .text.isNotEmpty) {
                                                          //
                                                          if (checkDistStartTime1 !=
                                                                  "" &&
                                                              checkDistEndTime1 !=
                                                                  "") {
                                                            if (int.parse(checkDistEndTime1
                                                                    .substring(
                                                                        10,
                                                                        12)) >=
                                                                int.parse(checkDistStartTime1
                                                                    .substring(
                                                                        10,
                                                                        12))) {
                                                              if (int.parse(checkDistEndTime1
                                                                      .substring(
                                                                          10,
                                                                          12)) <=
                                                                  int.parse(checkEndTime1
                                                                      .substring(
                                                                          10,
                                                                          12))) {
                                                                if (int.parse(checkDistStartTime1
                                                                        .substring(
                                                                            10,
                                                                            12)) <=
                                                                    int.parse(checkStartTime1
                                                                        .substring(
                                                                            10,
                                                                            12))) {
                                                                  if (_distribution1TokenController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    tokenBasedApiHit();
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Distribution Token1 should not be empty')));
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time1 should be Less than Consulting From Time1')));
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Distribution To Time1 should be Less than Consulting To Time1')));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time1 should be Less than Distribution To Time1')));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Please Enter Distribution Time')));
                                                          }
                                                          //
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Distribution Token3 should not be empty')));
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Distribution From Time3 should be Less than Consulting From Time3')));
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Distribution To Time3 should be Less than Consulting To Time3')));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution From Time3 should be Less than Distribution To Time3')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please Enter Distribution Time')));
                                                }
                                                //
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution Token4 should not be empty')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time4 should be Less than Consulting From Time4')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Distribution To Time4 should be Less than Consulting To Time4')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution From Time4 should be Less than Distribution To Time4')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please Enter Distribution Time')));
                                      }
                                      //
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Morning Time should be between 12am to 11:59am')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Night Time should be between 7pm to 11:59pm')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Morning From Time is Less than Morning To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Evening Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                      //
                                      if (checkDistStartTime4 != "" &&
                                          checkDistEndTime4 != "") {
                                        if (int.parse(checkDistEndTime4
                                                .substring(10, 12)) >=
                                            int.parse(checkDistStartTime4
                                                .substring(10, 12))) {
                                          if (int.parse(checkDistEndTime4
                                                  .substring(10, 12)) <=
                                              int.parse(checkEndTime4.substring(
                                                  10, 12))) {
                                            if (int.parse(checkDistStartTime4
                                                    .substring(10, 12)) <=
                                                int.parse(checkStartTime4
                                                    .substring(10, 12))) {
                                              if (_distribution4TokenController
                                                  .text.isNotEmpty) {
                                                //
                                                if (checkDistStartTime1 != "" &&
                                                    checkDistEndTime1 != "") {
                                                  if (int.parse(
                                                          checkDistEndTime1
                                                              .substring(
                                                                  10, 12)) >=
                                                      int.parse(
                                                          checkDistStartTime1
                                                              .substring(
                                                                  10, 12))) {
                                                    if (int.parse(
                                                            checkDistEndTime1
                                                                .substring(
                                                                    10, 12)) <=
                                                        int.parse(checkEndTime1
                                                            .substring(
                                                                10, 12))) {
                                                      if (int.parse(
                                                              checkDistStartTime1
                                                                  .substring(10,
                                                                      12)) <=
                                                          int.parse(
                                                              checkStartTime1
                                                                  .substring(10,
                                                                      12))) {
                                                        if (_distribution1TokenController
                                                            .text.isNotEmpty) {
                                                          //
                                                          if (checkDistStartTime2 !=
                                                                  "" &&
                                                              checkDistEndTime2 !=
                                                                  "") {
                                                            if (int.parse(checkDistEndTime2
                                                                    .substring(
                                                                        10,
                                                                        12)) >=
                                                                int.parse(checkDistStartTime2
                                                                    .substring(
                                                                        10,
                                                                        12))) {
                                                              if (int.parse(checkDistEndTime2
                                                                      .substring(
                                                                          10,
                                                                          12)) <=
                                                                  int.parse(checkEndTime2
                                                                      .substring(
                                                                          10,
                                                                          12))) {
                                                                if (int.parse(checkDistStartTime2
                                                                        .substring(
                                                                            10,
                                                                            12)) <=
                                                                    int.parse(checkStartTime2
                                                                        .substring(
                                                                            10,
                                                                            12))) {
                                                                  if (_distribution2TokenController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    tokenBasedApiHit();
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Distribution Token2 should not be empty')));
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time2 should be Less than Consulting From Time2')));
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Distribution To Time2 should be Less than Consulting To Time2')));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time2 should be Less than Distribution To Time2')));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Please Enter Distribution Time')));
                                                          }
                                                          //
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Distribution Token1 should not be empty')));
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Distribution From Time1 should be Less than Consulting From Time1')));
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Distribution To Time1 should be Less than Consulting To Time1')));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution From Time1 should be Less than Distribution To Time1')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please Enter Distribution Time')));
                                                }
                                                //
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution Token4 should not be empty')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time4 should be Less than Consulting From Time4')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Distribution To Time4 should be Less than Consulting To Time4')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution From Time4 should be Less than Distribution To Time4')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please Enter Distribution Time')));
                                      }
                                      //
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Morning Time should be between 12am to 11:59am')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Night Time should be between 7pm to 11:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Morning From Time is Less than Morning To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Night From Time is Less than Night To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Night Time')));
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
                                      //
                                      if (checkDistStartTime3 != "" &&
                                          checkDistEndTime3 != "") {
                                        if (int.parse(checkDistEndTime3
                                                .substring(10, 12)) >=
                                            int.parse(checkDistStartTime3
                                                .substring(10, 12))) {
                                          if (int.parse(checkDistEndTime3
                                                  .substring(10, 12)) <=
                                              int.parse(checkEndTime3.substring(
                                                  10, 12))) {
                                            if (int.parse(checkDistStartTime3
                                                    .substring(10, 12)) <=
                                                int.parse(checkStartTime3
                                                    .substring(10, 12))) {
                                              if (_distribution3TokenController
                                                  .text.isNotEmpty) {
                                                //
                                                if (checkDistStartTime2 != "" &&
                                                    checkDistEndTime2 != "") {
                                                  if (int.parse(
                                                          checkDistEndTime2
                                                              .substring(
                                                                  10, 12)) >=
                                                      int.parse(
                                                          checkDistStartTime2
                                                              .substring(
                                                                  10, 12))) {
                                                    if (int.parse(
                                                            checkDistEndTime2
                                                                .substring(
                                                                    10, 12)) <=
                                                        int.parse(checkEndTime2
                                                            .substring(
                                                                10, 12))) {
                                                      if (int.parse(
                                                              checkDistStartTime2
                                                                  .substring(10,
                                                                      12)) <=
                                                          int.parse(
                                                              checkStartTime2
                                                                  .substring(10,
                                                                      12))) {
                                                        if (_distribution2TokenController
                                                            .text.isNotEmpty) {
                                                          //
                                                          if (checkDistStartTime1 !=
                                                                  "" &&
                                                              checkDistEndTime1 !=
                                                                  "") {
                                                            if (int.parse(checkDistEndTime1
                                                                    .substring(
                                                                        10,
                                                                        12)) >=
                                                                int.parse(checkDistStartTime1
                                                                    .substring(
                                                                        10,
                                                                        12))) {
                                                              if (int.parse(checkDistEndTime1
                                                                      .substring(
                                                                          10,
                                                                          12)) <=
                                                                  int.parse(checkEndTime1
                                                                      .substring(
                                                                          10,
                                                                          12))) {
                                                                if (int.parse(checkDistStartTime1
                                                                        .substring(
                                                                            10,
                                                                            12)) <=
                                                                    int.parse(checkStartTime1
                                                                        .substring(
                                                                            10,
                                                                            12))) {
                                                                  if (_distribution1TokenController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    tokenBasedApiHit();
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Distribution Token1 should not be empty')));
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time1 should be Less than Consulting From Time1')));
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Distribution To Time1 should be Less than Consulting To Time1')));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time1 should be Less than Distribution To Time1')));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Please Enter Distribution Time')));
                                                          }
                                                          //
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Distribution Token2 should not be empty')));
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Distribution From Time2 should be Less than Consulting From Time2')));
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Distribution To Time2 should be Less than Consulting To Time2')));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution From Time2 should be Less than Distribution To Time2')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please Enter Distribution Time')));
                                                }
                                                //
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution Token3 should not be empty')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Distribution From Time3 should be Less than Consulting From Time3')));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Distribution To Time3 should be Less than Consulting To Time3')));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Distribution From Time3 should be Less than Distribution To Time3')));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please Enter Distribution Time')));
                                      }
                                      //
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Afternoon Time should be between 12pm to 4:59pm')));
                                    }
                                  } else {
                                    print('nice');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Morning Time should be between 12am to 11:59am')));
                                  }
                                } else {
                                  print('nice');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Evening Time should be between 5pm to 6:59pm')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Afternoon From Time is Less than Afternoon To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Evening From Time is Less than Evening To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Morning From Time is Less than Morning To Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Morning Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Evening Time')));
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
                                            //
                                            if (checkDistStartTime4 != "" &&
                                                checkDistEndTime4 != "") {
                                              if (int.parse(checkDistEndTime4
                                                      .substring(10, 12)) >=
                                                  int.parse(checkDistStartTime4
                                                      .substring(10, 12))) {
                                                if (int.parse(checkDistEndTime4
                                                        .substring(10, 12)) <=
                                                    int.parse(checkEndTime4
                                                        .substring(10, 12))) {
                                                  if (int.parse(
                                                          checkDistStartTime4
                                                              .substring(
                                                                  10, 12)) <=
                                                      int.parse(checkStartTime4
                                                          .substring(10, 12))) {
                                                    if (_distribution4TokenController
                                                        .text.isNotEmpty) {
                                                      //
                                                      if (checkDistStartTime3 !=
                                                              "" &&
                                                          checkDistEndTime3 !=
                                                              "") {
                                                        if (int.parse(
                                                                checkDistEndTime3
                                                                    .substring(
                                                                        10,
                                                                        12)) >=
                                                            int.parse(
                                                                checkDistStartTime3
                                                                    .substring(
                                                                        10,
                                                                        12))) {
                                                          if (int.parse(
                                                                  checkDistEndTime3
                                                                      .substring(
                                                                          10,
                                                                          12)) <=
                                                              int.parse(
                                                                  checkEndTime3
                                                                      .substring(
                                                                          10,
                                                                          12))) {
                                                            if (int.parse(checkDistStartTime3
                                                                    .substring(
                                                                        10,
                                                                        12)) <=
                                                                int.parse(checkStartTime3
                                                                    .substring(
                                                                        10,
                                                                        12))) {
                                                              if (_distribution3TokenController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                //
                                                                if (checkDistStartTime2 !=
                                                                        "" &&
                                                                    checkDistEndTime2 !=
                                                                        "") {
                                                                  if (int.parse(
                                                                          checkDistEndTime2.substring(
                                                                              10,
                                                                              12)) >=
                                                                      int.parse(
                                                                          checkDistStartTime2.substring(
                                                                              10,
                                                                              12))) {
                                                                    if (int.parse(checkDistEndTime2.substring(
                                                                            10,
                                                                            12)) <=
                                                                        int.parse(checkEndTime2.substring(
                                                                            10,
                                                                            12))) {
                                                                      if (int.parse(checkDistStartTime2.substring(
                                                                              10,
                                                                              12)) <=
                                                                          int.parse(checkStartTime2.substring(
                                                                              10,
                                                                              12))) {
                                                                        if (_distribution2TokenController
                                                                            .text
                                                                            .isNotEmpty) {
                                                                          //
                                                                          if (checkDistStartTime1 != "" &&
                                                                              checkDistEndTime1 != "") {
                                                                            if (int.parse(checkDistEndTime1.substring(10, 12)) >=
                                                                                int.parse(checkDistStartTime1.substring(10, 12))) {
                                                                              if (int.parse(checkDistEndTime1.substring(10, 12)) <= int.parse(checkEndTime1.substring(10, 12))) {
                                                                                if (int.parse(checkDistStartTime1.substring(10, 12)) <= int.parse(checkStartTime1.substring(10, 12))) {
                                                                                  if (_distribution1TokenController.text.isNotEmpty) {
                                                                                    tokenBasedApiHit();
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Distribution Token1 should not be empty')));
                                                                                  }
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Distribution From Time1 should be Less than Consulting From Time1')));
                                                                                }
                                                                              } else {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Distribution To Time1 should be Less than Consulting To Time1')));
                                                                              }
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Distribution From Time1 should be Less than Distribution To Time1')));
                                                                            }
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Distribution Time')));
                                                                          }
                                                                          //
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(content: Text('Distribution Token2 should not be empty')));
                                                                        }
                                                                      } else {
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Distribution From Time2 should be Less than Consulting From Time2')));
                                                                      }
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              const SnackBar(content: Text('Distribution To Time2 should be Less than Consulting To Time2')));
                                                                    }
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Distribution From Time2 should be Less than Distribution To Time2')));
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Please Enter Distribution Time')));
                                                                }
                                                                //
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Distribution Token3 should not be empty')));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Distribution From Time3 should be Less than Consulting From Time3')));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Distribution To Time3 should be Less than Consulting To Time3')));
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Distribution From Time3 should be Less than Distribution To Time3')));
                                                        }
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Please Enter Distribution Time')));
                                                      }
                                                      //
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Distribution Token4 should not be empty')));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Distribution From Time4 should be Less than Consulting From Time4')));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Distribution To Time4 should be Less than Consulting To Time4')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Distribution From Time4 should be Less than Distribution To Time4')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Please Enter Distribution Time')));
                                            }
                                            //
                                          } else {
                                            print('nice');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Afternoon Time should be between 12pm to 4:59pm')));
                                          }
                                        } else {
                                          print('nice');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Morning Time should be between 12am to 11:59am')));
                                        }
                                      } else {
                                        print('nice');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Night Time should be between 7pm to 11:59pm')));
                                      }
                                    } else {
                                      print('nice');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Evening Time should be between 5pm to 6:59pm')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Morning From Time is Less than Morning To Time')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Afternoon From Time is Less than Afternoon To Time')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Evening From Time is Less than Evening To Time')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Night From Time is Less than Night To Time')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please Enter Night Time')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter Evening Time')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Afternoon Time')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Morning Time')));
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
                color: chip.status == 1 ? Colors.grey : const Color(0xff68A0F8),
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
