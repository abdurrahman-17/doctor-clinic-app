import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addWalkinPatient/addWalkinPatientNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getDoctorScheduleTime/getDoctorScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getDoctorScheduleToken/getDoctorScheduleTokenNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/DATE/date_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddWalkInPatient extends StatefulWidget {
  // final patientName;
  // final patientId;
  // final patientAge;
  // final patientGender;
  // AddInfoPatient({Key? key,this.patientId, this.patientName, this.patientAge, this.patientGender}) : super(key: key);

  @override
  _AddWalkInPatientState createState() => _AddWalkInPatientState();
}

class _AddWalkInPatientState extends State<AddWalkInPatient> {
  late AddPatientInfoNotifier? addPatientInfoNotifier;
  GetDoctorScheduleNotifier provider = GetDoctorScheduleNotifier();
  GetDoctorTokenScheduleNotifier provider2 = GetDoctorTokenScheduleNotifier();
  AddWalkinNotifier addWalkinNotifier = AddWalkinNotifier();

  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final bookedDateController = TextEditingController();
  final timeOrTokenController = TextEditingController();
  final healthIssueController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final diabetesController = TextEditingController();
  final temperatureController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final pulseRateController = TextEditingController();
  final spo2Controller = TextEditingController();

  String? dropDownGenderValue;
  String? Gender;
  String? dropDownScheduleValue;
  int scheduleView = 0;
  int bookingtype = 0;
  int scheduleType = 0;
  DateTime? todayDate = DateTime.now();
  String formatted = 'Date Of Birth';
  String dateOdBirthCheck = "";
  String outputDate = '';
  String outputDatedate = '';
  DateTime _selectedValue = DateTime.now();
  DatePickerController _controller = DatePickerController();

  String selectedTime = '';
  String selectedToken = '';
  String session = '';
  int? selectedIndex;
  int? selectedIndex2;
  int? selectedIndex3;
  int? selectedIndex4;
  int doctorId = 0;
  int parentId = 0;
  int doctorRole = 0;

  var slotGenderItems = [
    'Male',
    'Female',
  ];

