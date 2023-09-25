import 'package:doctor_clinic_token_app/View/Add%20Info%20Of%20Patient/addinfopatient.dart';
import 'package:doctor_clinic_token_app/View/Health%20Record/health_records.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayconsultation/todayconsultationNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayconsultation/todayconsultationResponse.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TodayAppointment extends StatefulWidget {
  const TodayAppointment({Key? key}) : super(key: key);

  @override
  _TodayAppointmentState createState() => _TodayAppointmentState();
}

class _TodayAppointmentState extends State<TodayAppointment> {
  TodayConsultationNotifier provider = TodayConsultationNotifier();

  int doctorId = 0;
  var times;
  List<TodayConsultationData> sortedSession = [];

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
      provider.todayConsultation(doctorId).then((value) {
        provider.notifyListeners();
        for (int i = 0; i < provider.todayConsultationClass.length; i++) {
          if (provider.todayConsultationClass[i].session == 'Morning') {
            sortedSession.add(provider.todayConsultationClass[i]);
          }
        }
        for (int i = 0; i < provider.todayConsultationClass.length; i++) {
          if (provider.todayConsultationClass[i].session == 'Afternoon') {
            sortedSession.add(provider.todayConsultationClass[i]);
          }
        }
        for (int i = 0; i < provider.todayConsultationClass.length; i++) {
          if (provider.todayConsultationClass[i].session == 'Evening') {
            sortedSession.add(provider.todayConsultationClass[i]);
          }
        }
        for (int i = 0; i < provider.todayConsultationClass.length; i++) {
          if (provider.todayConsultationClass[i].session == 'Night') {
            sortedSession.add(provider.todayConsultationClass[i]);
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
                          provider.todayConsultation(doctorId).then((value) {
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
    return Consumer<TodayConsultationNotifier>(
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
    return listViewAppointment(context);
  }

  Widget listViewAppointment(context) {
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
                  'No Patient Registered Yet',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        : ListView.builder(
            clipBehavior: Clip.none,
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
                            AddInfoPatient(
                          patientId: sortedSession[index].id,
                          patientGender: sortedSession[index].gender == 'M'
                              ? 'Male'
                              : sortedSession[index].gender == 'F'
                                  ? 'Female'
                                  : '',
                          patientAge: sortedSession[index].dateofbirth ?? "",
                          healthIssue: sortedSession[index].description ?? "",
                          patientName: sortedSession[index].patientName ?? "",
                          bookedDate: outputDate,
                          phoneNumber: sortedSession[index].mobileNumber ?? "",
                          timeOrToken: sortedSession[index].tokenNo ?? times,
                          type: sortedSession[index].type ?? "",
                        ),
                      ),
                    );
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
                                            //     .todayConsultationClass[index].patientName
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
                                            color: Color(0xff1EC760),
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
                                sortedSession[index].appointmentTime == null
                                    ? "Token: "
                                    : "Time: ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(sortedSession[index].appointmentTime == null
                                  ? sortedSession[index].tokenNo.toString()
                                  : sortedSession[index]
                                      .appointmentTime
                                      .toString()),
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
                              Icon(
                                sortedSession[index].walkinId == null &&
                                        (sortedSession[index].type == 1 ||
                                            sortedSession[index].type == 2)
                                    ? Icons.book_online
                                    : sortedSession[index].walkinId != null
                                        ? Icons.directions_walk
                                        : Icons.medical_services,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                sortedSession[index].walkinId == null &&
                                        (sortedSession[index].type == 1 ||
                                            sortedSession[index].type == 2)
                                    ? 'Booked'
                                    : sortedSession[index].walkinId != null
                                        ? 'Walked-In'
                                        : 'Emergency',
                                style: TextStyle(
                                  color: sortedSession[index].walkinId ==
                                              null &&
                                          (sortedSession[index].type == 1 ||
                                              sortedSession[index].type == 2)
                                      ? Colors.green
                                      : sortedSession[index].walkinId != null
                                          ? Colors.green
                                          : Colors.redAccent,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          Health_Record(
                                        id: sortedSession[index]
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
