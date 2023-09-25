import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddInfoPatient extends StatefulWidget {
  final patientName;
  final phoneNumber;
  final bookedDate;
  final timeOrToken;
  final patientId;
  final patientAge;
  final patientGender;
  final healthIssue;
  final type;

  AddInfoPatient({
    Key? key,
    this.patientId,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.bookedDate,
    this.phoneNumber,
    this.timeOrToken,
    this.healthIssue,
    this.type,
  }) : super(key: key);

  @override
  _AddInfoPatientState createState() => _AddInfoPatientState();
}

class _AddInfoPatientState extends State<AddInfoPatient> {
  late AddPatientInfoNotifier? addPatientInfoNotifier;

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
    setState(() {
      phoneNumberController.text = widget.phoneNumber.toString();
      genderController.text = widget.patientGender.toString();
      bookedDateController.text = widget.bookedDate.toString();
      final ages = calculateAge(widget.patientAge);
      ageController.text = ages.toString();
      timeOrTokenController.text = widget.timeOrToken.toString();
      healthIssueController.text = widget.healthIssue.toString();
      print(widget.patientId);
    });
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final bookedDateController = TextEditingController();
  final timeOrTokenController = TextEditingController();
  final healthIssueController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final diabetesController = TextEditingController();
  final temperatureController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final pulseRateController = TextEditingController();
  final spo2Controller = TextEditingController();
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
    if (!kReleaseMode) {}
    return Consumer<AddPatientInfoNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: SafeArea(
            child: Scaffold(
              body: buildBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/verysmall.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.115,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButton(context),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // headingText(context),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            fullNameAndPhNumber(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            maleFemaleRadio(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            ageAndDOB(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            helathIssue(context),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            bloodPressureAndSPO2(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            temperatureAndHeartBeat(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            pulseRate(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            weightAndHeight(context),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    submitButton(context),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
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
          Text(
            widget.patientName,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget headingText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Abdul Rahman M',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget fullNameAndPhNumber(context) {
    return Column(
      children: [
        // TextFormField(
        //   // validator: validateConfirmPassword,
        //   controller: fullNameController,
        //   // obscureText: _isObscure1,
        //   decoration: InputDecoration(
        //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        //     fillColor: Colors.white,
        //     filled: true,
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(10),
        //       borderSide: const BorderSide(),
        //     ),
        //     label: const Text('Full Name'),
        //   ),
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.02,
        // ),
        TextFormField(
          // validator: validateConfirmPassword,
          controller: phoneNumberController,
          // obscureText: _isObscure1,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(),
            ),
            label: const Text('Phone Number'),
          ),
        ),
      ],
    );
  }