  var slotScheduleTypeItems = [
    'Emergency',
  ];

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todayDate!,
      // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff68A1F8),
              surface: Color(0xff68A1F8),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
        //dateFormate Change
        final DateFormat format = DateFormat('yyyy-MM-dd');
        formatted = format.format(picked);
        dateOdBirthCheck = picked.toString();
      });
    }
  }

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
    MySharedPreferences.instance.getDoctorId('doctorID').then(
          (value) => setState(() {
            doctorId = value;
          }),
        );
    MySharedPreferences.instance.getDoctorClinicParentId('doctorParentId').then(
          (value) => setState(() {
            parentId = value;
          }),
        );
    MySharedPreferences.instance.getRole('doctorRole').then(
          (value) => setState(() {
            doctorRole = value;
          }),
        );
    MySharedPreferences.instance
        .getDoctorScheduleType('doctorScheduleType')
        .then(
          (value) => setState(
            () {
              scheduleType = value;
              if (scheduleType == 1) {
                slotScheduleTypeItems.insert(0, 'Time');
              } else if (scheduleType == 2) {
                slotScheduleTypeItems.insert(0, 'Token');
              }
            },
          ),
        );

    greeting();
    print(session);
    final todaydate = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    outputDatedate = formatter.format(todaydate);
    print(outputDatedate); // s
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        session = 'Morning';
      });
      return 'Morning';
    }
    if (hour < 17) {
      setState(() {
        session = 'Afternoon';
      });
      return 'Afternoon';
    }
    if (hour < 19) {
      setState(() {
        session = 'Evening';
      });
      return 'Evening';
    } else {
      setState(() {
        session = 'Night';
      });
      return 'Night';
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
                        Future.delayed(Duration.zero, () {
                          MySharedPreferences.instance
                              .getDoctorId('doctorID')
                              .then(
                                (value) => setState(() {
                                  doctorId = value;
                                }),
                              );
                          MySharedPreferences.instance
                              .getDoctorScheduleType('doctorScheduleType')
                              .then(
                                (value) => setState(
                                  () {
                                    scheduleType = value;
                                    if (scheduleType == 1) {
                                      slotScheduleTypeItems.insert(0, 'Time');
                                    } else if (scheduleType == 2) {
                                      slotScheduleTypeItems.insert(0, 'Token');
                                    }
                                  },
                                ),
                              );

                          greeting();
                          print(session);
                          final todaydate = DateTime.now();
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          outputDatedate = formatter.format(todaydate);
                          print(outputDatedate); // s

                          provider2.getDoctortokenSchedule(doctorId, outputDate,
                              outputDatedate); //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
                        });
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Text(
                    'Retry',
                  ))
            ],
            title: new Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
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
    return Consumer<AddWalkinNotifier>(
      builder: (context, provider1, _) {
        addWalkinNotifier = provider1;
        return ModalProgressHUD(
          inAsyncCall: provider1.isLoading,
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/verysmall.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.height * 0.18
                : MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButton(context),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // headingText(context),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            fullNameAndPhNumber(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            maleFemaleRadio(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            ageAndDOB(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            helathIssue(context),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]),
                        child: Column(
                          children: [
                            bloodPressureAndSPO2(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            temperatureAndHeartBeat(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            pulseRate(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            weightAndHeight(context),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    submitButton(context),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
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
          Text(
            'Add Walk In Patient',
            //widget.patientName,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget headingText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Abdul Rahman M',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget fullNameAndPhNumber(context) {
    return Column(
      children: [
        TextFormField(
          // validator: validateConfirmPassword,
          controller: fullNameController,
          // obscureText: _isObscure1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(),
            ),
            label: const Text('Full Name'),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        TextFormField(
          // validator: validateConfirmPassword,
          controller: phoneNumberController,
          // obscureText: _isObscure1,
          maxLength: 10,

          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(),
            ),
            label: const Text('Phone Number'),
          ),
        ),
      ],
    );
  }

  Widget maleFemaleRadio(context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade600,
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('Gender'),
                  value: dropDownGenderValue,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  onChanged: (String? value) {
                    setState(() {
                      dropDownGenderValue = value;

                      if (value == 'Male') {
                        Gender = 'M';
                        print(Gender);
                      } else if (value == 'Female') {
                        Gender = 'F';
                        print(Gender);
                      } else {
                        Gender = 'Other';
                        print(Gender);
                      }
                      print(Gender);
                    });
                  },
                  items: slotGenderItems.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade600,
                  width: 1.1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(formatted),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ageAndDOB(context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade600,
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('Appointment Type'),
                  value: dropDownScheduleValue,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  onChanged: (String? value) {
                    setState(() {
                      if (value == 'Time') {
                        dropDownScheduleValue = value;
                        scheduleView = 1;
                        bookingtype = 1;
                      } else if (value == 'Token') {
                        dropDownScheduleValue = value;
                        scheduleView = 2;
                        bookingtype = 2;
                      } else {
                        dropDownScheduleValue = value;
                        scheduleView = 0;
                        bookingtype = 3;
                      }
                    });
                  },
                  items: slotScheduleTypeItems.map((items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        scheduleView == 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextButton(
                  child: Text(
                    'Add Appointment',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                  onPressed: () {
                    var inputFormat = DateFormat('yyyy-MM-dd');
                    var inputDate = inputFormat.parse(
                        _selectedValue.toString()); // <-- dd/MM 24H format

                    var outputFormat = DateFormat('E');
                    outputDate = outputFormat.format(inputDate).toLowerCase();
                    var outputFormatdate = DateFormat('yyyy-MM-dd');
                    outputDatedate = outputFormatdate.format(inputDate);
                    print('abdul' + outputDate); // 12

                    showTimeAppointment(context);
                  },
                ),
              )
            : scheduleView == 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextButton(
                      child: Text(
                        'Add Appointment',
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                      onPressed: () {
                        var inputFormat = DateFormat('yyyy-MM-dd');
                        var inputDate = inputFormat.parse(
                            _selectedValue.toString()); // <-- dd/MM 24H format

                        var outputFormat = DateFormat('E');
                        outputDate =
                            outputFormat.format(inputDate).toLowerCase();
                        var outputFormatdate = DateFormat('yyyy-MM-dd');
                        outputDatedate = outputFormatdate.format(inputDate);
                        print('abdul' + outputDate); //// 12

                        provider2.getDoctortokenSchedule(
                            doctorId, outputDate, outputDatedate);
                        showTokenAppointment(context);
                      },
                    ),
                  )
                : Container(),
      ],
    );
  }

  showTimeAppointment(context) {
    Future.delayed(Duration.zero, () {
      provider.getDoctorScheduleTime(
          doctorRole == 2 ? parentId : doctorId, outputDate, outputDatedate);
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration.zero, () {
          provider.getDoctorScheduleTime(doctorRole == 2 ? parentId : doctorId,
              outputDate, outputDatedate);
        });
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.maxFinite,
              child: Consumer<GetDoctorScheduleNotifier>(
                builder: (context, provider, _) {
                  this.provider = provider;
                  return Column(
                    children: [
                      buildSelectDateTime(context),
                      provider.isLoading == true
                          ? Expanded(
                              child: Container(
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            )
                          : Expanded(
                              child: Container(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 60),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        buildAvailableTime(context),
                                        buildTimeList(context, setState),
                                        buildAfternoonTime(context),
                                        buildAfternoonList(context, setState),
                                        buildEveningTime(context),
                                        buildEveningList(context, setState),
                                        buildNightTime(context),
                                        buildNightList(context, setState),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: SizedBox(
                          width: 180,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff4889FD),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Select',
                                textAlign: TextAlign.center,
                                style: TextButtonStyle(context),
                              )),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }

  showTokenAppointment(context) {
    Future.delayed(Duration.zero, () {
      provider2.getDoctortokenSchedule(
          doctorRole == 2 ? parentId : doctorId, outputDate, outputDatedate);
    });
    // provider2.getDoctortokenSchedule(
    //    doctorId, outputDate, outputDatedate);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration.zero, () {
          provider2.getDoctortokenSchedule(
              doctorRole == 2 ? parentId : doctorId,
              outputDate,
              outputDatedate);
        });
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.maxFinite,
              child: Consumer<GetDoctorTokenScheduleNotifier>(
                  builder: (context, provider, _) {
                provider2 = provider;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildSelectDateToken(context),
                    SizedBox(
                      height: 20,
                    ),
                    provider.isLoading == true
                        ? Expanded(
                            child: Container(
                                child:
                                    Center(child: CircularProgressIndicator())),
                          )
                        : Expanded(
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.45,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildAvailableToken(context),
                                    buildTimeListToken(context, setState),
                                    buildAfternoonToken(context),
                                    buildAfternoonListToken(context, setState),
                                    buildEveningToken(context),
                                    buildEveningListToken(context, setState),
                                    buildNightToken(context),
                                    buildNightListToken(context, setState),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          width: 180,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff4889FD),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Select',
                                textAlign: TextAlign.center,
                                style: TextButtonStyle(context),
                              )),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        });
      },
    );
  }

  Widget buildAvailableToken(BuildContext context) {
    return provider2.getDoctorSchedules_morning_token.isEmpty &&
            provider2.getDoctorSchedules_afternoon_token.isEmpty &&
            provider2.getDoctorSchedules_evening_token.isEmpty &&
            provider2.getDoctorSchedules_night_token.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 200),
            child: Container(
                height: 100,
                child: Center(
                    child: Text('Doctor is Not Available in this date'))),
          )
        : provider2.getDoctorSchedules_morning_token.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 30, left: 25),
                child: Text(
                  'Morning Time',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              );
  }

  Widget buildAfternoonToken(BuildContext context) {
    return provider2.getDoctorSchedules_afternoon_token.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30, left: 25),
            child: Text(
              'Afternoon Time',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
  }

  Widget buildEveningToken(BuildContext context) {
    return provider2.getDoctorSchedules_evening_token.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30, left: 25),
            child: Text(
              'Evening Time',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
  }

  Widget buildNightToken(BuildContext context) {
    return provider2.getDoctorSchedules_night_token.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30, left: 25),
            child: Text(
              'Night Time',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
  }

  Widget buildTimeListToken(BuildContext context, setState) {
    return provider2.getDoctorSchedules_morning_token.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child:
                //provider.doctor_Schedule_ResponseClass.length==0?Center(child: Text('No Data Found')):
                Column(
              children: [
                Center(
                  child: Wrap(
                    //spacing: 30,
                    alignment: WrapAlignment.start,
                    spacing: 3,
                    runSpacing: 12,
                    direction: Axis.horizontal,
                    children: techChipsMorningToken(setState),
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildAfternoonListToken(BuildContext context, setState) {
    return provider2.getDoctorSchedules_afternoon_token.isEmpty
        ? Container()
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 3,
                  runSpacing: 12,
                  direction: Axis.horizontal,
                  children: techChipsAfternoonToken(setState),
                ),
              ),
            ),
          );
  }

  Widget buildEveningListToken(BuildContext context, setState) {
    return provider2.getDoctorSchedules_evening_token.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: Wrap(
                //spacing: 30,
                alignment: WrapAlignment.start,
                spacing: 3,
                runSpacing: 12,
                direction: Axis.horizontal,
                children: techChipsEveningToken(setState),
              ),
            ),
          );
  }

  Widget buildNightListToken(BuildContext context, setState) {
    return provider2.getDoctorSchedules_night_token.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: Wrap(
                //spacing: 30,
                alignment: WrapAlignment.start,
                spacing: 3,
                runSpacing: 12,
                direction: Axis.horizontal,
                children: techChipsNightToken(setState),
              ),
            ),
          );
  }

  List<Widget> techChipsMorningToken(setState) {
    List<Widget> chips = [];
    for (int i = 0;
        i < provider2.getDoctorSchedules_morning_token.length;
        i++) {
      //for(int j=0;j<provider.doctor_Schedule_ResponseClass[i].morning!.length;j++){
      Widget item = Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex == i ? Colors.white : Colors.black,
            // ),
            label: Container(
              height: 35,
              width: 20,
              child: Center(
                child: Text(
                  provider2.getDoctorSchedules_morning_token[i].tokenNo
                      .toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedIndex == i
                        ? Colors.white
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(
              color: selectedIndex == i
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            disabledColor: Color(0xffeeeeee),
            selectedColor: Color(0xff4889FD),
            backgroundColor: Colors.white,
            selected: selectedIndex == i,
            onSelected: provider2.getDoctorSchedules_morning_token[i].status ==
                    1
                ? null
                : (bool value) {
                    setState(() {
                      print(i);
                      if (selectedIndex2 != null) {
                        selectedIndex2 = null;
                        selectedIndex = i;
                        selectedToken = provider2
                            .getDoctorSchedules_morning_token[i].tokenNo
                            .toString();
                        session = 'Morning';
                        print(session);
                      } else if (selectedIndex3 != null) {
                        selectedIndex3 = null;
                        selectedIndex = i;
                        selectedToken = provider2
                            .getDoctorSchedules_morning_token[i].tokenNo
                            .toString();
                        session = 'Morning';
                        print(session);
                      } else if (selectedIndex4 != null) {
                        selectedIndex4 = null;
                        selectedIndex = i;
                        selectedToken = provider2
                            .getDoctorSchedules_morning_token[i].tokenNo
                            .toString();
                        session = 'Morning';
                        print(session);
                      } else if (selectedIndex2 == null &&
                          selectedIndex3 == null &&
                          selectedIndex4 == null) {
                        selectedIndex = i;
                        selectedToken = provider2
                            .getDoctorSchedules_morning_token[i].tokenNo
                            .toString();
                        session = 'Morning';
                        print(session);
                      }
                      print('irfan' +
                          provider2.getDoctorSchedules_morning_token[i].tokenNo
                              .toString());
                    });
                  },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsAfternoonToken(setState) {
    List<Widget> chips = [];
    for (int k = 0;
        k < provider2.getDoctorSchedules_afternoon_token.length;
        k++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex2 == k ? Colors.white : Colors.black,
            // ),
            label: Container(
              height: 35,
              width: 20,
              child: Center(
                child: Text(
                  provider2.getDoctorSchedules_afternoon_token[k].tokenNo
                      .toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedIndex2 == k
                        ? Colors.white
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex2 == k,
            onSelected:
                provider2.getDoctorSchedules_afternoon_token[k].status == 1
                    ? null
                    : (bool value) {
                        setState(() {
                          print(k);
                          if (selectedIndex != null) {
                            selectedIndex = null;
                            selectedIndex2 = k;
                            selectedToken = provider2
                                .getDoctorSchedules_afternoon_token[k].tokenNo
                                .toString();
                            session = 'Afternoon';
                            print(session);
                          } else if (selectedIndex3 != null) {
                            selectedIndex3 = null;
                            selectedIndex2 = k;
                            selectedToken = provider2
                                .getDoctorSchedules_afternoon_token[k].tokenNo
                                .toString();
                            session = 'Afternoon';
                            print(session);
                          } else if (selectedIndex4 != null) {
                            selectedIndex4 = null;
                            selectedIndex2 = k;
                            selectedToken = provider2
                                .getDoctorSchedules_afternoon_token[k].tokenNo
                                .toString();
                            session = 'Afternoon';
                            print(session);
                          } else if (selectedIndex == null &&
                              selectedIndex3 == null &&
                              selectedIndex4 == null) {
                            selectedIndex2 = k;
                            selectedToken = provider2
                                .getDoctorSchedules_afternoon_token[k].tokenNo
                                .toString();
                            session = 'Afternoon';
                            print(session);
                            print("sorry");
                          }

                          print('abdul' +
                              provider2
                                  .getDoctorSchedules_afternoon_token[k].tokenNo
                                  .toString());
                        });
                      },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsEveningToken(setState) {
    List<Widget> chips = [];
    for (int m = 0;
        m < provider2.getDoctorSchedules_evening_token.length;
        m++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex3 == m ? Colors.white : Colors.black,
            // ),
            label: Container(
              height: 35,
              width: 20,
              child: Center(
                child: Text(
                  provider2.getDoctorSchedules_evening_token[m].tokenNo
                      .toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedIndex3 == m
                        ? Colors.white
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(
              color: selectedIndex3 == m
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex3 == m,
            onSelected:
                provider2.getDoctorSchedules_evening_token[m].status == 1
                    ? null
                    : (bool value) {
                        setState(() {
                          print(m);
                          if (selectedIndex != null) {
                            selectedIndex = null;
                            selectedIndex3 = m;
                            selectedToken = provider2
                                .getDoctorSchedules_evening_token[m].tokenNo
                                .toString();
                            session = 'Evening';
                            print(session);
                          } else if (selectedIndex2 != null) {
                            selectedIndex2 = null;
                            selectedIndex3 = m;
                            selectedToken = provider2
                                .getDoctorSchedules_evening_token[m].tokenNo
                                .toString();
                            session = 'Evening';
                            print(session);
                          } else if (selectedIndex4 != null) {
                            selectedIndex4 = null;
                            selectedIndex3 = m;
                            selectedToken = provider2
                                .getDoctorSchedules_evening_token[m].tokenNo
                                .toString();
                            session = 'Evening';
                            print(session);
                          } else if (selectedIndex == null &&
                              selectedIndex2 == null &&
                              selectedIndex4 == null) {
                            selectedIndex3 = m;
                            selectedToken = provider2
                                .getDoctorSchedules_evening_token[m].tokenNo
                                .toString();
                            session = 'Evening';
                            print(session);
                            print("sorry");
                          }

                          print(provider2
                              .getDoctorSchedules_evening_token[m].tokenNo);
                        });
                      },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsNightToken(setState) {
    List<Widget> chips = [];
    for (int n = 0; n < provider2.getDoctorSchedules_night_token.length; n++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex4 == n ? Colors.white : Colors.black,
            // ),
            label: Container(
              height: 35,
              width: 20,
              child: Center(
                child: Text(
                  provider2.getDoctorSchedules_night_token[n].tokenNo
                      .toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedIndex4 == n
                        ? Colors.white
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(
              color: selectedIndex4 == n
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex4 == n,
            onSelected: provider2.getDoctorSchedules_night_token[n].status == 1
                ? null
                : (bool value) {
                    setState(() {
                      print(n);
                      if (selectedIndex != null) {
                        selectedIndex = null;
                        selectedIndex4 = n;
                        selectedToken = provider2
                            .getDoctorSchedules_night_token[n].tokenNo
                            .toString();
                        session = 'Night';
                        print(session);
                      } else if (selectedIndex2 != null) {
                        selectedIndex2 = null;
                        selectedIndex4 = n;
                        selectedToken = provider2
                            .getDoctorSchedules_night_token[n].tokenNo
                            .toString();
                        session = 'Night';
                        print(session);
                      } else if (selectedIndex3 != null) {
                        selectedIndex3 = null;
                        selectedIndex4 = n;
                        selectedToken = provider2
                            .getDoctorSchedules_night_token[n].tokenNo
                            .toString();
                        session = 'Night';
                        print(session);
                      } else if (selectedIndex == null &&
                          selectedIndex2 == null &&
                          selectedIndex3 == null) {
                        selectedIndex4 = n;
                        selectedToken = provider2
                            .getDoctorSchedules_night_token[n].tokenNo
                            .toString();
                        session = 'Night';
                        print(session + "praveen");
                        print("sorry");
                      }

                      print(
                          provider2.getDoctorSchedules_night_token[n].tokenNo);
                    });
                  },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  Widget buildAvailableTime(BuildContext context) {
    return provider.getDoctorSchedules_morning.isEmpty &&
            provider.getDoctorSchedules_afternoon.isEmpty &&
            provider.getDoctorSchedules_evening.isEmpty &&
            provider.getDoctorSchedules_night.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
                height: 100,
                child: Center(
                    child: Text('Doctor is Not Available in this date'))),
          )
        : provider.getDoctorSchedules_morning.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 30, left: 25),
                child: Text(
                  'Morning Time',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              );
  }

  Widget buildAfternoonTime(BuildContext context) {
    return provider.getDoctorSchedules_afternoon.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30, left: 25),
            child: Text(
              'Aternoon Time',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
  }

  Widget buildEveningTime(BuildContext context) {
    return provider.getDoctorSchedules_evening.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30, left: 25),
            child: Text(
              'Evening Time',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
  }

  Widget buildNightTime(BuildContext context) {
    return provider.getDoctorSchedules_night.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30, left: 25),
            child: Text(
              'Night Time',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          );
  }

  Widget buildTimeList(BuildContext context, setState) {
    return provider.getDoctorSchedules_morning.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
            child:
                //provider.doctor_Schedule_ResponseClass.length==0?Center(child: Text('No Data Found')):
                Column(
              children: [
                Wrap(
                  //spacing: 30,
                  direction: Axis.horizontal,
                  children: techChipsMorning(setState),
                ),
              ],
            ),
          );
  }

  Widget buildAfternoonList(BuildContext context, setState) {
    return provider.getDoctorSchedules_afternoon.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: 20, left: 5, right: 5),
            child: Wrap(
              //spacing: 30,
              direction: Axis.horizontal,
              children: techChipsAfternoon(setState),
            ),
          );
  }

  Widget buildEveningList(BuildContext context, setState) {
    return provider.getDoctorSchedules_evening.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: 20, left: 5, right: 5),
            child: Wrap(
              //spacing: 30,
              direction: Axis.horizontal,
              children: techChipsEvening(setState),
            ),
          );
  }

  Widget buildNightList(BuildContext context, setState) {
    return provider.getDoctorSchedules_night.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 5,
              right: 5,
            ),
            child: Wrap(
              //spacing: 30,
              direction: Axis.horizontal,
              children: techChipsNight(setState),
            ),
          );
  }

  Widget buildSelectDateTime(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text("You Selected:"),
          // Padding(
          //   padding: EdgeInsets.all(10),
          // ),
          // Text(_selectedValue.toString()),
          // Padding(
          //   padding: EdgeInsets.all(20),
          // ),
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 65,
              height: 90,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Color(0xff4889FD),
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(
                color: Colors.black,
              ),
              dayTextStyle: TextStyle(
                color: Colors.black,
              ),
              // inactiveDates: [
              //   DateTime.now().add(Duration(days: 3)),
              //    DateTime.now().add(Duration(days: 4)),
              //    DateTime.now().add(Duration(days: 7))
              // ],
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                  print(_selectedValue.toString());
                  var inputFormat = DateFormat('yyyy-MM-dd');
                  var inputDate = inputFormat
                      .parse(_selectedValue.toString()); // <-- dd/MM 24H format

                  var outputFormat = DateFormat('E');
                  outputDate = outputFormat.format(inputDate).toLowerCase();
                  var outputFormatdate = DateFormat('yyyy-MM-dd');
                  outputDatedate = outputFormatdate.format(inputDate);
                  print('abdul' + outputDate); // 12
                  print('irfan' + outputDatedate); // 12
                  provider.getDoctorScheduleTime(
                      doctorRole == 2 ? parentId : doctorId,
                      outputDate,
                      outputDatedate.toString());

                  // for(int a=0;a<provider.doctor_Schedule_ResponseClass.length;a++){
                  //   for(int b=0;b<provider.doctor_Schedule_ResponseClass[a].tokenTime!.length;b++)
                  //   {
                  //     if(provider.doctor_Schedule_ResponseClass[a].fromSession=='Evening'){
                  //       data=provider.doctor_Schedule_ResponseClass[a].tokenTime![b].length;
                  //       print(data);
                  //       print('irfan');
                  //     }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectDateToken(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text("You Selected:"),
          // Padding(
          //   padding: EdgeInsets.all(10),
          // ),
          // Text(_selectedValue.toString()),
          // Padding(
          //   padding: EdgeInsets.all(20),
          // ),
          Container(
            child: DatePicker(
              DateTime.now(),
              width: 65,
              height: 90,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: Color(0xff4889FD),
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(
                color: Colors.black,
              ),
              dayTextStyle: TextStyle(
                color: Colors.black,
              ),
              // inactiveDates: [
              //   DateTime.now().add(Duration(days: 3)),
              //    DateTime.now().add(Duration(days: 4)),
              //    DateTime.now().add(Duration(days: 7))
              // ],
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                  print(_selectedValue.toString());
                  var inputFormat = DateFormat('yyyy-MM-dd');
                  var inputDate = inputFormat
                      .parse(_selectedValue.toString()); // <-- dd/MM 24H format

                  var outputFormat = DateFormat('E');
                  outputDate = outputFormat.format(inputDate).toLowerCase();
                  var outputFormatdate = DateFormat('yyyy-MM-dd');
                  outputDatedate = outputFormatdate.format(inputDate);
                  print('abdul' + outputDate); // 12
                  print('irfan' + outputDatedate); // 12
                  provider2.getDoctortokenSchedule(
                      doctorRole == 2 ? parentId : doctorId,
                      outputDate,
                      outputDatedate.toString());

                  // for(int a=0;a<provider.doctor_Schedule_ResponseClass.length;a++){
                  //   for(int b=0;b<provider.doctor_Schedule_ResponseClass[a].tokenTime!.length;b++)
                  //   {
                  //     if(provider.doctor_Schedule_ResponseClass[a].fromSession=='Evening'){
                  //       data=provider.doctor_Schedule_ResponseClass[a].tokenTime![b].length;
                  //       print(data);
                  //       print('irfan');
                  //     }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget helathIssue(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: healthIssueController,
      // obscureText: _isObscure1,
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        fillColor: Colors.white,
        alignLabelWithHint: true,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        label: const Text('Health Issue'),
      ),
    );
  }

  Widget bloodPressureAndSPO2(context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: bloodPressureController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: FittedBox(child: const Text('BP')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'mm/Hg',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: diabetesController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: FittedBox(child: const Text('Diabetes')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'mg/dL',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget temperatureAndHeartBeat(context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: temperatureController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: FittedBox(
                child: const Text('Temp'),
              ),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      '°F',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: spo2Controller,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: FittedBox(child: const Text('SPO2')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      '%',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pulseRate(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: pulseRateController,
      // obscureText: _isObscure1,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        label: FittedBox(child: const Text('Pulse')),
        suffixIcon: Container(
          width: 10,
          decoration: BoxDecoration(
            color: const Color(0xff4889FD),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(),
            child: Center(
              child: Text(
                'b/mts',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget weightAndHeight(context) {
    return Row(
      children: [
        // Expanded(
        //   flex: 1,
        //   child: TextFormField(
        //     // validator: validateConfirmPassword,
        //     controller: pulseRateController,
        //     // obscureText: _isObscure1,
        //     keyboardType: TextInputType.number,
        //     decoration: InputDecoration(
        //       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        //       fillColor: Colors.white,
        //       filled: true,
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         borderSide: const BorderSide(),
        //       ),
        //       label: FittedBox(child: const Text('Pulse Rate')),
        //       suffixIcon: Container(
        //         width: 10,
        //         decoration: BoxDecoration(
        //           color: const Color(0xff4889FD),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: const Padding(
        //           padding: EdgeInsets.symmetric(),
        //           child: Center(
        //             child: Text(
        //               'b/mts',
        //               textAlign: TextAlign.center,
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 30,
        // ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: heightController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: FittedBox(
                child: const Text('Height'),
              ),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: weightController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: FittedBox(child: const Text('Weight')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'kg',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton(context) {
    return Center(
      child: SizedBox(
        width: 180,
        height: 50,
        child: ElevatedButton(
          style: getButtonStyle(context),
          onPressed: () async {
            if (fullNameController.text.isNotEmpty) {
              if (phoneNumberController.text.isNotEmpty) {
                if (healthIssueController.text.isNotEmpty) {
                  if (dropDownGenderValue != null) {
                    if (dateOdBirthCheck != "") {
                      if (dropDownScheduleValue != null) {
                        addWalkinNotifier.addWalkInInfo(
                          doctorId,
                          outputDatedate,
                          outputDate,
                          session,
                          healthIssueController.text,
                          selectedTime,
                          selectedToken,
                          fullNameController.text,
                          bookingtype,
                          formatted,
                          Gender.toString(),
                          int.parse(phoneNumberController.text),
                          heightController.text.isNotEmpty
                              ? int.parse(heightController.text)
                              : 0,
                          weightController.text.isNotEmpty
                              ? int.parse(weightController.text)
                              : 0,
                          pulseRateController.text.isNotEmpty
                              ? int.parse(pulseRateController.text)
                              : 0,
                          spo2Controller.text.isNotEmpty
                              ? int.parse(spo2Controller.text)
                              : 0,
                          temperatureController.text.isNotEmpty
                              ? int.parse(temperatureController.text)
                              : 0,
                          bloodPressureController.text.isNotEmpty
                              ? int.parse(bloodPressureController.text)
                              : 0,
                          diabetesController.text.isNotEmpty
                              ? int.parse(diabetesController.text)
                              : 0,
                          //bookingtype,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Select Appointment')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Select DateOfBirth')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please Select Gender')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Enter Health Issue')));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Enter Phone Number')));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Please Enter Name')));
            }
          },
          child: Text(
            'Submit',
            style: TextButtonStyle(context),
          ),
        ),
      ),
      // child: SizedBox(
      //   height: 45,
      //   width: 120,
      //   child: OutlinedButton(
      //     onPressed: () {
      //       // addPatientInfoNotifier?.addPatientInfo(
      //       //   widget.patientId,
      //       //   int.parse(bloodpressureController.text),
      //       //   int.parse(diabetesController.text),
      //       //   double.parse(temperatureController.text),
      //       //   int.parse(heartBeatController.text),
      //       //   int.parse(weightController.text),
      //       //   double.parse(heightController.text),
      //       // );
      //       // Navigator.pushNamed(context, RoutePaths.PatientData);
      //     },
      //     style: ButtonStyle(
      //       side: MaterialStateProperty.all(
      //         const BorderSide(
      //           color: Color(0xff6EA7FA),
      //           width: 2,
      //         ),
      //       ),
      //       shape: MaterialStateProperty.all(
      //         RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     child: const Text(
      //       'Submit',
      //       style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.w600,
      //         color: Color(0xff6EA7FA),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  List<Widget> techChipsMorning(setState) {
    List<Widget> chips = [];
    for (int i = 0; i < provider.getDoctorSchedules_morning.length; i++) {
      //for(int j=0;j<provider.doctor_Schedule_ResponseClass[i].morning!.length;j++){
      Widget item = Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex == i ? Colors.white : Colors.black,
            // ),
            label:
                Text(provider.getDoctorSchedules_morning[i].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex == i
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            disabledColor: Color(0xffeeeeee),
            selectedColor: Color(0xff4889FD),
            backgroundColor: Colors.white,
            selected: selectedIndex == i,
            onSelected: provider.getDoctorSchedules_morning[i].status == 1
                ? null
                : (bool value) {
                    setState(() {
                      print(i);
                      if (selectedIndex2 != null) {
                        selectedIndex2 = null;
                        selectedIndex = i;
                        selectedTime = provider
                            .getDoctorSchedules_morning[i].time
                            .toString();
                        session = 'Morning';
                      } else if (selectedIndex3 != null) {
                        selectedIndex3 = null;
                        selectedIndex = i;
                        selectedTime = provider
                            .getDoctorSchedules_morning[i].time
                            .toString();
                        session = 'Morning';
                      } else if (selectedIndex4 != null) {
                        selectedIndex4 = null;
                        selectedIndex = i;
                        selectedTime = provider
                            .getDoctorSchedules_morning[i].time
                            .toString();
                        session = 'Morning';
                      } else if (selectedIndex2 == null &&
                          selectedIndex3 == null &&
                          selectedIndex4 == null) {
                        selectedIndex = i;
                        selectedTime = provider
                            .getDoctorSchedules_morning[i].time
                            .toString();
                        session = 'Morning';
                      }
                      print('irfan' +
                          provider.getDoctorSchedules_morning[i].time
                              .toString());
                    });
                  },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsAfternoon(setState) {
    List<Widget> chips = [];
    for (int k = 0; k < provider.getDoctorSchedules_afternoon.length; k++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex2 == k ? Colors.white : Colors.black,
            // ),
            label: Text(
                provider.getDoctorSchedules_afternoon[k].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex2 == k
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex2 == k,
            onSelected: provider.getDoctorSchedules_afternoon[k].status == 1
                ? null
                : (bool value) {
                    setState(() {
                      print(k);
                      if (selectedIndex != null) {
                        selectedIndex = null;
                        selectedIndex2 = k;
                        selectedTime = provider
                            .getDoctorSchedules_afternoon[k].time
                            .toString();
                        session = 'Afternoon';
                      } else if (selectedIndex3 != null) {
                        selectedIndex3 = null;
                        selectedIndex2 = k;
                        selectedTime = provider
                            .getDoctorSchedules_afternoon[k].time
                            .toString();
                        session = 'Afternoon';
                      } else if (selectedIndex4 != null) {
                        selectedIndex4 = null;
                        selectedIndex2 = k;
                        selectedTime = provider
                            .getDoctorSchedules_afternoon[k].time
                            .toString();
                        session = 'Afternoon';
                      } else if (selectedIndex == null &&
                          selectedIndex3 == null &&
                          selectedIndex4 == null) {
                        selectedIndex2 = k;
                        selectedTime = provider
                            .getDoctorSchedules_afternoon[k].time
                            .toString();
                        session = 'Afternoon';
                        print("sorry");
                      }

                      print('abdul' +
                          provider.getDoctorSchedules_afternoon[k].time
                              .toString());
                    });
                  },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsEvening(setState) {
    List<Widget> chips = [];
    for (int m = 0; m < provider.getDoctorSchedules_evening.length; m++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex3 == m ? Colors.white : Colors.black,
            // ),
            label:
                Text(provider.getDoctorSchedules_evening[m].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex3 == m
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex3 == m,
            onSelected: provider.getDoctorSchedules_evening[m].status == 1
                ? null
                : (bool value) {
                    setState(() {
                      print(m);
                      if (selectedIndex != null) {
                        selectedIndex = null;
                        selectedIndex3 = m;
                        selectedTime = provider
                            .getDoctorSchedules_evening[m].time
                            .toString();
                        session = 'Evening';
                      } else if (selectedIndex2 != null) {
                        selectedIndex2 = null;
                        selectedIndex3 = m;
                        selectedTime = provider
                            .getDoctorSchedules_evening[m].time
                            .toString();
                        session = 'Evening';
                      } else if (selectedIndex4 != null) {
                        selectedIndex4 = null;
                        selectedIndex3 = m;
                        selectedTime = provider
                            .getDoctorSchedules_evening[m].time
                            .toString();
                        session = 'Evening';
                      } else if (selectedIndex == null &&
                          selectedIndex2 == null &&
                          selectedIndex4 == null) {
                        selectedIndex3 = m;
                        selectedTime = provider
                            .getDoctorSchedules_evening[m].time
                            .toString();
                        session = 'Evening';
                        print("sorry");
                      }

                      print(provider.getDoctorSchedules_evening[m].time);
                    });
                  },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }

  List<Widget> techChipsNight(setState) {
    List<Widget> chips = [];
    for (int n = 0; n < provider.getDoctorSchedules_night.length; n++) {
      //for(int l=0;l<provider.doctor_Schedule_ResponseClass[k].evening!.length;l++){
      Widget item = Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey.shade200)),
            // avatar: Icon(
            //   CupertinoIcons.clock,
            //   size: 18,
            //   color: selectedIndex4 == n ? Colors.white : Colors.black,
            // ),
            label: Text(provider.getDoctorSchedules_night[n].time12.toString()),
            labelStyle: TextStyle(
              color: selectedIndex4 == n
                  ? Colors.white
                  : Colors.black.withOpacity(0.7),
            ),
            selectedColor: Color(0xff4889FD),
            disabledColor: Color(0xffeeeeee),
            backgroundColor: Colors.white,
            selected: selectedIndex4 == n,
            onSelected: provider.getDoctorSchedules_night[n].status == 1
                ? null
                : (bool value) {
                    setState(() {
                      print(n);
                      if (selectedIndex != null) {
                        selectedIndex = null;
                        selectedIndex4 = n;
                        selectedTime = provider.getDoctorSchedules_night[n].time
                            .toString();
                        session = 'Night';
                      } else if (selectedIndex2 != null) {
                        selectedIndex2 = null;
                        selectedIndex4 = n;
                        selectedTime = provider.getDoctorSchedules_night[n].time
                            .toString();
                      } else if (selectedIndex3 != null) {
                        selectedIndex3 = null;
                        selectedIndex4 = n;
                        selectedTime = provider.getDoctorSchedules_night[n].time
                            .toString();
                        session = 'Night';
                      } else if (selectedIndex == null &&
                          selectedIndex2 == null &&
                          selectedIndex3 == null) {
                        selectedIndex4 = n;
                        selectedTime = provider.getDoctorSchedules_night[n].time
                            .toString();
                        session = 'Night';
                        print("sorry");
                      }

                      print(provider.getDoctorSchedules_night[n].time);
                    });
                  },
          ));
      chips.add(item);
    }
    //}
    return chips;
  }
}
