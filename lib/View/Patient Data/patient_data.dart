import 'package:doctor_clinic_token_app/View/Patient%20Data/appointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/checkedin.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/doneappointment.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/material.dart';

class PatientData extends StatefulWidget {
  PatientData({Key? key}) : super(key: key);

  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
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
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff3f3f3),
          body: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/verysmall.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.2
              : MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              backButton(context),
              // const SizedBox(
              //   height: 15,
              // ),
              // headingText(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              tabBarControl(context),
              const SizedBox(
                height: 20,
              ),
              tabBarChild(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget headingText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Today\'s Consultation',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget backButton(context) {
    return Row(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 15,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        const Text(
          'Today\'s Consultation',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget tabBarControl(context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff68A1F8), width: 2),
        borderRadius: BorderRadius.circular(10),
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
            borderRadius: BorderRadius.circular(10),
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
          // CheckedInScreen(),
          // DoneAppointment(),
          TodayAppointment(),
          const CheckedIn(),
          DoneAppointment1(),
        ],
      ),
    );
  }
}
