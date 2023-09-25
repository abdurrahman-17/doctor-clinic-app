import 'dart:async';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:doctor_clinic_token_app/View/AddWalkInPatientInfo/AddWalkinInfoPatient.dart';
import 'package:doctor_clinic_token_app/View/Drawer/drawer.dart';
import 'package:doctor_clinic_token_app/View/Notification/notification.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/appointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/checkedin.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/doneappointment.dart';
import 'package:doctor_clinic_token_app/core/request_response/graphWeek/graphWeekNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/monthlyGraph/monthlyGraphNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/notification_Count/notification_Notifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/pieChart/pieChartNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayConsulationCount/todayconsultationcountNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class DashboardScreens extends StatefulWidget {
  const DashboardScreens({Key? key}) : super(key: key);

  @override
  State<DashboardScreens> createState() => _DashboardScreensState();
}

class _DashboardScreensState extends State<DashboardScreens> {
  TodayConsultationCountNotifiers provider = TodayConsultationCountNotifiers();
  GraphWeekNotifier provider1 = GraphWeekNotifier();
  GraphMonthNotifier provider2 = GraphMonthNotifier();
  PieChartNotifier provider3 = PieChartNotifier();
  NotificationCountNotifier notification_count_notifier = NotificationCountNotifier();

  String drname = '';
  String drEducation = '';
  String todayCount = "";
  String todayCheckIn = "";
  String todayDone = "";
  int role = 0;
  bool showChartData = false;
  bool online = false;
  num monData = 0;
  num tueData = 0;
  num wedData = 0;
  num thuData = 0;
  num friData = 0;
  num satData = 0;
  num sunData = 0;
  int largestWeekNumber = 0;
  int largestMonthNumber = 0;

  num janData = 0;
  num febData = 0;
  num marData = 0;
  num aprData = 0;
  num mayData = 0;
  num junData = 0;
  num julData = 0;
  num augData = 0;
  num sepData = 0;
  num octData = 0;
  num novData = 0;
  num decData = 0;
  int doctorId = 0;

  num bookedData = 0;
  num walkedInData = 0;
  num emergencyData = 0;

  int touchedIndex = -1;