  Widget maleFemaleRadio(context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: genderController,
            // obscureText: _isObscure1,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const Text('Gender'),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: bookedDateController,
            // obscureText: _isObscure1,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const Text('Booked Date'),
            ),
          ),
        ),
      ],
    );
  }

  Widget ageAndDOB(context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: ageController,
            // obscureText: _isObscure1,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const Text('Age'),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: timeOrTokenController,
            // obscureText: _isObscure1,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: Text(widget.type == 1
                  ? 'Booked Time'
                  : widget.type == 2
                      ? 'Booked Token'
                      : ''),
            ),
          ),
        ),
      ],
    );
  }

  Widget helathIssue(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: healthIssueController,
      // obscureText: _isObscure1,
      enabled: false,
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        fillColor: Colors.white,
        alignLabelWithHint: true,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        label: const Text('Health Issue'),
      ),
    );
  }

  Widget bloodPressureAndSPO2(context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: bloodPressureController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const FittedBox(child: Text('BP')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'mm/Hg',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: diabetesController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const FittedBox(child: Text('Diabetes')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'mg/dL',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget temperatureAndHeartBeat(context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: temperatureController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const FittedBox(
                child: Text('Temp'),
              ),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      '°F',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: spo2Controller,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const FittedBox(child: Text('SPO2')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      '%',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pulseRate(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: pulseRateController,
      // obscureText: _isObscure1,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        label: const FittedBox(child: Text('Pulse')),
        suffixIcon: Container(
          width: 10,
          decoration: BoxDecoration(
            color: const Color(0xff4889FD),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(),
            child: Center(
              child: Text(
                'b/mts',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget weightAndHeight(context) {
    return Row(
      children: [
        // Expanded(
        //   flex: 1,
        //   child: TextFormField(
        //     // validator: validateConfirmPassword,
        //     controller: pulseRateController,
        //     // obscureText: _isObscure1,
        //     keyboardType: TextInputType.number,
        //     decoration: InputDecoration(
        //       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        //       fillColor: Colors.white,
        //       filled: true,
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         borderSide: const BorderSide(),
        //       ),
        //       label: FittedBox(child: const Text('Pulse Rate')),
        //       suffixIcon: Container(
        //         width: 10,
        //         decoration: BoxDecoration(
        //           color: const Color(0xff4889FD),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: const Padding(
        //           padding: EdgeInsets.symmetric(),
        //           child: Center(
        //             child: Text(
        //               'b/mts',
        //               textAlign: TextAlign.center,
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 30,
        // ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: heightController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const FittedBox(
                child: Text('Height'),
              ),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: weightController,
            // obscureText: _isObscure1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(),
              ),
              label: const FittedBox(child: Text('Weight')),
              suffixIcon: Container(
                width: 10,
                decoration: BoxDecoration(
                  color: const Color(0xff4889FD),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(),
                  child: Center(
                    child: Text(
                      'kg',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton(context) {
    addPatientInfoNotifier =
        Provider.of<AddPatientInfoNotifier?>(context, listen: false);
    return Center(
      child: SizedBox(
        width: 180,
        height: 50,
        child: ElevatedButton(
          style: getButtonStyle(context),
          onPressed: () async {
            addPatientInfoNotifier?.addPatientInfo(
              widget.patientId,
              bloodPressureController.text.isEmpty
                  ? 0
                  : int.parse(bloodPressureController.text),
              diabetesController.text.isEmpty
                  ? 0
                  : int.parse(diabetesController.text),
              temperatureController.text.isEmpty
                  ? 0
                  : double.parse(temperatureController.text),
              spo2Controller.text.isEmpty ? 0 : int.parse(spo2Controller.text),
              pulseRateController.text.isEmpty
                  ? 0
                  : int.parse(pulseRateController.text),
              weightController.text.isEmpty
                  ? 0
                  : int.parse(weightController.text),
              heightController.text.isEmpty
                  ? 0
                  : int.parse(heightController.text),
            );
            // if (bloodPressureController.text.isNotEmpty) {
            //   if (diabetesController.text.isNotEmpty) {
            //     if (temperatureController.text.isNotEmpty) {
            //       if (spo2Controller.text.isNotEmpty) {
            //         if (pulseRateController.text.isNotEmpty) {
            //           if (heightController.text.isNotEmpty) {
            //             if (weightController.text.isNotEmpty) {
            //
            //             } else {
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                   SnackBar(content: Text('Please enter Weight')));
            //             }
            //           } else {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(content: Text('Please enter Height')));
            //           }
            //         } else {
            //           ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Please enter Pulse Rate')));
            //         }
            //       } else {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //             SnackBar(content: Text('Please enter SPO2')));
            //       }
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text('Please enter Temperature')));
            //     }
            //   } else {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Please enter Diabetes')));
            //   }
            // } else {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text('Please enter Blood Pressure')));
            // }
          },
          child: Text(
            'Submit',
            style: TextButtonStyle(context),
          ),
        ),
      ),
      // child: SizedBox(
      //   height: 45,
      //   width: 120,
      //   child: OutlinedButton(
      //     onPressed: () {
      //       // addPatientInfoNotifier?.addPatientInfo(
      //       //   widget.patientId,
      //       //   int.parse(bloodpressureController.text),
      //       //   int.parse(diabetesController.text),
      //       //   double.parse(temperatureController.text),
      //       //   int.parse(heartBeatController.text),
      //       //   int.parse(weightController.text),
      //       //   double.parse(heightController.text),
      //       // );
      //       // Navigator.pushNamed(context, RoutePaths.PatientData);
      //     },
      //     style: ButtonStyle(
      //       side: MaterialStateProperty.all(
      //         const BorderSide(
      //           color: Color(0xff6EA7FA),
      //           width: 2,
      //         ),
      //       ),
      //       shape: MaterialStateProperty.all(
      //         RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     child: const Text(
      //       'Submit',
      //       style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.w600,
      //         color: Color(0xff6EA7FA),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
