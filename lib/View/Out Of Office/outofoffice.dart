import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeave/doctorLeaveNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveConfirm/doctorLeaveConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveDays/doctorLeaveDaysNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveDelete/doctorLeaveDeleteNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorTimeLeave/doctorTimeLeaveNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorTimeLeaveConfirm/doctorTimeLeaveConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class OutOfOffice extends StatefulWidget {
  const OutOfOffice({Key? key}) : super(key: key);

  @override
  _OutOfOfficeState createState() => _OutOfOfficeState();
}

class _OutOfOfficeState extends State<OutOfOffice> {
  DoctorLeaveNotifier doctorLeaveNotifier = DoctorLeaveNotifier();
  DoctorLeaveConfirmNotifier doctorLeaveConfirmNotifier =
      DoctorLeaveConfirmNotifier();
  DoctorLeaveDaysNotifier doctorLeaveDaysNotifier = DoctorLeaveDaysNotifier();
  DoctorLeaveDeleteNotifier doctorLeaveDeleteNotifier =
      DoctorLeaveDeleteNotifier();
  DoctorTimeLeaveNotifier doctorTimeLeaveNotifier = DoctorTimeLeaveNotifier();
  DoctorTimeLeaveConfirmNotifier doctorTimeLeaveConfirmNotifier =
      DoctorTimeLeaveConfirmNotifier();

  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();
  DateTime now = DateTime.now();
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  var checkDate1 = '';
  var checkDate2 = '';
  var checkTime1 = '';
  var checkTime2 = '';
  int leaveValue = 1;
  int doctorId = 0;
  int navigateBackCount = 0;
  String outputFromTime = '';
  String outputToTime = '';
  String convertedDate1 = '';
  String convertedDate2 = '';

  final reasonController = TextEditingController();

  //int timeValue = -1;

