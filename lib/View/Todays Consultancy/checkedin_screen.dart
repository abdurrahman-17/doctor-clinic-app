import 'package:doctor_clinic_token_app/View/Add%20Info%20Of%20Patient/addinfopatient.dart';
import 'package:doctor_clinic_token_app/View/Health%20Record/health_records.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayCheckIn/todaycheckinNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayconsultation/todayconsultationNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CheckedInScreen extends StatefulWidget {
  const CheckedInScreen({Key? key}) : super(key: key);

  @override
  _CheckedInScreenState createState() => _CheckedInScreenState();
}

class _CheckedInScreenState extends State<CheckedInScreen> {
  TodayCheckedInNotifier provider = TodayCheckedInNotifier();
  TodayConsultationNotifier provider1 = TodayConsultationNotifier();

  String patientName = "";

  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    Future.delayed(Duration.zero, () {
      provider.todayCheckIn(33).then((value) {
        provider.notifyListeners();
      });
    });

    Future.delayed(Duration.zero, () {
      provider1.todayConsultation(33).then((value) {
        provider1.notifyListeners();
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
                          provider.todayCheckIn(33).then((value) {
                            provider.notifyListeners();
                          });
                        });

                        Future.delayed(Duration.zero, () {
                          provider1.todayConsultation(33).then((value) {
                            provider1.notifyListeners();
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
          child: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          listViewCheckedIn(context),
          notCheckedInContainer(context),
          Consumer<TodayConsultationNotifier>(
            builder: (context, providers, _) {
              this.provider1 = providers;
              return listViewNotCheckedIn(context);
            },
          ),
        ],
      ),
    );
  }

  Widget notCheckedInContainer(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff67A0F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Not Checked-In',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listViewCheckedIn(context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: provider.todayCheckinClass.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffCAE7FC),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xff67A0F8),
                          child: Center(
                            child: Text(
                              provider.todayCheckinClass[index].patientName!
                                  .substring(0, 1)
                                  .toUpperCase()
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 33, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.todayCheckinClass[index].patientName
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Ophthalmologist',
                            style: TextStyle(
                              color: Color(0xff8F9BB3),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 15,
                        color: Color(0xff6574CF),
                      ),
                      Text(
                        'Timing: ' +
                            provider.todayCheckinClass[index].appointmentTime
                                .toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xff6574CF),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.schedule),
                      const Text('1 hour'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: Color(0xffC4C4C4DE),
                      thickness: 2,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Today'),
                          Text('12 May, 12:50 AM'),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Material(
                          color: const Color(0xffC2E2FF),
                          borderRadius: BorderRadius.circular(5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.call,
                              size: 15,
                            ),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Material(
                          color: const Color(0xffC9E7E5),
                          borderRadius: BorderRadius.circular(5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.message,
                              size: 15,
                            ),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 32,
                        width: 100,
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => AddInfoPatient(
                            //               patientId: provider1
                            //                   .todayConsultationClass[index].id,
                            //               patientName: provider1
                            //                   .todayConsultationClass[index]
                            //                   .patientName,
                            //               patientAge: provider1
                            //                   .todayConsultationClass[index]
                            //                   .age,
                            //               patientGender: provider1
                            //                   .todayConsultationClass[index]
                            //                   .gender,
                            //             )));
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Color(0xff1EC760),
                                width: 2,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Edit Info',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1EC760),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 32,
                        width: 100,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Health_Record()));
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Color(0xffFFB830),
                                width: 2,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listViewNotCheckedIn(context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: provider1.todayConsultationClass.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddInfoPatient(
              //       patientId: provider1.todayConsultationClass[index].id,
              //       patientName:
              //           provider1.todayConsultationClass[index].patientName,
              //       patientAge: provider1.todayConsultationClass[index].age,
              //       patientGender:
              //           provider1.todayConsultationClass[index].gender,
              //     ),
              //   ),
              // );
            },
            child: Container(
              height: 150,
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 60,
                            width: 60,
                            color: const Color(0xff5E698F),
                            child: Center(
                              child: Text(
                                provider1
                                    .todayConsultationClass[index].patientName!
                                    .substring(0, 1)
                                    .toUpperCase()
                                    .toString(),
                                style: const TextStyle(fontSize: 33),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider1
                                  .todayConsultationClass[index].patientName
                                  .toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Done',
                              style: TextStyle(
                                color: Color(0xff1EC760),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.more_vert,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.schedule),
                                Text('1 hour'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Divider(
                        color: Color(0xffC4C4C4DE),
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Health_Record()));
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
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Histoy',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFFB830),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Material(
                            color: const Color(0xffC2E2FF),
                            borderRadius: BorderRadius.circular(5),
                            child: IconButton(
                              icon: const Icon(
                                Icons.call,
                                size: 15,
                              ),
                              color: Colors.black,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Material(
                            color: const Color(0xffC9E7E5),
                            borderRadius: BorderRadius.circular(5),
                            child: IconButton(
                              icon: const Icon(
                                Icons.message,
                                size: 15,
                              ),
                              color: Colors.black,
                              onPressed: () {},
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
