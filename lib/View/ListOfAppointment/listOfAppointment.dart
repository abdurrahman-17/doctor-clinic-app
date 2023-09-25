import 'package:doctor_clinic_token_app/View/Patient%20Data/appointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/checkedin.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/doneappointment.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/material.dart';

class ListOfAppointment extends StatefulWidget {
  int selectedPage;
  ListOfAppointment({Key? key, required this.selectedPage}) : super(key: key);

  @override
  _ListOfAppointmentState createState() => _ListOfAppointmentState();
}

class _ListOfAppointmentState extends State<ListOfAppointment> {
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
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.selectedPage,
        length: 3,
        child: Scaffold(
          body: Stack(
            children: [
              Image(
                image: const AssetImage('assets/verysmall.png'),
                fit: BoxFit.fill,
                height:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.height * 0.18
                        : MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width,
              ),
              appointmentList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget appointmentList(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
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
                'Appointment List',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        tabBarControl(context),
        const SizedBox(
          height: 25,
        ),
        tabBarChild(context),
      ],
    );
  }

  Widget tabBarControl(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                text: 'Done',
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
}
