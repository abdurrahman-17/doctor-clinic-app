import 'package:doctor_clinic_token_app/View/PatientList/addPatientRegister.dart';
import 'package:doctor_clinic_token_app/View/PatientList/emergencyList.dart';
import 'package:doctor_clinic_token_app/View/PatientList/registeredPatient.dart';
import 'package:doctor_clinic_token_app/View/PatientList/walkedinPatient.dart';
import 'package:flutter/material.dart';

class Patientlist extends StatefulWidget {
  const Patientlist({Key? key}) : super(key: key);

  @override
  _PatientlistState createState() => _PatientlistState();
}

class _PatientlistState extends State<Patientlist> {
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
              ? MediaQuery.of(context).size.height * 0.18
              : MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(context),
            // filterList(context),
            // headingText(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            tabBarControl(context),
            const SizedBox(
              height: 20,
            ),
            tabBarChild(context),
          ],
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
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0, right: 15.0),
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
            'Patient\'s List',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 25,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPatientRegister(),
                  ),
                );
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: const Text(
                'Add Patient',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
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
                text: 'Registered',
              ),
              Tab(
                text: 'Walked In',
              ),
              Tab(
                text: 'Emergency',
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
          RegisteredPatient(),
          WalkedInPatient(),
          EmergencyPatient(),
        ],
      ),
    );
  }
}
