import 'package:doctor_clinic_token_app/View/CheckedInfoData/CheckedInInfo.dart';
import 'package:doctor_clinic_token_app/View/Health%20Record/health_records.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayCheckIn/todaycheckinNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayCheckIn/todaycheckinResponse.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CheckedIn extends StatefulWidget {
  const CheckedIn({Key? key}) : super(key: key);

  @override
  _CheckedInState createState() => _CheckedInState();
}

class _CheckedInState extends State<CheckedIn> {
  TodayCheckedInNotifier provider = TodayCheckedInNotifier();
  List<CheckedInData> sortedSession = [];

  int doctorId = 0;
  var times;

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
    Future.delayed(Duration.zero, () {
      provider.todayCheckIn(doctorId).then((value) {
        provider.notifyListeners();
        for (int i = 0; i < provider.todayCheckinClass.length; i++) {
          if (provider.todayCheckinClass[i].session == 'Morning') {
            sortedSession.add(provider.todayCheckinClass[i]);
          }
        }
        for (int i = 0; i < provider.todayCheckinClass.length; i++) {
          if (provider.todayCheckinClass[i].session == 'Afternoon') {
            sortedSession.add(provider.todayCheckinClass[i]);
          }
        }
        for (int i = 0; i < provider.todayCheckinClass.length; i++) {
          if (provider.todayCheckinClass[i].session == 'Evening') {
            sortedSession.add(provider.todayCheckinClass[i]);
          }
        }
        for (int i = 0; i < provider.todayCheckinClass.length; i++) {
          if (provider.todayCheckinClass[i].session == 'Night') {
            sortedSession.add(provider.todayCheckinClass[i]);
          }
        }
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
                          provider.todayCheckIn(doctorId).then((value) {
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
    if (!kReleaseMode) {}
    return Consumer<TodayCheckedInNotifier>(
      builder: (context, provider, _) {
        this.provider = provider;
        return ModalProgressHUD(
            inAsyncCall: provider.isLoading,
            color: Colors.transparent,
            child: buildBody(context));
      },
    );
  }

  Widget buildBody(context) {
    return listViewCheckedIn(context);
  }

  Widget listViewCheckedIn(context) {
    return sortedSession.isEmpty
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
                  'No Patient Checked In',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: sortedSession.length,
            itemBuilder: (BuildContext context, int index) {
              final DateFormat formatter = DateFormat("dd-MMMM-yyy");
              String formattedDate =
                  formatter.format(sortedSession[index].date!);
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    //dateFormate Change
                    var inputFormat = DateFormat('yyyy-MM-dd');
                    var inputDate =
                        inputFormat.parse(sortedSession[index].date.toString());
                    var outputFormat = DateFormat('dd-MM-yyyy');
                    final outputDate =
                        outputFormat.format(inputDate).toLowerCase();

                    //timeFormat Change
                    final time = sortedSession[index].appointmentTime;
                    if (time != null) {
                      var df = DateFormat("hh:mm");
                      var dt = df.parse(time);
                      times = DateFormat('h:mm a').format(dt);
                    }
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CheckedInInfo(
                          healthIssue: sortedSession[index].description,
                          timeOrToken:
                              sortedSession[index].appointmentTime != null
                                  ? times
                                  : sortedSession[index].tokenNo != null
                                      ? sortedSession[index].tokenNo.toString()
                                      : "emergency",
                          phoneNumber: sortedSession[index].mobileNumber ?? '',
                          bookedDate: outputDate,
                          patientName: sortedSession[index].patientName,
                          patientAge: sortedSession[index].dateofbirth,
                          patientGender: sortedSession[index].gender == 'M'
                              ? 'Male'
                              : sortedSession[index].gender == 'F'
                                  ? 'Female'
                                  : '',
                          bloodPressure:
                              sortedSession[index].bloodPressure ?? "",
                          diabetes: sortedSession[index].diabetes ?? "",
                          height: sortedSession[index].height ?? "",
                          weight: sortedSession[index].weight ?? "",
                          patientId: sortedSession[index].id,
                          pulseRate: sortedSession[index].pulseRate ?? "",
                          spo2: sortedSession[index].spo2 ?? "",
                          temperature: sortedSession[index].temperature ?? "",
                          type: sortedSession[index].type ?? "",
                        ),
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AddInfoPatient(
                    //       patientId: provider1.todayCheckinClass[index].id,
                    //       patientName:
                    //       provider1.todayCheckinClass[index].patientName,
                    //       patientAge: provider1.todayCheckinClass[index].age,
                    //       patientGender:
                    //       provider1.todayCheckinClass[index].gender,
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
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: const Color(0xff68A0F8),
                                  child: Center(
                                    child: Text(
                                      sortedSession[index]
                                          .patientName!
                                          .substring(0, 1)
                                          .toUpperCase()
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 18,
                                          color: Colors.blueAccent,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            sortedSession[index]
                                                .patientName
                                                .toString(),
                                            // provider1
                                            //     .todayCheckinClass[index].patientName
                                            //     .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
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
                                          Icons.phone,
                                          size: 18,
                                          color: Colors.blueAccent,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          sortedSession[index].mobileNumber ==
                                                  null
                                              ? "-----"
                                              : sortedSession[index]
                                                  .mobileNumber
                                                  .toString(),
                                          style: const TextStyle(
                                            color: const Color(0xff1EC760),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                sortedSession[index].appointmentTime != null
                                    ? "Time: "
                                    : sortedSession[index].tokenNo != null
                                        ? "Token: "
                                        : "Walked-In: ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(sortedSession[index].appointmentTime != null
                                  ? sortedSession[index]
                                      .appointmentTime
                                      .toString()
                                  : sortedSession[index].tokenNo != null
                                      ? sortedSession[index].tokenNo.toString()
                                      : "emergency"),
                              const Spacer(),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: Divider(
                              color: Color(0xffC4C4C4DE),
                              thickness: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          sortedSession[index].walkinId ==
                                                      null &&
                                                  (sortedSession[index].type ==
                                                          1 ||
                                                      sortedSession[index]
                                                              .type ==
                                                          2)
                                              ? Icons.book_online
                                              : sortedSession[index]
                                                          .walkinId
                                                          .toString()
                                                          .substring(0, 1) ==
                                                      'W'
                                                  ? Icons.directions_walk
                                                  : sortedSession[index]
                                                              .walkinId
                                                              .toString()
                                                              .substring(
                                                                  0, 1) ==
                                                          'E'
                                                      ? Icons.medical_services
                                                      : Icons.person,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          sortedSession[index].walkinId ==
                                                      null &&
                                                  (sortedSession[index].type ==
                                                          1 ||
                                                      sortedSession[index]
                                                              .type ==
                                                          2)
                                              ? 'Booked'
                                              : sortedSession[index]
                                                          .walkinId
                                                          .toString()
                                                          .substring(0, 1) ==
                                                      'W'
                                                  ? 'Walked-In'
                                                  : sortedSession[index]
                                                              .walkinId
                                                              .toString()
                                                              .substring(
                                                                  0, 1) ==
                                                          'E'
                                                      ? 'Emergency'
                                                      : 'Other',
                                          style: TextStyle(
                                            color: sortedSession[index]
                                                            .walkinId ==
                                                        null &&
                                                    (sortedSession[index]
                                                                .type ==
                                                            1 ||
                                                        sortedSession[index]
                                                                .type ==
                                                            2)
                                                ? Colors.green
                                                : sortedSession[index]
                                                            .walkinId
                                                            .toString()
                                                            .substring(0, 1) ==
                                                        'W'
                                                    ? Colors.green
                                                    : sortedSession[index]
                                                                .walkinId
                                                                .toString()
                                                                .substring(
                                                                    0, 1) ==
                                                            'E'
                                                        ? Colors.redAccent
                                                        : Colors.green,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    sortedSession[index].createdBy.toString() ==
                                            'null'
                                        ? Container()
                                        : const SizedBox(
                                            height: 5,
                                          ),
                                    sortedSession[index].createdBy.toString() ==
                                            'null'
                                        ? Container()
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.userPen,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  sortedSession[index]
                                                              .createdBy
                                                              .toString() ==
                                                          'null'
                                                      ? ""
                                                      : sortedSession[index]
                                                          .createdBy
                                                          .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          Health_Record(
                                        id: sortedSession[index].patientId ==
                                                null
                                            ? sortedSession[index].walkinId
                                            : sortedSession[index]
                                                .patientId
                                                .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 32,
                                  width: 100,
                                  child: OutlinedButton(
                                    onPressed: null,
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                        const BorderSide(
                                          color: Color(0xffFFB830),
                                          width: 2,
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'History',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffFFB830),
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
                  ),
                ),
              );
            },
          );
  }
}
