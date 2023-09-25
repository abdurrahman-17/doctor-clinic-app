import 'dart:io';

import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/View/ImageView/imageView.dart';
import 'package:doctor_clinic_token_app/View/ManagePrescription/addPrescription/addPrescription.dart';
import 'package:doctor_clinic_token_app/View/pdfViewer/pdfViewer.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorfeedback/doctorfeedbackNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/htmlData/htmlDataNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CheckedInInfo extends StatefulWidget {
  final patientName;
  final phoneNumber;
  final bookedDate;
  final timeOrToken;
  final patientId;
  final patientAge;
  final patientGender;
  final healthIssue;
  final bloodPressure;
  final diabetes;
  final temperature;
  final height;
  final weight;
  final pulseRate;
  final spo2;
  final type;

  const CheckedInInfo({
    Key? key,
    this.patientId,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.bookedDate,
    this.phoneNumber,
    this.timeOrToken,
    this.healthIssue,
    this.bloodPressure,
    this.diabetes,
    this.temperature,
    this.height,
    this.weight,
    this.pulseRate,
    this.spo2,
    this.type,
  }) : super(key: key);

  @override
  _CheckedInInfoState createState() => _CheckedInInfoState();
}

class _CheckedInInfoState extends State<CheckedInInfo> {
  DoctorFeedbackNotifier provider = DoctorFeedbackNotifier();
  HTMLDataNotifier htmlDataNotifier = HTMLDataNotifier();

  //XFile? oneImage;
  bool isProgress = true;
  List<String>? _image = [];
  List<String> _image1 = [];
  String fileName = '';
  var imagePath;
  File? generatedPdfFilePath;
  String generatedPdfFilePathLast = '';
  int doctorId = 0;

  Future<void> generateExampleDocument() async {
    final htmlContent =
        htmlDataNotifier.htmlResponseMessage != 'No_Prescription_report_fount'
            ? htmlDataNotifier.htmlResponseClass
            : "";
    print(htmlContent);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "prescription";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile;
    isProgress = false;
    generatedPdfFilePathLast = generatedPdfFile.path.split('/').last;
  }

  _imgFromGallery() async {
    var selectedImage = await ImagePicker().pickMultiImage(imageQuality: 50);

    selectedImage!.forEach((image) {
      setState(() {
        _image!.add(image.path.split('/').last);
        _image1.add(image.path);
        //print(_image1);
      });
    });
    print('Hello');
    print(_image1);
  }

  _imgFromCamera() async {
    final selectedImage = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    print('Hello');
    setState(() {
      print('Nice');
      _image!.add(selectedImage!.path.split('/').last);
      _image1.add(selectedImage.path);
      print(_image);
      print(_image1);
    });
  }

  htmlApiHit() async {
    await Future.delayed(Duration.zero, () {
      htmlDataNotifier.htmlResponse(widget.patientId);
    });
    await generateExampleDocument();
  }

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
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    htmlApiHit();

