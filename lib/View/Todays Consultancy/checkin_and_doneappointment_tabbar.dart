import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/material.dart';
import 'checkedin_screen.dart';
import 'done_appointment_screen.dart';

class CheckInAndDoneAppointment extends StatefulWidget {
  const CheckInAndDoneAppointment({Key? key}) : super(key: key);

  @override
  _CheckInAndDoneAppointmentState createState() => _CheckInAndDoneAppointmentState();
}

class _CheckInAndDoneAppointmentState extends State<CheckInAndDoneAppointment> {

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if(value==false){
        _showConnectionState();
      }});
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
                      if(value==true){
                        Navigator.pop(context);
                      }});
                  },
                  child: Text('Retry',))
            ],
            title: new Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff3f3f3),
          body: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(context){
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/verysmall.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    backButton(context),
                    const SizedBox(
                      height: 5,
                    ),
                    headingText(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
    return Container(
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
    );
  }

  Widget tabBarControl(context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff68A1F8), width: 2),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TabBar(
          tabs: const [
            Tab(
              text:'Checked In',
            ),
            Tab(
              text: 'Done Appointment',
            ),
          ],
          indicator: BoxDecoration(
            color: const Color(0xff68A1F8),
            borderRadius: BorderRadius.circular(35),
          ),
          unselectedLabelColor: const Color(0xff68A0F8),
        ),
      ),
    );
  }

  Widget tabBarChild(context) {
    return SingleChildScrollView(
      child: Container(
         height: MediaQuery.of(context).size.height * 0.76,
        child: const TabBarView(
          children: [
            CheckedInScreen(),
            DoneAppointment(),
          ],
        ),
      ),
    );
  }
}

