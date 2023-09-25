import 'package:doctor_clinic_token_app/View/Health%20Record/health_records.dart';
import 'package:doctor_clinic_token_app/View/PatientList/PatientList.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkInPatientFilter/walkInPatientFilterNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkedInPatientList/walkedInListNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class WalkedInPatient extends StatefulWidget {
  const WalkedInPatient({Key? key}) : super(key: key);

  @override
  _WalkedInPatientState createState() => _WalkedInPatientState();
}

class _WalkedInPatientState extends State<WalkedInPatient> {
  WalkedInPatientListNotifier provider = WalkedInPatientListNotifier();
  WalkedInPatientFilterNotifier walkedInPatientFilterNotifier =
      WalkedInPatientFilterNotifier();

  int doctorId = 0;
  bool filterWalkIn = false;
  DateTime? todayDate = DateTime.now();

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

        var inputFormat = DateFormat('yyyy-MM-dd');
        var inputDate = inputFormat.parse(todayDate.toString());
        var outputFormat = DateFormat('yyyy-MM-dd');
        final outputDate = outputFormat.format(inputDate).toLowerCase();
        print(outputDate);
        filterWalkIn = true;
        filterWalkedIn(outputDate);
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
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      provider.walkedInList(doctorId).then((value) {
        provider.notifyListeners();
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
                        // Future.delayed(Duration.zero,(){
                        //   provider.About_US_data();
                        //   provider.notifyListeners();
                        //   print(provider.about_us_ResponseClass);
                        //   //print(provider.privacyPolicy_ResponseClass.updateDate.toString());
                        // });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Patientlist()));
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

  filterWalkedIn(filteredDate) {
    Future.delayed(Duration.zero, () {
      walkedInPatientFilterNotifier
          .walkedInFilter(doctorId, filteredDate)
          .then((value) {
        walkedInPatientFilterNotifier.notifyListeners();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<WalkedInPatientListNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: buildBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          filterList(context),
          const SizedBox(
            height: 20,
          ),
          filterWalkIn == false
              ? listViewRegisteredPatient(context)
              : listViewFilteredPatient(context),
        ],
      ),
    );
  }

  Widget filterList(context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.filter_list_outlined,
              color: Color(0xff68A1F8),
            ),
            Text(
              'FILTER',
              style: TextStyle(
                  color: Color(0xff68A1F8),
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewRegisteredPatient(context) {
    return provider.walkedInListClass.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                'No WalkedIn Patient Yet',
                style: TextStyle(fontSize: 20),
              ),
            ],
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: provider.walkedInListClass.length,
            itemBuilder: (BuildContext context, int index) {
              // final DateFormat formatter=DateFormat("dd-MMMM-yyy");
              // String formattedDate=formatter.format(provider.todayConsultationClass[index].date!);
              //dateFormate Change
              var inputFormat = DateFormat('yyyy-MM-dd');
              var inputDate = inputFormat
                  .parse(provider.walkedInListClass[index].date.toString());
              var outputFormat = DateFormat('dd-MM-yyyy');
              final outputDate = outputFormat.format(inputDate).toLowerCase();

              //timeFormat Change
              // final time=provider.walkedInListClass[index].appointmentTime;
              // var df =  DateFormat("hh:mm");
              // var dt = df.parse(time);
              // var times=DateFormat('h:mm a').format(dt);
              return provider.walkedInListClass.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            'No Registered Patient',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Health_Record(
                                id: provider.walkedInListClass[index]
                                            .patientId ==
                                        null
                                    ? provider.walkedInListClass[index].walkinId
                                    : provider
                                        .walkedInListClass[index].patientId,
                              ),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AddInfoPatient(
                          //       patientId: provider1.todayConsultationClass[index].id,
                          //       patientName:
                          //       provider1.todayConsultationClass[index].patientName,
                          //       patientAge: provider1.todayConsultationClass[index].age,
                          //       patientGender:
                          //       provider1.todayConsultationClass[index].gender,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffCAE7FC),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    color: const Color(0xff68A0F8),
                                    child: Center(
                                      child: Text(
                                        provider.walkedInListClass[index]
                                            .patientName!
                                            .substring(0, 1)
                                            .toUpperCase()
                                            .toString(),
                                        // provider1.todayConsultationClass[index].patientName!
                                        //     .substring(0, 1).toUpperCase()
                                        //     .toString(),
                                        style: const TextStyle(
                                          fontSize: 33,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.walkedInListClass[index]
                                            .patientName
                                            .toString(),
                                        // provider.todayConsultationClass[index].patientName.toString(),
                                        // provider1
                                        //     .todayConsultationClass[index].patientName
                                        //     .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            provider.walkedInListClass[index]
                                                        .mobileNumber ==
                                                    null
                                                ? "-----"
                                                : provider
                                                    .walkedInListClass[index]
                                                    .mobileNumber
                                                    .toString(),
                                            // provider.todayConsultationClass[index].mobileNumber == null ? "-----" : provider.todayConsultationClass[index].mobileNumber.toString(),
                                            style: const TextStyle(
                                              color: Color(0xff1EC760),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            outputDate,
                                            // formattedDate,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          );
  }

  Widget listViewFilteredPatient(context) {
    return Consumer<WalkedInPatientFilterNotifier>(
      builder: (context, provider2, _) {
        walkedInPatientFilterNotifier = provider2;
        return ModalProgressHUD(
          inAsyncCall: walkedInPatientFilterNotifier.isLoading,
          color: Colors.transparent,
          child: walkedInPatientFilterNotifier.walkedInFilterClass.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      'No Patient On This Date',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount:
                      walkedInPatientFilterNotifier.walkedInFilterClass.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final DateFormat formatter=DateFormat("dd-MMMM-yyy");
                    // String formattedDate=formatter.format(provider.todayConsultationClass[index].date!);
                    //dateFormate Change
                    var inputFormat = DateFormat('yyyy-MM-dd');
                    var inputDate = inputFormat.parse(
                        walkedInPatientFilterNotifier
                            .walkedInFilterClass[index].date
                            .toString());
                    var outputFormat = DateFormat('dd-MM-yyyy');
                    final outputDate =
                        outputFormat.format(inputDate).toLowerCase();

                    //timeFormat Change
                    // final time=provider.walkedInListClass[index].appointmentTime;
                    // var df =  DateFormat("hh:mm");
                    // var dt = df.parse(time);
                    // var times=DateFormat('h:mm a').format(dt);
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Health_Record(
                                id: walkedInPatientFilterNotifier
                                            .walkedInFilterClass[index]
                                            .patientId ==
                                        null
                                    ? walkedInPatientFilterNotifier
                                        .walkedInFilterClass[index].walkinId
                                    : walkedInPatientFilterNotifier
                                        .walkedInFilterClass[index].patientId,
                              ),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AddInfoPatient(
                          //       patientId: provider1.todayConsultationClass[index].id,
                          //       patientName:
                          //       provider1.todayConsultationClass[index].patientName,
                          //       patientAge: provider1.todayConsultationClass[index].age,
                          //       patientGender:
                          //       provider1.todayConsultationClass[index].gender,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffCAE7FC),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    color: const Color(0xff68A0F8),
                                    child: Center(
                                      child: Text(
                                        walkedInPatientFilterNotifier
                                            .walkedInFilterClass[index]
                                            .patientName!
                                            .substring(0, 1)
                                            .toUpperCase()
                                            .toString(),
                                        // provider1.todayConsultationClass[index].patientName!
                                        //     .substring(0, 1).toUpperCase()
                                        //     .toString(),
                                        style: const TextStyle(
                                          fontSize: 33,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        walkedInPatientFilterNotifier
                                            .walkedInFilterClass[index]
                                            .patientName
                                            .toString(),
                                        // provider.todayConsultationClass[index].patientName.toString(),
                                        // provider1
                                        //     .todayConsultationClass[index].patientName
                                        //     .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            walkedInPatientFilterNotifier
                                                        .walkedInFilterClass[
                                                            index]
                                                        .mobileNumber ==
                                                    null
                                                ? "-----"
                                                : walkedInPatientFilterNotifier
                                                    .walkedInFilterClass[index]
                                                    .mobileNumber
                                                    .toString(),
                                            // provider.todayConsultationClass[index].mobileNumber == null ? "-----" : provider.todayConsultationClass[index].mobileNumber.toString(),
                                            style: const TextStyle(
                                              color: Color(0xff1EC760),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            outputDate,
                                            // formattedDate,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
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
      },
    );
  }
}