    setState(() {
      phoneNumberController.text = widget.phoneNumber.toString();
      genderController.text = widget.patientGender.toString();
      bookedDateController.text = widget.bookedDate.toString();
      final ages = calculateAge(widget.patientAge);
      ageController.text = ages.toString();
      timeOrTokenController.text = widget.timeOrToken.toString();
      healthIssueController.text = widget.healthIssue.toString();
      bloodpressureController.text = widget.bloodPressure.toString();
      diabetesController.text = widget.diabetes.toString();
      temperatureController.text = widget.temperature.toString();
      heightController.text = widget.height.toString();
      weightController.text = widget.weight.toString();
      pulseRateController.text = widget.pulseRate.toString();
      spo2Controller.text = widget.spo2.toString();
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
            title: const Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
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

  TextEditingController fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final genderController = TextEditingController();
  final bookedDateController = TextEditingController();
  final timeOrTokenController = TextEditingController();
  final healthIssueController = TextEditingController();
  final ageController = TextEditingController();
  final dobController = TextEditingController();
  final bloodpressureController = TextEditingController();
  final diabetesController = TextEditingController();
  final temperatureController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final pulseRateController = TextEditingController();
  final spo2Controller = TextEditingController();
  final doctorFeedBackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer2<HTMLDataNotifier, DoctorFeedbackNotifier>(
      builder: (context, provider, provider2, _) {
        htmlDataNotifier = provider;
        this.provider = provider2;
        return ModalProgressHUD(
          inAsyncCall: htmlDataNotifier.isLoading,
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
                            ]),
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
                            doctorFeedBack(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            uploadFilesButton(context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            htmlDataNotifier.htmlResponseMessage !=
                                    'No_Prescription_report_fount'
                                ? addedPrescription(context)
                                : Container(),
                            htmlDataNotifier.htmlResponseMessage !=
                                    'No_Prescription_report_fount'
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  )
                                : Container(),
                            uploadedImage(context),
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
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.patientName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          // SizedBox(
          //   height: 25,
          //   child: OutlinedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => AddPrescription(
          //             patientId: widget.patientId,
          //           ),
          //         ),
          //       );
          //     },
          //     style: ButtonStyle(
          //       side: MaterialStateProperty.all(
          //         const BorderSide(
          //           color: Colors.white,
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
          //       'Add Prescription',
          //       style: TextStyle(
          //         fontSize: 10,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
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
              label: const Text('Booking Date'),
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
            controller: bloodpressureController,
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
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: diabetesController,
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

  Widget temperatureAndHeartBeat(context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: temperatureController,
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
              label: const FittedBox(
                child: FittedBox(child: Text('Temp')),
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
          width: 15,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: spo2Controller,
            // obscureText: _isObscure1,
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                borderSide: const BorderSide(),
              ),
              label: const Text('SPO2'),
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
      enabled: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(),
        ),
        label: const Text('Pulse Rate'),
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
                style: TextStyle(color: Colors.white),
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
        //     enabled: false,
        //     decoration: InputDecoration(
        //       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        //       fillColor: Colors.white,
        //       filled: true,
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         borderSide: const BorderSide(),
        //       ),
        //       label: const Text('Pulse Rate'),
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
            controller: weightController,
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
              label: const FittedBox(
                child: FittedBox(child: Text('Height')),
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
          width: 15,
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            // validator: validateConfirmPassword,
            controller: weightController,
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
              label: const Text('Weight'),
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
    // addPatientInfoNotifier =
    //     Provider.of<AddPatientInfoNotifier?>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              style: getButtonStyle(context),
              onPressed: () async {
                if (doctorFeedBackController.text.isNotEmpty) {
                  provider.doctorFeedback(
                    widget.patientId,
                    doctorFeedBackController.text,
                    _image1,
                    _image!,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter FeedBack')));
                }
              },
              child: Text(
                'Done',
                textAlign: TextAlign.center,
                style: TextButtonStyle(context),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 45,
        //   width: 150,
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
        //       'Service Done',
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //         color: Color(0xff6EA7FA),
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(
          width: 20,
        ),
        FittedBox(
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextButtonStyle(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget doctorFeedBack(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: doctorFeedBackController,
      // obscureText: _isObscure1,
      maxLines: 5,
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
        label: const Text('Doctor Feedback'),
      ),
    );
  }

  Widget uploadFiles(context) {
    return Row(
      children: [
        _image!.isNotEmpty
            ? Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  margin: const EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _image!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          _image!.isNotEmpty
                              ? Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(File(_image1[index])),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Container(),
                          Positioned(
                            right: 10,
                            top: 5,
                            child: InkWell(
                              onTap: () => {
                                setState(() {
                                  _image!.removeAt(index);
                                })
                              },
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            : Container(),
        InkWell(
          onTap: () {
            _imgFromGallery();
            //_showPicker(context);
          },
          //  pickImages,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 0),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            margin: _image!.isEmpty ? null : const EdgeInsets.only(left: 10.0),
            child: const Center(
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget uploadFilesButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          child: const Text('Upload Image'),
          onPressed: () {
            //_imgFromGallery();
            _showPicker(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('Add Prescription'),
          onPressed: () async {
            await generateExampleDocument();
            String refresh = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPrescription(
                  patientId: widget.patientId,
                ),
              ),
            ).then((val) => val ? htmlApiHit() : null);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget addedPrescription(context) {
    return ListTile(
      leading: const Icon(
        Icons.picture_as_pdf,
        color: Colors.blueAccent,
      ),
      title: const Text('prescription.pdf'),
      onTap: () async {
        await generateExampleDocument();
        print(htmlDataNotifier.htmlResponseClass);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(
              file: generatedPdfFilePath!,
            ),
          ),
        );
      },
    );
  }

  Widget uploadedImage(context) {
    return _image1.isEmpty
        ? Container()
        : GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
            ),
            itemCount: _image1.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageLocalViewer(image: File(_image1[index]))));
                },
                child: Stack(
                  children: [
                    _image1.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(File(_image1[index])),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        onTap: () => {
                          setState(() {
                            _image1.removeAt(index);
                          })
                        },
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
