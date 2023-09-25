import 'dart:io';

import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/View/ImageView/imageView.dart';
import 'package:doctor_clinic_token_app/View/pdfViewer/pdfViewer.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/htmlData/htmlDataNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/prescription/prescriptionNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Prescription extends StatefulWidget {
  final appointmentData;

  const Prescription({this.appointmentData, Key? key}) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  AppointmentDetailNotifier provider = AppointmentDetailNotifier();
  HTMLDataNotifier htmlDataNotifier = HTMLDataNotifier();

  String name = "";
  String drName = "";
  String bookedDate = "";
  String pulseRate = "";
  String temperature = "";
  String bloodPressure = "";
  String diabetes = "";
  String weight = "";
  String height = "";
  String spo2 = "";
  String healthIssue = "";
  String doctorFeedback = "";
  List itemLength = [];
  String? savePath;
  File? generatedPdfFilePath;
  String generatedPdfFilePathLast = '';

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
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      provider.appointmentDetail(widget.appointmentData).then((value) {
        provider.notifyListeners();
        for (int i = 0; i < provider.appointmentDetailClass.length; i++) {
          name = provider.appointmentDetailClass[i].patientName.toString();
          drName = provider.appointmentDetailClass[i].doctorName.toString();
          //dateFormate Change
          var inputFormat = DateFormat('yyyy-MM-dd');
          var inputDate = inputFormat
              .parse(provider.appointmentDetailClass[i].date.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          final outputDate = outputFormat.format(inputDate).toLowerCase();
          bookedDate = outputDate;
          pulseRate = provider.appointmentDetailClass[i].pulseRate == null
              ? '0'
              : provider.appointmentDetailClass[i].pulseRate.toString();
          healthIssue =
              provider.appointmentDetailClass[i].description.toString();
          temperature = provider.appointmentDetailClass[i].temperature == null
              ? '0'
              : provider.appointmentDetailClass[i].temperature.toString();
          bloodPressure =
              provider.appointmentDetailClass[i].bloodPressure == null
                  ? '0'
                  : provider.appointmentDetailClass[i].bloodPressure.toString();
          diabetes = provider.appointmentDetailClass[i].diabetes == null
              ? '0'
              : provider.appointmentDetailClass[i].diabetes.toString();
          weight = provider.appointmentDetailClass[i].weight == null
              ? '0'
              : provider.appointmentDetailClass[i].weight.toString();
          height = provider.appointmentDetailClass[i].height == null
              ? '0'
              : provider.appointmentDetailClass[i].height.toString();
          spo2 = provider.appointmentDetailClass[i].spo2 == null
              ? '0'
              : provider.appointmentDetailClass[i].spo2.toString();
          doctorFeedback =
              provider.appointmentDetailClass[i].feedback.toString();
          itemLength = provider.appointmentDetailClass[i].prescription!;
          print(itemLength);
          setState(() {
            bookedDateController.text = bookedDate;
            healthIssueController.text = healthIssue.toString();
            bloodpressureController.text = bloodPressure.toString();
            diabetesController.text = diabetes.toString();
            temperatureController.text = temperature.toString();
            heightController.text = height.toString();
            weightController.text = weight.toString();
            pulseRateController.text = pulseRate.toString();
            spo2Controller.text = spo2.toString();
            healthIssueController.text = healthIssue.toString();
            doctorFeedBackController.text = doctorFeedback.toString();
          });
        }
      });
    });
    print('hello');
    print(widget.appointmentData);
    print('nice');
    htmlApiHit();
    super.initState();
  }

  htmlApiHit() async {
    await Future.delayed(Duration.zero, () {
      htmlDataNotifier.htmlResponse(widget.appointmentData);
    });
    print('3');
    generateExampleDocument();
    print('4');
  }

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
    generatedPdfFilePathLast = generatedPdfFile.path.split('/').last;
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
                          provider
                              .appointmentDetail(widget.appointmentData)
                              .then((value) {
                            provider.notifyListeners();
                            for (int i = 0;
                                i < provider.appointmentDetailClass.length;
                                i++) {
                              name = provider
                                  .appointmentDetailClass[i].patientName
                                  .toString();
                              drName = provider
                                  .appointmentDetailClass[i].doctorName
                                  .toString();
                              //dateFormate Change
                              var inputFormat = DateFormat('yyyy-MM-dd');
                              var inputDate = inputFormat.parse(provider
                                  .appointmentDetailClass[i].date
                                  .toString());
                              var outputFormat = DateFormat('dd-MM-yyyy');
                              final outputDate =
                                  outputFormat.format(inputDate).toLowerCase();
                              bookedDate = outputDate;
                              pulseRate = provider
                                  .appointmentDetailClass[i].pulseRate
                                  .toString();
                              healthIssue = provider
                                  .appointmentDetailClass[i].description
                                  .toString();
                              temperature = provider
                                  .appointmentDetailClass[i].temperature
                                  .toString();
                              bloodPressure = provider
                                  .appointmentDetailClass[i].bloodPressure
                                  .toString();
                              diabetes = provider
                                  .appointmentDetailClass[i].diabetes
                                  .toString();
                              weight = provider.appointmentDetailClass[i].weight
                                  .toString();
                              height = provider.appointmentDetailClass[i].height
                                  .toString();
                              spo2 = provider.appointmentDetailClass[i].spo2
                                  .toString();
                              doctorFeedback = provider
                                  .appointmentDetailClass[i].feedback
                                  .toString();
                              itemLength = provider
                                  .appointmentDetailClass[i].prescription!;
                              print(itemLength);
                              setState(() {
                                bookedDateController.text = bookedDate;
                                healthIssueController.text =
                                    healthIssue.toString();
                                bloodpressureController.text =
                                    bloodPressure.toString();
                                diabetesController.text = diabetes.toString();
                                temperatureController.text =
                                    temperature.toString();
                                heightController.text = height.toString();
                                weightController.text = weight.toString();
                                pulseRateController.text = pulseRate.toString();
                                spo2Controller.text = spo2.toString();
                                healthIssueController.text =
                                    healthIssue.toString();
                                doctorFeedBackController.text =
                                    doctorFeedback.toString();
                              });
                            }
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
    return Consumer<HTMLDataNotifier>(
      builder: (context, provider, _) {
        htmlDataNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xffF5F6FC),
              body: buildBody(context),
            ),
          ),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          buildBackgroundImage(context),
          buildColumn(context),
        ],
      ),
    );
  }

  Widget buildBackgroundImage(BuildContext context) {
    return Image(
      image: const AssetImage('assets/Home screen.png'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.height * 0.18
          : MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width,
    );
    // SvgPicture.asset('assets/images/BGn.svg',width: MediaQuery.of(context).size.width,);
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        backButton(context),
        buildPrescriptionContainer(context),
      ],
    );
  }

  Widget buildPrescriptionContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Doctor:  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          drName,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Booked Date:  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        bookedDate,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  pulseRateField(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  weightAndHeight(context),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  helathIssue(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  doctorFeedBack(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  htmlDataNotifier.htmlResponseMessage !=
                          'No_Prescription_report_fount'
                      ? addedPrescription(context)
                      : Container(),
                  uploadFiles(context),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        ],
      ),
    );
  }

  Widget buildDownloadImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 40,
        ),
        Text(
          'Download',
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Color(0xffA6A6A6)),
        ),
        Icon(
          Icons.download_outlined,
          color: Color(0xffA6A6A6),
        )
      ],
    );
  }

  Widget buildPrescriptionBy(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        Text(
          'Prescription',
          style: PrescriptionStyle(context),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'By Dr. Bellamy Nicholas',
          style: DoctorByName(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Heart surgen',
          style: PrescriptionSpecialist(context),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  Widget buildimage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/giphy.gif',
            image:
                'https://www.researchgate.net/profile/Sandra-Benavides/publication/228331607/figure/fig4/AS:667613038387209@1536182760366/Indicate-why-the-prescription-is-not-appropriate-as-written.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget buildDateandTime(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: const Offset(0, 2),
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'date and time',
                      style: DateContainerStyle(context),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  '30th September , 2022 ',
                  style: DateContainer1Style(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Your Appointment on 09:00 AM',
                  style: DateContainer1Style(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addedPrescription(context) {
    return Consumer<HTMLDataNotifier>(
      builder: (context, newProvider, _) {
        newProvider = htmlDataNotifier;
        return ModalProgressHUD(
          inAsyncCall: newProvider.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'E-Prescription:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.blueAccent,
                ),
                title: Text(generatedPdfFilePathLast),
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, bottom: 10, left: 25, top: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Back',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
                primary: const Color(0xff4889FD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
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
              label: const Text('BP'),
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
              label: const Text('Diabetes'),
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

  Widget pulseRateField(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: pulseRateController,
      // obscureText: _isObscure1,
      enabled: false,
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
                      '°C',
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
                borderRadius: BorderRadius.circular(10),
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
                      'BPM',
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

  Widget weightAndHeight(context) {
    return Row(
      children: [
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
                      'Kg',
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
            controller: heightController,
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
              label: const Text('Height'),
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
                      'Cm',
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

  Widget doctorFeedBack(context) {
    return TextFormField(
      // validator: validateConfirmPassword,
      controller: doctorFeedBackController,
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
        label: const Text('Doctor Feedback'),
      ),
    );
  }

  Widget uploadFiles(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attachments:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 120,
                child: itemLength.isEmpty
                    ? const Center(child: Text('No Attachment Added'))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: itemLength.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ImageViewer(
                                                  image: DataConstants
                                                          .LIVE_BASE_URL +
                                                      '/' +
                                                      itemLength[index])));
                                    },
                                    child: Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              DataConstants.LIVE_BASE_URL +
                                                  '/' +
                                                  itemLength[index]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ],
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
          const Text(
            'Appointment Detail\'s',
            style: TextStyle(
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
}
