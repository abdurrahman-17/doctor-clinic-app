import 'package:doctor_clinic_token_app/View/Prescription/prescription.dart';
import 'package:doctor_clinic_token_app/core/request_response/recordHistory/recordhistoryNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/recordHistoryFilter/recordHistoryFilterNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Health_Record extends StatefulWidget {
  final id;

  const Health_Record({this.id, Key? key}) : super(key: key);

  @override
  _Health_RecordState createState() => _Health_RecordState();
}

class _Health_RecordState extends State<Health_Record> {
  RecordHistoryNotifier provider = RecordHistoryNotifier();
  RecordHistoryFilterNotifier provider1 = RecordHistoryFilterNotifier();
  DateTime? todayDate = DateTime.now();
  bool filteredHistory = false;
  String outputDate = '';

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      provider.recordHistory(widget.id).then((value) {
        provider.notifyListeners();
      });
    });
    super.initState();
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
                          provider.recordHistory(widget.id).then((value) {
                            provider.notifyListeners();
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todayDate!,
      // Refer step 1
      firstDate: DateTime(2000),
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
    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
        //dateFormate Change
        var inputFormat = DateFormat('yyyy-MM-dd');
        var inputDate = inputFormat.parse(todayDate.toString());
        var outputFormat = DateFormat('yyyy-MM-dd');
        outputDate = outputFormat.format(inputDate).toLowerCase();
        print(outputDate);
        filteredHistory = true;
        Future.delayed(Duration.zero, () {
          provider1.recordHistoryFilter(widget.id, outputDate).then((value) {
            provider.notifyListeners();
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<RecordHistoryNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xffF5F6FC),
              body: filteredHistory == false
                  ? buildbody(context)
                  : filterBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget filterBody(context) {
    return Consumer<RecordHistoryFilterNotifier>(
      builder: (context, provider, _) {
        provider1 = provider;
        return ModalProgressHUD(
          inAsyncCall: provider1.isloading,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                buildBackground(context),
                buildFilterRecord(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildbody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          buildBackground(context),
          buildRecord(context),
        ],
      ),
    );
  }

  Widget buildBackground(BuildContext context) {
    return Image(
      image: const AssetImage('assets/Home screen.png'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget buildFilterRecord(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        backButton(context),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: Row(
              children: const [
                Spacer(),
                Icon(
                  Icons.filter_list_outlined,
                  color: Colors.blueAccent,
                ),
                Text(
                  'FILTER',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
          child: provider1.recordHistoryFilterClass.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.group,
                          size: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'No Record in this date',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider1.recordHistoryFilterClass.length,
                  itemBuilder: (context, index) {
                    final DateFormat formatter = DateFormat("dd-MM-yyy");
                    //date number value
                    final formatted = formatter.format(
                        provider1.recordHistoryFilterClass[index].bookedDate!);
                    final dateValue = formatted.substring(0, 2);
                    //month name value
                    final monthValue = formatted.substring(3, 5);
                    var inputFormat = DateFormat('MM');
                    var inputDate = inputFormat
                        .parse(monthValue.toString()); // <-- dd/MM 24H format
                    var outputMonthFormat = DateFormat('MMMM');
                    final outputMonthName = outputMonthFormat.format(inputDate);
                    //week name value
                    final DateFormat formatters = DateFormat("E-MM-yyy");
                    final formatteds = formatters.format(
                        provider1.recordHistoryFilterClass[index].bookedDate!);
                    final dateWeekname = formatteds.split('-').first;
                    return TimelineTile(
                      indicatorStyle: const IndicatorStyle(
                        height: 15,
                        width: 15,
                        color: Color(0xff91b8fe),
                      ),
                      afterLineStyle:
                          LineStyle(color: Colors.grey.shade300, thickness: 3),
                      beforeLineStyle:
                          LineStyle(color: Colors.grey.shade300, thickness: 3),
                      alignment: TimelineAlign.manual,
                      isFirst: index == 0,
                      lineXY: 0.2,
                      isLast: index ==
                          provider1.recordHistoryFilterClass.length - 1,
                      endChild: Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            print('Irfan');
                            print(provider
                                .recordHistoryClass[index].appointmentId);
                            print('Irfan1');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Prescription(
                                  appointmentData: provider
                                      .recordHistoryClass[index].appointmentId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                const BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    spreadRadius: 0.5)
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: const Color(0xff4889FD)
                                          .withOpacity(0.6),
                                      width: 8,
                                    ),
                                  ),
                                  boxShadow: [
                                    const BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 4),
                                        blurRadius: 8)
                                  ],
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Color(0xff566CCE),
                                            size: 22,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Dr. ' +
                                                  provider1
                                                      .recordHistoryFilterClass[
                                                          index]
                                                      .doctorName
                                                      .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.note_add_rounded,
                                            color: Color(0xff566CCE),
                                            //color: Color(0xff4889FD),
                                            size: 22,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              provider1
                                                  .recordHistoryFilterClass[
                                                      index]
                                                  .description
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      startChild: Container(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                outputMonthName,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(dateValue,
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: Color(0xff566CCE),
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(dateWeekname,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            ],
                          )),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget buildRecord(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        backButton(context),
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: const [
                Spacer(),
                Icon(
                  Icons.filter_list_outlined,
                  color: Colors.blueAccent,
                ),
                Text(
                  'FILTER',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
          child: provider.recordHistoryClass.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.group,
                          size: 100,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'No Health Record Yet',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.recordHistoryClass.length,
                  itemBuilder: (context, index) {
                    final DateFormat formatter = DateFormat("dd-MM-yyy");
                    //date number value
                    final formatted = formatter
                        .format(provider.recordHistoryClass[index].bookedDate!);
                    final dateValue = formatted.substring(0, 2);
                    //month name value
                    final monthValue = formatted.substring(3, 5);
                    var inputFormat = DateFormat('MM');
                    var inputDate = inputFormat
                        .parse(monthValue.toString()); // <-- dd/MM 24H format
                    var outputMonthFormat = DateFormat('MMMM');
                    final outputMonthName = outputMonthFormat.format(inputDate);
                    //week name value
                    final DateFormat formatters = DateFormat("E-MM-yyy");
                    final formatteds = formatters
                        .format(provider.recordHistoryClass[index].bookedDate!);
                    final dateWeekname = formatteds.split('-').first;
                    return TimelineTile(
                      indicatorStyle: const IndicatorStyle(
                        height: 15,
                        width: 15,
                        color: Color(0xff91b8fe),
                      ),
                      afterLineStyle:
                          LineStyle(color: Colors.grey.shade300, thickness: 3),
                      beforeLineStyle:
                          LineStyle(color: Colors.grey.shade300, thickness: 3),
                      alignment: TimelineAlign.manual,
                      isFirst: index == 0,
                      lineXY: 0.2,
                      isLast: index == provider.recordHistoryClass.length - 1,
                      endChild: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            print('Irfan');
                            print(provider
                                .recordHistoryClass[index].appointmentId);
                            print('Irfan1');
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Prescription(
                                  appointmentData: provider
                                      .recordHistoryClass[index].appointmentId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                const BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    spreadRadius: 0.5)
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: const Color(0xff4889FD)
                                          .withOpacity(0.6),
                                      width: 8,
                                    ),
                                  ),
                                  boxShadow: [
                                    const BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 4),
                                        blurRadius: 8)
                                  ],
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Color(0xff566CCE),
                                            size: 22,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Dr. ' +
                                                  provider
                                                      .recordHistoryClass[index]
                                                      .doctorName
                                                      .toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.note_add_rounded,
                                            color: Color(0xff566CCE),
                                            //color: Color(0xff4889FD),
                                            size: 22,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              provider.recordHistoryClass[index]
                                                  .description
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      startChild: Container(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                outputMonthName,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(dateValue,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Color(0xff566CCE),
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(dateWeekname,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            ],
                          )),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
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
            'Health Record',
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
            'Health Record',
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
}