  _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate!,
      // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff68A1F8),
              surface: Color(0xff68A1F8),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
        checkDate1 = picked.toString();
      });
    }
  }

  _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate!,
      // Refer step 1
      firstDate: fromDate!,
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff68A1F8),
              surface: Color(0xff68A1F8),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
        checkDate2 = picked.toString();
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
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });

    Future.delayed(Duration.zero, () {
      doctorLeaveDaysNotifier.doctorLeaveDays(doctorId).then((value) {
        print(doctorLeaveDaysNotifier.msg);
        print('Hello');
        doctorLeaveDaysNotifier.notifyListeners();
      });
    });
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
    return buildBody(context);
  }

  Widget buildBody(context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? secondMainBody(context)
            : secondMainBodyLandscape(context),
      ),
    );
  }

  Widget secondMainBody(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/dashboardmain.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            selectionCheckBox(context),
            const SizedBox(
              height: 15,
            ),
            dateStartAndEnd(context),
            leaveValue == 1 || leaveValue == 2
                ? const SizedBox(
                    height: 30,
                  )
                : Container(),
            timeStartAndEnd(context),
            leaveValue == 1 && leaveValue == 2
                ? Container()
                : const SizedBox(
                    height: 40,
                  ),
            submitButton(context),
            const SizedBox(
              height: 50,
            ),
            outOfOfficeList(context),
          ],
        )
      ],
    );
  }

  Widget secondMainBodyLandscape(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/dashboardmain.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.055,
              ),
              selectionCheckBox(context),
              const SizedBox(
                height: 15,
              ),
              dateStartAndEnd(context),
              leaveValue == 1 || leaveValue == 2
                  ? const SizedBox(
                      height: 30,
                    )
                  : Container(),
              timeStartAndEnd(context),
              leaveValue == 1 && leaveValue == 2
                  ? Container()
                  : const SizedBox(
                      height: 40,
                    ),
              submitButton(context),
              const SizedBox(
                height: 50,
              ),
              outOfOfficeListLandscape(context),
            ],
          )
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 15.0, bottom: 0, left: 5.0, right: 5.0),
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
          'Out of Office',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ]),
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

  Widget selectionCheckBox(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            activeColor: Colors.blueAccent,
            value: 1,
            groupValue: leaveValue,
            onChanged: (int? val) {
              setState(() {
                leaveValue = val!;
              });
            },
          ),
          const Text(
            'Leave',
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
            groupValue: leaveValue,
            onChanged: (int? val) {
              setState(() {
                leaveValue = val!;
              });
            },
          ),
          const Text(
            'Time',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget dateStartAndEnd(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leaveValue == 1 || leaveValue == 2
              ? Row(
                  children: [
                    const Text(
                      'From',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff68A1F8), width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${fromDate?.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              color: checkDate1 == ""
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        _selectFromDate(context);
                      },
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            width: 15,
          ),
          leaveValue == 2
              ? GestureDetector(
                  child: Container(
                    height: 35,
                    width: 90,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff68A1F8), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        startTime!.format(context),
                        style: TextStyle(
                          color: checkTime1 == ""
                              ? Colors.grey.shade600
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: startTime!,
                    );
                    if (newTime != null) {
                      setState(() {
                        startTime = newTime;
                        checkTime1 = newTime.toString();
                      });
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Widget timeStartAndEnd(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leaveValue == 1 || leaveValue == 2
              ? Row(
                  children: [
                    const Text(
                      '  To  ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff68A1F8), width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${toDate?.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              color: checkDate2 == ""
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        checkDate1 == ''
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Select From Date First'),
                                ),
                              )
                            : _selectToDate(context);
                      },
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            width: 15,
          ),
          leaveValue == 2
              ? GestureDetector(
                  child: Container(
                    height: 35,
                    width: 90,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff68A1F8), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        endTime!.format(context),
                        style: TextStyle(
                          color: checkTime2 == ""
                              ? Colors.grey.shade600
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: endTime!,
                    );
                    if (newTime != null) {
                      setState(() {
                        endTime = newTime;
                        checkTime2 = newTime.toString();
                      });
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Widget submitButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Align(
        child: SizedBox(
          width: 235,
          height: 50,
          child: ElevatedButton(
            style: getButtonStyle(context),
            onPressed: () async {
              if (leaveValue == 1) {
                convertedDate1 = DateFormat("yyyy-MM-dd").format(fromDate!);
                convertedDate2 = DateFormat("yyyy-MM-dd").format(toDate!);
                if (checkDate1 != "" && checkDate2 != "") {
                  if (int.parse(checkDate2.substring(08, 10)) >=
                      int.parse(checkDate1.substring(08, 10))) {
                    await doctorLeaveNotifier.doctorLeave(
                      doctorId,
                      convertedDate1,
                      convertedDate2,
                    );
                    if (doctorLeaveNotifier.doctorLeaveMessage ==
                        'you are not allowed to add ') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You have taken leave on this date'),
                        ),
                      );
                    } else {
                      listOfPatient(context);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('To Date should be greater than From Date'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select date'),
                    ),
                  );
                }
              } else {
                convertedDate1 = DateFormat("yyyy-MM-dd").format(fromDate!);
                convertedDate2 = DateFormat("yyyy-MM-dd").format(toDate!);
                if (checkDate1 != "" && checkDate2 != "") {
                  if (checkTime1 != "" && checkTime2 != "") {
                    if (int.parse(checkDate2.substring(08, 10)) >=
                        int.parse(checkDate1.substring(08, 10))) {
                      if (int.parse(checkTime2.substring(10, 12)) >=
                          int.parse(checkTime1.substring(10, 12))) {
                        await doctorTimeLeaveNotifier.doctorTimeLeave(
                          doctorId,
                          convertedDate1,
                          convertedDate2,
                          startTime.toString().substring(10, 15),
                          endTime.toString().substring(10, 15),
                        );
                        if (doctorTimeLeaveNotifier.doctorTimeLeaveMessage !=
                            'you are not allowed to add ') {
                          listOfPatient(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('You have taken leave on this time'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'To Time should be greater than From Time'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('To Date should be greater than From Date'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select time'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select date'),
                    ),
                  );
                }
              }
            },
            child: Text(
              'Submit',
              style: TextButtonStyle(context),
            ),
          ),
        ),
      ),
    );
  }

  listOfPatient(context) {
    Future.delayed(Duration.zero, () {
      if (leaveValue == 1) {
        convertedDate1 = DateFormat("yyyy-MM-dd").format(fromDate!);
        convertedDate2 = DateFormat("yyyy-MM-dd").format(toDate!);
        doctorLeaveNotifier.doctorLeave(
          doctorId,
          convertedDate1,
          convertedDate2,
        );
      } else {
        convertedDate1 = DateFormat("yyyy-MM-dd").format(fromDate!);
        convertedDate2 = DateFormat("yyyy-MM-dd").format(toDate!);
        doctorTimeLeaveNotifier.doctorTimeLeave(
          doctorId,
          convertedDate1,
          convertedDate2,
          startTime.toString().substring(10, 15),
          endTime.toString().substring(10, 15),
        );
      }
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration.zero, () {
          if (leaveValue == 1) {
            convertedDate1 = DateFormat("yyyy-MM-dd").format(fromDate!);
            convertedDate2 = DateFormat("yyyy-MM-dd").format(toDate!);
            doctorLeaveNotifier.doctorLeave(
              doctorId,
              convertedDate1,
              convertedDate2,
            );
          } else {
            convertedDate1 = DateFormat("yyyy-MM-dd").format(fromDate!);
            convertedDate2 = DateFormat("yyyy-MM-dd").format(toDate!);
            doctorTimeLeaveNotifier.doctorTimeLeave(
              doctorId,
              convertedDate1,
              convertedDate2,
              startTime.toString().substring(10, 15),
              endTime.toString().substring(10, 15),
            );
          }
        });
        return leaveValue == 1
            ? Consumer<DoctorLeaveNotifier>(
                builder: (context, provider, _) {
                  this.doctorLeaveNotifier = provider;
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
                            submitAndCancelButton(context)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Consumer<DoctorTimeLeaveNotifier>(
                builder: (context, provider, _) {
                  doctorTimeLeaveNotifier = provider;
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
                            submitAndCancelButton(context)
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

  reasonBox(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<DoctorLeaveNotifier>(
          builder: (context, provider, _) {
            this.doctorLeaveNotifier = provider;
            return ModalProgressHUD(
              inAsyncCall: provider.isLoading,
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
                      submitReasonButton(context)
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

  void _showCancelLeaveDialog(String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Cancel Leave",
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            "Are you sure you want to Cancel the Leave?",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: const Text(
                "Close",
                style: TextStyle(
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
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                doctorLeaveDeleteNotifier.doctorLeaveDelete(int.parse(id));
              },
            ),
          ],
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
        child: leaveValue == 1
            ? doctorLeaveNotifier.doctorLeaveClass.isEmpty
                ? const Center(
                    child: Text('No Patient Booked'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: doctorLeaveNotifier.doctorLeaveClass.length,
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
                                      doctorLeaveNotifier
                                          .doctorLeaveClass[index].patientName
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
                                      doctorLeaveNotifier
                                          .doctorLeaveClass[index].mobileNumber
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
                  )
            : doctorTimeLeaveNotifier.doctorTimeLeaveClass.isEmpty
                ? const Center(child: Text('No Patient Booked'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: doctorLeaveNotifier.doctorLeaveClass.length,
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
                                      doctorTimeLeaveNotifier
                                          .doctorTimeLeaveClass[index]
                                          .patientName
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
                                      doctorTimeLeaveNotifier
                                          .doctorTimeLeaveClass[index]
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

  Widget submitReasonButton(context) {
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
            if (reasonController.text.isNotEmpty) {
              leaveValue == 1
                  ? doctorLeaveConfirmNotifier.doctorLeaveConfirm(
                      doctorId,
                      convertedDate1,
                      convertedDate2,
                      reasonController.text,
                    )
                  : doctorTimeLeaveConfirmNotifier.doctorTimeLeaveConfirm(
                      doctorId,
                      convertedDate1,
                      convertedDate2,
                      startTime.toString().substring(10, 15),
                      endTime.toString().substring(10, 15),
                      reasonController.text,
                    );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please Enter Reason'),
                ),
              );
            }

            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OutOfOffice()));
          },
        ),
      ],
    );
  }

  Widget submitAndCancelButton(context) {
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
            reasonBox(context);
          },
        ),
        // FittedBox(
        //   child: SizedBox(
        //     width: 120,
        //     height: 50,
        //     child: ElevatedButton(
        //       style: getButtonStyle(context),
        //       onPressed: () async {
        //         // addPatientInfoNotifier?.addPatientInfo(
        //         //   widget.patientId,
        //         //   int.parse(bloodpressureController.text),
        //         //   int.parse(diabetesController.text),
        //         //   double.parse(temperatureController.text),
        //         //   int.parse(heartBeatController.text),
        //         //   int.parse(weightController.text),
        //         //   double.parse(heightController.text),
        //         // );
        //         // Navigator.pushNamed(context, RoutePaths.PatientData);
        //       },
        //       child: Text(
        //         'Proceed',
        //         style: TextButtonStyle(context),
        //       ),
        //     ),
        //   ),
        // ),
        // // SizedBox(
        // //   height: 45,
        // //   width: 150,
        // //   child: OutlinedButton(
        // //     onPressed: () {
        // //       // addPatientInfoNotifier?.addPatientInfo(
        // //       //   widget.patientId,
        // //       //   int.parse(bloodpressureController.text),
        // //       //   int.parse(diabetesController.text),
        // //       //   double.parse(temperatureController.text),
        // //       //   int.parse(heartBeatController.text),
        // //       //   int.parse(weightController.text),
        // //       //   double.parse(heightController.text),
        // //       // );
        // //       // Navigator.pushNamed(context, RoutePaths.PatientData);
        // //     },
        // //     style: ButtonStyle(
        // //       side: MaterialStateProperty.all(
        // //         const BorderSide(
        // //           color: Color(0xff6EA7FA),
        // //           width: 2,
        // //         ),
        // //       ),
        // //       shape: MaterialStateProperty.all(
        // //         RoundedRectangleBorder(
        // //           borderRadius: BorderRadius.circular(30.0),
        // //         ),
        // //       ),
        // //     ),
        // //     child: const Text(
        // //       'Service Done',
        // //       style: TextStyle(
        // //         fontSize: 16,
        // //         fontWeight: FontWeight.w600,
        // //         color: Color(0xff6EA7FA),
        // //       ),
        // //     ),
        // //   ),
        // // ),
        // SizedBox(
        //   width: 20,
        // ),
        // FittedBox(
        //   child: SizedBox(
        //     width: 120,
        //     height: 50,
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         primary: Colors.redAccent,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(18)),
        //       ),
        //       onPressed: () async {
        //         Navigator.pop(context);
        //       },
        //       child: Text(
        //         'Cancel',
        //         style: TextButtonStyle(context),
        //       ),
        //     ),
        //   ),
        // ),
      ],
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
            doctorLeaveNotifier.doctorLeaveClass.length.toString(),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget outOfOfficeList(context) {
    return Consumer<DoctorLeaveDaysNotifier>(
      builder: (context, provider, _) {
        this.doctorLeaveDaysNotifier = provider;
        return Expanded(
          child: doctorLeaveDaysNotifier.msg == 'No leave days found'
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.time_to_leave,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'No Leave Taken Yet',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      doctorLeaveDaysNotifier.doctorLeaveDaysClass.length,
                  itemBuilder: (context, index) {
                    if (doctorLeaveDaysNotifier
                            .doctorLeaveDaysClass[index].fromTime !=
                        null) {
                      var inputFormat = DateFormat('HH:mm');
                      var inputFromTime = inputFormat.parse(
                          doctorLeaveDaysNotifier
                              .doctorLeaveDaysClass[index].fromTime);
                      var inputToTime = inputFormat.parse(
                          doctorLeaveDaysNotifier.doctorLeaveDaysClass[index]
                              .toTime); // <-- dd/MM 24H format

                      var outputFormat = DateFormat('hh:mm a');
                      outputFromTime = outputFormat.format(inputFromTime);
                      outputToTime = outputFormat.format(inputToTime);
                      print(outputFromTime);
                      // final DateFormat formatter = DateFormat('hh:mm a');
                      // final String formattedFromTime = formatter.format(
                      //     doctorLeaveDaysNotifier
                      //         .doctorLeaveDaysClass[index].fromTime);
                      // final String formattedToTime = formatter.format(
                      //     doctorLeaveDaysNotifier
                      //         .doctorLeaveDaysClass[index].toTime);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5, left: 25, right: 25, top: 5),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.article,
                                          size: 25,
                                          color: Colors.blueAccent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            doctorLeaveDaysNotifier
                                                .doctorLeaveDaysClass[index]
                                                .description
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 22,
                                          color: Colors.blueAccent,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Center(
                                              child: Text(
                                                doctorLeaveDaysNotifier
                                                    .doctorLeaveDaysClass[index]
                                                    .fromDate
                                                    .toString()
                                                    .split(' ')[0],
                                                // "${toDate?.toLocal()}"
                                                //     .split(' ')[0],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          '-',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Center(
                                              child: Text(
                                                doctorLeaveDaysNotifier
                                                    .doctorLeaveDaysClass[index]
                                                    .toDate
                                                    .toString()
                                                    .split(' ')[0],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    doctorLeaveDaysNotifier
                                                .doctorLeaveDaysClass[index]
                                                .fromTime ==
                                            null
                                        ? Container()
                                        : const SizedBox(
                                            height: 15,
                                          ),
                                    doctorLeaveDaysNotifier
                                                .doctorLeaveDaysClass[index]
                                                .fromTime ==
                                            null
                                        ? Container()
                                        : Row(
                                            children: [
                                              const Align(
                                                child: Icon(
                                                  Icons.access_time,
                                                  size: 22,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: Colors.blueAccent
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Text(
                                                      outputFromTime,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                '-',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: Colors.blueAccent
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: Center(
                                                    child: Text(
                                                      outputToTime,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showCancelLeaveDialog(doctorLeaveDaysNotifier
                                      .doctorLeaveDaysClass[index].id
                                      .toString());
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
                    );
                  },
                ),
        );
      },
    );
  }

  Widget outOfOfficeListLandscape(context) {
    return Consumer<DoctorLeaveDaysNotifier>(
      builder: (context, provider, _) {
        this.doctorLeaveDaysNotifier = provider;
        return doctorLeaveDaysNotifier.msg == 'No leave days found'
            ? Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.time_to_leave,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'No Leave Taken Yet',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: doctorLeaveDaysNotifier.doctorLeaveDaysClass.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 25, right: 25, top: 5),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.article,
                                        size: 25,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          doctorLeaveDaysNotifier
                                              .doctorLeaveDaysClass[index]
                                              .description
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 22,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Center(
                                            child: Text(
                                              doctorLeaveDaysNotifier
                                                  .doctorLeaveDaysClass[index]
                                                  .fromDate
                                                  .toString()
                                                  .split(' ')[0],
                                              // "${toDate?.toLocal()}"
                                              //     .split(' ')[0],
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        '-',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Center(
                                            child: Text(
                                              doctorLeaveDaysNotifier
                                                  .doctorLeaveDaysClass[index]
                                                  .toDate
                                                  .toString()
                                                  .split(' ')[0],
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  doctorLeaveDaysNotifier
                                              .doctorLeaveDaysClass[index]
                                              .fromTime ==
                                          null
                                      ? Container()
                                      : const SizedBox(
                                          height: 15,
                                        ),
                                  doctorLeaveDaysNotifier
                                              .doctorLeaveDaysClass[index]
                                              .fromTime ==
                                          null
                                      ? Container()
                                      : Row(
                                          children: [
                                            const Align(
                                              child: Icon(
                                                Icons.access_time,
                                                size: 22,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: Text(
                                                    startTime!.format(context),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              '-',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Center(
                                                  child: Text(
                                                    endTime!.format(context),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showCancelLeaveDialog(doctorLeaveDaysNotifier
                                    .doctorLeaveDaysClass[index].id
                                    .toString());
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
                  );
                },
              );
      },
    );
  }
}
