import 'package:doctor_clinic_token_app/View/Add%20Availability/time_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/token_tab_screen.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctorSchedule/addDoctorScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDaysStatus/availabilityDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/changeAvailabilityScheduleConfirm/changeAvailabilityScheduleConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/changeAvailabilityScheduleType/changeAvailabilityScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/deleteFullSchedule/deleteFullScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TimeAndTokenScreen extends StatefulWidget {
  const TimeAndTokenScreen({Key? key}) : super(key: key);

  @override
  _TimeAndTokenScreenState createState() => _TimeAndTokenScreenState();
}

class Tech {
  String label;

  Tech(this.label);
}

class _TimeAndTokenScreenState extends State<TimeAndTokenScreen> {
  AvailabilityDayStatusNotifier provider = AvailabilityDayStatusNotifier();
  DeleteAllScheduleNotifier deleteAllScheduleNotifier =
      DeleteAllScheduleNotifier();
  ChangeAvailabilityScheduleNotifier changeAvailabilityScheduleNotifier =
      ChangeAvailabilityScheduleNotifier();
  ChangeAvailabilityScheduleConfirmNotifier
      changeAvailabilityScheduleConfirmNotifier =
      ChangeAvailabilityScheduleConfirmNotifier();
  bool isSwitched = false;
  bool morningCheck = false;
  bool afternoonCheck = false;
  bool eveningCheck = false;
  bool nightCheck = false;
  int doctorId = 0;
  int doctorScheduleType = 0;

  TimeOfDay? startTime1 = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay? startTime2 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? startTime3 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? startTime4 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime1 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay? endTime2 = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay? endTime3 = const TimeOfDay(hour: 19, minute: 0);
  TimeOfDay? endTime4 = const TimeOfDay(hour: 22, minute: 0);
  final _schedulerController = TextEditingController();
  final _slotTimeController = TextEditingController();
  final _slotPerMemberController = TextEditingController();
  final _keyscafflod = GlobalKey<ScaffoldState>();
  late AddDoctorScheduleNotifier? addDoctorScheduleNotifier;
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
  int scheduleType = 0;

  var slotTimeItems = [
    '15 min',
    '30 min',
    '1 hour',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance
        .getDoctorScheduleType('doctorScheduleType')
        .then((value) {
      setState(() {
        scheduleType = value;
        print(doctorId);
      });
    });
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

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<DeleteAllScheduleNotifier>(
      builder: (context, provider, _) {
        deleteAllScheduleNotifier = provider;
        return SafeArea(
          child: Scaffold(
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
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
              scheduleTypeScreen(context),
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
                Navigator.pushReplacementNamed(
                    context, RoutePaths.ListAvailability);
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

  Widget selectionCheckBox(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            activeColor: Colors.blueAccent,
            value: 1,
            groupValue: scheduleType,
            onChanged: (int? val) {
              setState(() {
                changeAvailabilityScheduleNotifier.changeSchedule(
                    doctorId, scheduleType);
                listOfPatient(context, val!);
              });
            },
          ),
          const Text(
            'Time',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Radio(
            activeColor: Colors.blueAccent,
            value: 2,
            groupValue: scheduleType,
            onChanged: (int? val) {
              setState(() {
                changeAvailabilityScheduleNotifier.changeSchedule(
                    doctorId, scheduleType);
                if (!changeAvailabilityScheduleNotifier.isLoading) {
                  listOfPatient(context, val!);
                }
              });
            },
          ),
          const Text(
            'Token',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  listOfPatient(context, int val) {
    Future.delayed(Duration.zero, () {
      changeAvailabilityScheduleNotifier.changeSchedule(doctorId, scheduleType);
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration.zero, () {
          changeAvailabilityScheduleNotifier.changeSchedule(
              doctorId, scheduleType);
        });
        return Consumer<ChangeAvailabilityScheduleNotifier>(
          builder: (context, provider, _) {
            changeAvailabilityScheduleNotifier = provider;
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
                      submitAndCancelButton(context, val),
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
            changeAvailabilityScheduleNotifier.changeScheduleClass.length
                .toString(),
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
        child: changeAvailabilityScheduleNotifier.changeScheduleClass.isEmpty
            ? const Center(
                child: Text('No Patient Booked'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: changeAvailabilityScheduleNotifier
                    .changeScheduleClass.length,
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
                                  changeAvailabilityScheduleNotifier
                                      .changeScheduleClass[index].patientName
                                      .toString(),
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
                                  changeAvailabilityScheduleNotifier
                                      .changeScheduleClass[index].mobileNumber
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
      "Are you sure you want to Cancel the Appointments and Change the schedule type?",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey.shade700),
    );
  }

  Widget submitAndCancelButton(context, int val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
          child: Text(
            "Cancel",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.redAccent,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            "Confirm",
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            _showDeleteAllScheduleDialog(val);
          },
        ),
      ],
    );
  }

  void _showDeleteAllScheduleDialog(int val) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Change Schedule Type",
            style: const TextStyle(color: Colors.black),
          ),
          content: Text(
            "This will delete all the Availability Schedules which you have created before?",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Close",
                style: const TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Confirm",
                style: const TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  scheduleType = val;
                  MySharedPreferences.instance.setDoctorScheduleType(
                      'doctorScheduleType', scheduleType);
                  changeAvailabilityScheduleConfirmNotifier
                      .changeAvailabilityConfirm(
                    doctorId,
                    scheduleType,
                  );
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
              Navigator.pushReplacementNamed(
                  context, RoutePaths.ListAvailability);
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

  Widget scheduleTypeScreen(context) {
    return scheduleType == 1 ? const TimeTabScreen() : const TokenTabScreen();
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
}