  Widget getBottomMonthTiles(value, meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Jan';
        break;
      case 2:
        text = 'Feb';
        break;
      case 3:
        text = 'Mar';
        break;
      case 4:
        text = 'Apr';
        break;
      case 5:
        text = 'May';
        break;
      case 6:
        text = 'Jun';
        break;
      case 7:
        text = 'Jul';
        break;
      case 8:
        text = 'Aug';
        break;
      case 9:
        text = 'Sep';
        break;
      case 10:
        text = 'Oct';
        break;
      case 11:
        text = 'Nov';
        break;
      case 12:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return Center(child: Text(text, style: style));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'Tue';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      case 7:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return Center(child: Text(text, style: style));
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${value.toInt()}0k';
    }
    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  List<BarChartGroupData> barChartGroupMonthData = [
    BarChartGroupData(x: 1, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 330),
    ]),
    BarChartGroupData(x: 2, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 480),
    ]),
    BarChartGroupData(x: 3, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 621),
    ]),
    BarChartGroupData(x: 4, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 482),
    ]),
    BarChartGroupData(x: 5, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 426),
    ]),
    BarChartGroupData(x: 6, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 593),
    ]),
    BarChartGroupData(x: 7, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 720),
    ]),
    BarChartGroupData(x: 8, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 341),
    ]),
    BarChartGroupData(x: 9, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 374),
    ]),
    BarChartGroupData(x: 10, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 486),
    ]),
    BarChartGroupData(x: 11, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 806),
    ]),
    BarChartGroupData(x: 12, showingTooltipIndicators: [
      0
    ], barRods: [
      BarChartRodData(color: const Color(0xff43dde6), toY: 521),
    ]),
  ];

  Timer? timer;
  String count = '';
  void refresh() {
    if (mounted == true) {
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        Future.delayed(Duration.zero, () {
          notification_count_notifier.Notification_count_data(doctorId.toString());
          notification_count_notifier.notifyListeners();
        });

        setState(() {
          count = notification_count_notifier.Notification_count;
        });
      });
    }
    if (mounted == false) {
      timer!.cancel();
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
        Future.delayed(Duration.zero, () {
          provider.todayConsultationCount(doctorId).then((value) {
            provider.notifyListeners();
            todayCount = provider
                .todayConsultationResponseClass.consultationCount
                .toString();
            todayCheckIn =
                provider.todayConsultationResponseClass.checkInCount.toString();
            todayDone =
                provider.todayConsultationResponseClass.doneCount.toString();
            MySharedPreferences.instance
                .getDoctorName('doctorName')
                .then((value) {
              setState(() {
                drname = value;
                print(drname);
              });
            });
            MySharedPreferences.instance
                .getEducation('doctorEducation')
                .then((value) {
              setState(() {
                drEducation = value;
                print(drname);
              });
            });
            MySharedPreferences.instance.getRole('doctorRole').then((value) {
              setState(() {
                role = value;
                print(role);
              });
            });
          });
        });

        Future.delayed(Duration.zero, () {
          provider1.graphWeekly(doctorId).then((value) {
            for (int i = 0; i < provider1.graphWeeklyClass.length; i++) {
              if (provider1.graphWeeklyClass[i].dayname == 'Monday') {
                setState(() {
                  monData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Tuesday') {
                setState(() {
                  tueData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Wednesday') {
                setState(() {
                  wedData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Thursday') {
                print(provider1.graphWeeklyClass[i].count);
                setState(() {
                  thuData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Friday') {
                setState(() {
                  friData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Saturday') {
                setState(() {
                  satData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Sunday') {
                setState(() {
                  sunData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              }
            }
            provider1.notifyListeners();
            largestWeekNumber = [
              monData.toInt(),
              tueData.toInt(),
              wedData.toInt(),
              thuData.toInt(),
              friData.toInt(),
              satData.toInt(),
              sunData.toInt()
            ].reduce(max);
            print(largestWeekNumber);
            print('irfan');
            print('Abdur');
          });
        });

        Future.delayed(Duration.zero, () {
          provider2.graphMonthly(doctorId).then((value) {
            for (int i = 0; i < provider2.graphMonthlyClass.length; i++) {
              if (provider2.graphMonthlyClass[i].monthname == 'January') {
                setState(() {
                  janData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'February') {
                setState(() {
                  febData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'March') {
                setState(() {
                  marData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'April') {
                print(provider2.graphMonthlyClass[i].count);
                setState(() {
                  aprData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'May') {
                setState(() {
                  mayData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'June') {
                setState(() {
                  junData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'July') {
                setState(() {
                  julData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'August') {
                setState(() {
                  augData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'September') {
                setState(() {
                  sepData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'October') {
                setState(() {
                  octData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'November') {
                setState(() {
                  novData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'December') {
                setState(() {
                  decData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              }
            }
            provider1.notifyListeners();
            largestMonthNumber = [
              janData.toInt(),
              febData.toInt(),
              marData.toInt(),
              aprData.toInt(),
              mayData.toInt(),
              junData.toInt(),
              julData.toInt(),
              augData.toInt(),
              sepData.toInt(),
              octData.toInt(),
              novData.toInt(),
              decData.toInt()
            ].reduce(max);
          });
        });

        Future.delayed(Duration.zero, () {
          provider3.pieChart(doctorId).then((value) {
            provider3.notifyListeners();
          });
        });
      });
    });
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer4<TodayConsultationCountNotifiers, GraphWeekNotifier,
        GraphMonthNotifier, PieChartNotifier>(
      builder: (context, provider, provider1, provider2, provider3, _) {
        this.provider = provider;
        this.provider1 = provider1;
        this.provider2 = provider2;
        this.provider3 = provider3;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: kToolbarHeight - 1,
                backgroundColor: const Color(0xff5A95FD),
                elevation: 0,
                // Text(
                //   'Dr. ' + drname + " " + drEducation,
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w600,
                //     fontSize: 24,
                //   ),
                // ),
                title: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role == 2 ? drname : 'Dr. ' + drname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        drEducation.toString() == 'null' ? "" : drEducation,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 12.0),
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           if (online == false) {
                  //             online = true;
                  //           } else {
                  //             online = false;
                  //           }
                  //         });
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         primary:
                  //             online == true ? Colors.green : Colors.redAccent,
                  //       ),
                  //       child: Text(online == true ? 'Online' : 'Offline'),
                  //     ),
                  //   ),
                  Consumer<NotificationCountNotifier>(
                    builder: (context, provider, _) {
                      notification_count_notifier = provider;
                      return ModalProgressHUD(
                        inAsyncCall: provider.isloading,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            );
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: provider.Notification_count == '0'
                                ? const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  )
                                : Badge(
                                    badgeContent: Text(
                                      provider.Notification_count,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    child: const Icon(
                                      Icons.notifications_none,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: buildBody(context),
              drawer: const DrawerWidget(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddWalkInPatient(),
                    ),
                  );
                },
                backgroundColor: const Color(0xff68A1F8),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return RefreshIndicator(
      onRefresh: () async {
        print('refreshed');
        Future.delayed(Duration.zero, () {
          provider.todayConsultationCount(doctorId).then((value) {
            provider.notifyListeners();
            todayCount = provider
                .todayConsultationResponseClass.consultationCount
                .toString();
            todayCheckIn =
                provider.todayConsultationResponseClass.checkInCount.toString();
            todayDone =
                provider.todayConsultationResponseClass.doneCount.toString();
            MySharedPreferences.instance
                .getDoctorName('doctorName')
                .then((value) {
              setState(() {
                drname = value;
                print(drname);
              });
            });
          });
        });

        Future.delayed(Duration.zero, () {
          provider1.graphWeekly(doctorId).then((value) {
            for (int i = 0; i < provider1.graphWeeklyClass.length; i++) {
              if (provider1.graphWeeklyClass[i].dayname == 'Monday') {
                setState(() {
                  monData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Tuesday') {
                setState(() {
                  tueData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Wednesday') {
                setState(() {
                  wedData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Thursday') {
                print(provider1.graphWeeklyClass[i].count);
                setState(() {
                  thuData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Friday') {
                setState(() {
                  friData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Saturday') {
                setState(() {
                  satData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              } else if (provider1.graphWeeklyClass[i].dayname == 'Sunday') {
                setState(() {
                  sunData = provider1.graphWeeklyClass[i].count ?? 0;
                });
              }
            }
            provider1.notifyListeners();
            largestWeekNumber = [
              monData.toInt(),
              tueData.toInt(),
              wedData.toInt(),
              thuData.toInt(),
              friData.toInt(),
              satData.toInt(),
              sunData.toInt()
            ].reduce(max);
            print(largestWeekNumber);
            print('irfan');
            print('Abdur');
          });
        });

        Future.delayed(Duration.zero, () {
          provider2.graphMonthly(doctorId).then((value) {
            for (int i = 0; i < provider2.graphMonthlyClass.length; i++) {
              if (provider2.graphMonthlyClass[i].monthname == 'January') {
                setState(() {
                  janData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'February') {
                setState(() {
                  febData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'March') {
                setState(() {
                  marData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'April') {
                print(provider2.graphMonthlyClass[i].count);
                setState(() {
                  aprData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'May') {
                setState(() {
                  mayData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'June') {
                setState(() {
                  junData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'July') {
                setState(() {
                  julData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname == 'August') {
                setState(() {
                  augData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'September') {
                setState(() {
                  sepData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'October') {
                setState(() {
                  octData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'November') {
                setState(() {
                  novData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              } else if (provider2.graphMonthlyClass[i].monthname ==
                  'December') {
                setState(() {
                  decData = provider2.graphMonthlyClass[i].count ?? 0;
                });
              }
            }
            provider1.notifyListeners();
            largestMonthNumber = [
              janData.toInt(),
              febData.toInt(),
              marData.toInt(),
              aprData.toInt(),
              mayData.toInt(),
              junData.toInt(),
              julData.toInt(),
              augData.toInt(),
              sepData.toInt(),
              octData.toInt(),
              novData.toInt(),
              decData.toInt()
            ].reduce(max);
          });
        });

        Future.delayed(Duration.zero, () {
          provider3.pieChart(doctorId).then((value) {
            provider3.notifyListeners();
          });
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: portraitBuild(context),
      ),
    );
  }

  // OrientationBuilder(
  // builder: (context, orientation) {
  // if (orientation == Orientation.portrait) {
  // return portraitBuild(context);
  // } else {
  // return landscapeBuild(context);
  // }
  // },
  // ),

  Widget landscapeBuild(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/dashboardmain.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Morning',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    'Dr. Jhone',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  landscapeTodayConsultancyCard(context),
                  const SizedBox(
                    height: 35,
                  ),
                  landscapeAddAvailabilityCard(context),
                  const SizedBox(
                    height: 35,
                  ),
                  landscapeListAvailabilityCard(context),
                  const SizedBox(
                    height: 35,
                  ),
                  landscapeAppointmentStatusCard(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget portraitBuild(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/dashboardmain.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.28
              : MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              todayConsultancyCard(context),
              const SizedBox(
                height: 20,
              ),
              barChart(context),
              const SizedBox(
                height: 20,
              ),
              pieChartDataThree(context),
              // addAvailabilityCard(context),
              // const SizedBox(
              //   height: 35,
              // ),
              // listAvailabilityCard(context),
              // const SizedBox(
              //   height: 35,
              // ),
              // appointmentStatusCard(context),
              //tabBarControl(context),
              // const SizedBox(
              //   height: 20,
              // ),
              // tabBarChild(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget landscapeTodayConsultancyCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.CheckedInAndDone);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Consultation',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Text(
                        '54',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Today\'s \nConsultation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff808080),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        '8',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Checked In',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff808080),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff808080),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Text(
                '09:00 AM - 07:00 PM',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff28AF6F),
                ),
              ),
              const Text(
                'All lights will switch of automatically as per the timer which is there in the setting.All lights will switch of automatically as per the timer which is there in the setting.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff909090),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todayConsultancyCard(context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, RoutePaths.CheckedInAndDone);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Container(
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.33
              : MediaQuery.of(context).size.height * 0.15,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff3284E5).withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(2, 2),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Consultation',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          todayCount == 'null' ? '-' : todayCount,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Consultation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff808080),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          todayCheckIn == 'null' ? '-' : todayCheckIn,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Checked In',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff808080),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          todayDone == 'null' ? '-' : todayDone,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff808080),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget landscapeAddAvailabilityCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.TimeAndToken);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.group_add,
                color: Color(0xff649CF6),
                size: 50,
              ),
              Text(
                'Add Availability',
                style: TextStyle(
                  color: Color(0xff818181),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addAvailabilityCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.TimeAndToken);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(-2, 2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 15,
              top: -10,
              child: Icon(
                Icons.group_add,
                color: const Color(0xff649CF6).withOpacity(0.2),
                size: 110,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Icons.group_add,
                      color: Color(0xff649CF6),
                      size: 50,
                    ),
                    Text(
                      'Add Availability',
                      style: TextStyle(
                        color: Color(0xff818181),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landscapeListAvailabilityCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.ListAvailability);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(2, 2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                'List Availability',
                style: TextStyle(
                  color: Color(0xff818181),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.list,
                color: Color(0xff649CF6),
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listAvailabilityCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.ListAvailability);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(2, 2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: 15,
              child: Icon(
                Icons.list,
                color: const Color(0xff649CF6).withOpacity(0.2),
                size: 110,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'List Availability',
                      style: TextStyle(
                        color: Color(0xff818181),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.list,
                      color: Color(0xff649CF6),
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landscapeAppointmentStatusCard(context) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.PatientData);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff3284E5).withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FittedBox(
                      child: Text(
                        'List Of Appointment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff28AF6F),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      'You have appoint for Ophtgalmologist',
                      style: TextStyle(
                        color: Color(0xff909090),
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      '12 May, 12:50Am',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      'Doctor',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff3284E5).withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 10,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Dr. Jhon',
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  'Ophthamologist',
                                  style: TextStyle(fontSize: 5),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.shopping_bag,
                              size: 20,
                              color: Color(0xff39C871),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.AddInfo);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff3284E5).withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FittedBox(
                      child: Text(
                        'Add Walk-In Patient',
                        style: TextStyle(
                          color: Color(0xffFF3A3A),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      'You can add an appointment on behalf of walk-in patient',
                      style: TextStyle(
                        color: Color(0xff909090),
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      '12 May, 12:50Am',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget appointmentStatusCard(context) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.PatientData);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff3284E5).withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                      spreadRadius: 2),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FittedBox(
                      child: Text(
                        'List Of Appointment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff28AF6F),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text(
                      'You have appoint for Ophtgalmologist',
                      style: TextStyle(
                        color: Color(0xff909090),
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      '12 May, 12:50Am',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      'Doctor',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff3284E5).withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 10,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Dr. Jhon',
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  'Ophthamologist',
                                  style: TextStyle(fontSize: 5),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.shopping_bag,
                              size: 20,
                              color: Color(0xff39C871),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddWalkInPatient()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff3284E5).withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FittedBox(
                      child: Text(
                        'Add Walk-In Patient',
                        style: TextStyle(
                          color: Color(0xffFF3A3A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text(
                      'You can add an appointment on behalf of walk-in patient',
                      style: TextStyle(
                        color: Color(0xff909090),
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      '12 May, 12:50Am',
                      style: TextStyle(
                        color: Color(0xff7b7b7b),
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget barChart(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? 300
            : MediaQuery.of(context).size.height * 0.33,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(2, 2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 15.0, top: 10.0),
              child: Row(
                children: [
                  const Text(
                    'Patient\'s Visited',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      setState(() {
                        showChartData = false;
                      });
                    },
                    child: Text(
                      'Weekly',
                      style: TextStyle(
                        color: showChartData == false
                            ? Colors.blueAccent
                            : Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      setState(() {
                        showChartData = true;
                      });
                    },
                    child: Text(
                      'Monthly',
                      style: TextStyle(
                        color: showChartData == true
                            ? Colors.blueAccent
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            showChartData == false
                ? Consumer<GraphWeekNotifier>(
                    builder: (context, provider1, _) {
                      this.provider1 = provider1;
                      return ModalProgressHUD(
                        inAsyncCall: provider1.isloading,
                        color: Colors.transparent,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, bottom: 20.0),
                            child: BarChart(
                              BarChartData(
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.transparent,
                                    tooltipPadding: const EdgeInsets.all(0),
                                    tooltipMargin: 8,
                                    getTooltipItem: (
                                      BarChartGroupData group,
                                      int groupIndex,
                                      BarChartRodData rod,
                                      int rodIndex,
                                    ) {
                                      return BarTooltipItem(
                                        rod.toY.round().toString(),
                                        const TextStyle(
                                          color: Color(0xff7589a2),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget: getBottomTitles,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                    // sideTitles: SideTitles(
                                    //   showTitles: true,
                                    //   reservedSize: 30,
                                    //   interval: 1.5,
                                    //   getTitlesWidget: getLeftTitles,
                                    // ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                gridData: FlGridData(
                                  show: false,
                                ),
                                maxY: largestWeekNumber + 10,
                                barGroups: [
                                  BarChartGroupData(
                                      x: 1,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: monData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 2,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: tueData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 3,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: wedData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 4,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: thuData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 5,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: friData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 6,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: satData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 7,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: sunData.toDouble()),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Consumer<GraphMonthNotifier>(
                    builder: (context, provider2, _) {
                      this.provider2 = provider2;
                      return ModalProgressHUD(
                        inAsyncCall: provider2.isloading,
                        color: Colors.transparent,
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 20.0),
                            child: BarChart(
                              BarChartData(
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.transparent,
                                    tooltipPadding: const EdgeInsets.all(0),
                                    tooltipMargin: 8,
                                    getTooltipItem: (
                                      BarChartGroupData group,
                                      int groupIndex,
                                      BarChartRodData rod,
                                      int rodIndex,
                                    ) {
                                      return BarTooltipItem(
                                        rod.toY.round().toString(),
                                        const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xff7589a2),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget: getBottomMonthTiles,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                    // sideTitles: SideTitles(
                                    //   showTitles: true,
                                    //   reservedSize: 30,
                                    //   interval: 1.5,
                                    //   getTitlesWidget: getLeftTitles,
                                    // ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                gridData: FlGridData(
                                  show: false,
                                ),
                                maxY: largestMonthNumber + 10,
                                barGroups: [
                                  BarChartGroupData(
                                      x: 1,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: janData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 2,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: febData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 3,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: marData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 4,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: aprData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 5,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: mayData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 6,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: junData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 7,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: julData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 8,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: augData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 9,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: sepData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 10,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: octData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 11,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: novData.toDouble()),
                                      ]),
                                  BarChartGroupData(
                                      x: 12,
                                      showingTooltipIndicators: [
                                        0
                                      ],
                                      barRods: [
                                        BarChartRodData(
                                            color: const Color(0xff43dde6),
                                            toY: decData.toDouble()),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }

  Widget pieChartDataThree(context) {
    return Padding(
      padding: MediaQuery.of(context).orientation == Orientation.landscape
          ? const EdgeInsets.only(left: 20, right: 20, bottom: 20)
          : const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? 250
            : MediaQuery.of(context).size.height * 0.33,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3284E5).withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(2, 2),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Consumer<PieChartNotifier>(
              builder: (context, provider3, _) {
                this.provider3 = provider3;
                return Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      sections: [
                        PieChartSectionData(
                          color: const Color(0xff8da0cb),
                          value: provider3.walkedInClass == 0
                              ? 1
                              : provider3.walkedInClass.toDouble(),
                          title: provider3.walkedInClass.toString(),
                          radius: 30,
                          titleStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),
                        PieChartSectionData(
                          color: const Color(0xff66c2a5),
                          value: provider3.allAppointmentClass == 0
                              ? 1
                              : provider3.allAppointmentClass.toDouble(),
                          title: provider3.allAppointmentClass.toString(),
                          radius: 30,
                          titleStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),
                        PieChartSectionData(
                          color: const Color(0xfffc8d62),
                          value: provider3.emergencyClass == 0
                              ? 1
                              : provider3.emergencyClass.toDouble(),
                          title: provider3.emergencyClass.toString(),
                          radius: 30,
                          titleStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff66c2a5),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Booked'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff8da0cb),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Walked-In'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xfffc8d62),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Emergency'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBarControl(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff68A1F8), width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TabBar(
            tabs: const [
              Tab(
                text: 'Appointment',
              ),
              Tab(
                text: 'Checked In',
              ),
              Tab(
                text: 'Done Appointment',
              ),
            ],
            indicator: BoxDecoration(
              color: const Color(0xff68A1F8),
              borderRadius: BorderRadius.circular(20),
            ),
            unselectedLabelColor: const Color(0xff68A0F8),
          ),
        ),
      ),
    );
  }

  Widget tabBarChild(context) {
    return const Flexible(
      child: TabBarView(
        children: [
          // CheckedInScreen(),
          // DoneAppointment(),
          TodayAppointment(),
          CheckedIn(),
          DoneAppointment1(),
        ],
      ),
    );
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
                            Future.delayed(Duration.zero, () {
                              provider
                                  .todayConsultationCount(doctorId)
                                  .then((value) {
                                provider.notifyListeners();
                                todayCount = provider
                                    .todayConsultationResponseClass
                                    .consultationCount
                                    .toString();
                                todayCheckIn = provider
                                    .todayConsultationResponseClass.checkInCount
                                    .toString();
                                todayDone = provider
                                    .todayConsultationResponseClass.doneCount
                                    .toString();
                                MySharedPreferences.instance
                                    .getDoctorName('doctorName')
                                    .then((value) {
                                  setState(() {
                                    drname = value;
                                    print(drname);
                                  });
                                });
                              });
                            });

                            Future.delayed(Duration.zero, () {
                              provider1.graphWeekly(doctorId).then((value) {
                                for (int i = 0;
                                    i < provider1.graphWeeklyClass.length;
                                    i++) {
                                  if (provider1.graphWeeklyClass[i].dayname ==
                                      'Monday') {
                                    setState(() {
                                      monData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  } else if (provider1
                                          .graphWeeklyClass[i].dayname ==
                                      'Tuesday') {
                                    setState(() {
                                      tueData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  } else if (provider1
                                          .graphWeeklyClass[i].dayname ==
                                      'Wednesday') {
                                    setState(() {
                                      wedData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  } else if (provider1
                                          .graphWeeklyClass[i].dayname ==
                                      'Thursday') {
                                    print(provider1.graphWeeklyClass[i].count);
                                    setState(() {
                                      thuData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  } else if (provider1
                                          .graphWeeklyClass[i].dayname ==
                                      'Friday') {
                                    setState(() {
                                      friData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  } else if (provider1
                                          .graphWeeklyClass[i].dayname ==
                                      'Saturday') {
                                    setState(() {
                                      satData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  } else if (provider1
                                          .graphWeeklyClass[i].dayname ==
                                      'Sunday') {
                                    setState(() {
                                      sunData =
                                          provider1.graphWeeklyClass[i].count ??
                                              0;
                                    });
                                  }
                                }
                                provider1.notifyListeners();
                                largestWeekNumber = [
                                  monData.toInt(),
                                  tueData.toInt(),
                                  wedData.toInt(),
                                  thuData.toInt(),
                                  friData.toInt(),
                                  satData.toInt(),
                                  sunData.toInt()
                                ].reduce(max);
                                print(largestWeekNumber);
                                print('irfan');
                                print('Abdur');
                              });
                            });

                            Future.delayed(Duration.zero, () {
                              provider2.graphMonthly(doctorId).then((value) {
                                for (int i = 0;
                                    i < provider2.graphMonthlyClass.length;
                                    i++) {
                                  if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'January') {
                                    setState(() {
                                      janData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'February') {
                                    setState(() {
                                      febData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'March') {
                                    setState(() {
                                      marData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'April') {
                                    print(provider2.graphMonthlyClass[i].count);
                                    setState(() {
                                      aprData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'May') {
                                    setState(() {
                                      mayData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'June') {
                                    setState(() {
                                      junData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'July') {
                                    setState(() {
                                      julData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'August') {
                                    setState(() {
                                      augData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'September') {
                                    setState(() {
                                      sepData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'October') {
                                    setState(() {
                                      octData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'November') {
                                    setState(() {
                                      novData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  } else if (provider2
                                          .graphMonthlyClass[i].monthname ==
                                      'December') {
                                    setState(() {
                                      decData = provider2
                                              .graphMonthlyClass[i].count ??
                                          0;
                                    });
                                  }
                                }
                                provider1.notifyListeners();
                                largestMonthNumber = [
                                  janData.toInt(),
                                  febData.toInt(),
                                  marData.toInt(),
                                  aprData.toInt(),
                                  mayData.toInt(),
                                  junData.toInt(),
                                  julData.toInt(),
                                  augData.toInt(),
                                  sepData.toInt(),
                                  octData.toInt(),
                                  novData.toInt(),
                                  decData.toInt()
                                ].reduce(max);
                              });
                            });

                            Future.delayed(Duration.zero, () {
                              provider3.pieChart(doctorId).then((value) {
                                provider3.notifyListeners();
                              });
                            });
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
}
