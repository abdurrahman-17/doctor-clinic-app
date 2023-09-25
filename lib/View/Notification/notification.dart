import 'package:doctor_clinic_token_app/core/request_response/getAllNotification/getAllNotificationNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/notification_Count/notification_Notifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/readNotification/readNotificationNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}



class _NotificationScreenState extends State<NotificationScreen> {
  GetAllNotificationNotifier getAllNotificationNotifier =
      GetAllNotificationNotifier();
  ReadNotificationNotfier read_notification_notfier =
  ReadNotificationNotfier();
  NotificationCountNotifier notification_count_notifier =
  NotificationCountNotifier();
  int doctorId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
        Future.delayed(Duration.zero, () {
          getAllNotificationNotifier.getNotificationData(doctorId);
          getAllNotificationNotifier.notifyListeners();
        });
      });
    });
  }
  @override
  void dispose() {
    refresh();
    Future.delayed(Duration.zero, () {
      read_notification_notfier.read_Notification_Data(doctorId.toString());
      Navigator.pop(context);
    });
  }
  void refresh() {
    Future.delayed(Duration.zero, () {
      notification_count_notifier.Notification_count_data(doctorId.toString());
      notification_count_notifier.notifyListeners();


    });
  }



    @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<GetAllNotificationNotifier>(
      builder: (context, provider, _) {
        getAllNotificationNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
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
                  const SizedBox(
                    height: 40,
                  ),
                  //buildNotificationTitle(context),
                  getAllNotificationNotifier.notificationResponseClass.isEmpty
                      ? Container()
                      : buildNewtitle(context),
                  getAllNotificationNotifier.notificationResponseClass.isEmpty
                      ? Container()
                      : buildnewnotifylist(context),
                  getAllNotificationNotifier.notificationResponseClass.isEmpty
                      ? Container()
                      : buildRecenttitle(context),
                  buildrecentnotifylist(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, bottom: 10, left: 5.0, right: 5.0),
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
            'Notifications',
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

  Widget buildNotificationTitle(context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: Text(
          'Notification',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: const Color(0xff4889fd),
          ),
        ),
      ),
    );
  }

  Widget buildNewtitle(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          'Today',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget buildnewnotifylist(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getAllNotificationNotifier.notificationResponseClass.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 25, right: 25, top: 5),
          child: Container(
            decoration: BoxDecoration(
              color: getAllNotificationNotifier
                          .notificationResponseClass[index].doctorReadStatus ==
                      0
                  ? Color(0xffdbf3fa)
                  : Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getAllNotificationNotifier
                        .notificationResponseClass[index].title
                        .toString(),
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    getAllNotificationNotifier
                        .notificationResponseClass[index].date
                        .toString()
                        .split(" ")
                        .first,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    getAllNotificationNotifier
                        .notificationResponseClass[index].doctorBody
                        .toString(),
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildRecenttitle(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: const Text(
            'Earlier',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildrecentnotifylist(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          getAllNotificationNotifier.earlierNotificationResponseClass.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 25, right: 25, top: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getAllNotificationNotifier
                        .earlierNotificationResponseClass[index].title
                        .toString(),
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    getAllNotificationNotifier
                        .earlierNotificationResponseClass[index].date
                        .toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    getAllNotificationNotifier
                        .earlierNotificationResponseClass[index].doctorBody
                        .toString(),
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
