import 'dart:io';

import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/editManagePrescription/editManagePrescriptionNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getManagePrescription/getManagePrescriptionNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditManagePrescription extends StatefulWidget {
  const EditManagePrescription({Key? key}) : super(key: key);

  @override
  State<EditManagePrescription> createState() => _EditManagePrescriptionState();
}

class _EditManagePrescriptionState extends State<EditManagePrescription> {
  EditPrescriptionTemplateNotifier editPrescriptionTemplateNotifier =
      EditPrescriptionTemplateNotifier();
  GetManagePrescriptionListNotifier getManagePrescriptionListNotifier =
      GetManagePrescriptionListNotifier();
  final _key = GlobalKey<FormState>();

  File? _image;
  String fileName = '';
  var imagePath;
  int doctorId = 0;
  String clinicName = '';
  String clinicAddress = '';
  String clinicLogo = '';
  String clinicContact = '';
  int clinicPrescriptionId = 0;

  bool _isObscure = true;
  bool _isObscure1 = true;
  final clinicNameController = TextEditingController();
  final clinicContactController = TextEditingController();
  final addressController = TextEditingController();

  _imgFromCamera() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
      fileName = image.path.split('/').last;
      imagePath = image.path;
    });
  }

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
      fileName = image.path.split('/').last;
      imagePath = image.path;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Hooiooioooiii');
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
        Future.delayed(Duration.zero, () {
          getManagePrescriptionListNotifier
              .getManagePrescription(doctorId)
              .then((value) {
            for (int i = 0;
                i <
                    getManagePrescriptionListNotifier
                        .getPrescriptionClass.length;
                i++) {
              clinicNameController.text = getManagePrescriptionListNotifier
                  .getPrescriptionClass[i].clinicName!;
              addressController.text = getManagePrescriptionListNotifier
                  .getPrescriptionClass[i].clinicAddress!;
              clinicContactController.text = getManagePrescriptionListNotifier
                  .getPrescriptionClass[i].clinicContactNumber!;
              clinicLogo = getManagePrescriptionListNotifier
                  .getPrescriptionClass[i].clinicLogo!;
              clinicPrescriptionId =
                  getManagePrescriptionListNotifier.getPrescriptionClass[i].id!;
            }
          });
          getManagePrescriptionListNotifier.notifyListeners();
        });
      });
    });
    // MySharedPreferences.instance
    //     .getDoctorClinicName('doctorClinicName')
    //     .then((value) {
    //   setState(() {
    //     clinicName = value;
    //     print(clinicName);
    //     clinicNameController.text = clinicName;
    //   });
    // });
    // MySharedPreferences.instance
    //     .getDoctorClinicPrescriptionAddress('doctorClinicAddress')
    //     .then((value) {
    //   setState(() {
    //     clinicAddress = value;
    //     print(clinicAddress);
    //     addressController.text = clinicAddress;
    //   });
    // });
    // MySharedPreferences.instance
    //     .getDoctorClinicContact('doctorClinicContact')
    //     .then((value) {
    //   setState(() {
    //     clinicContact = value.toString();
    //     print(clinicContact);
    //     clinicContactController.text =
    //         clinicContact == '0' ? '' : clinicContact;
    //   });
    // });
    // MySharedPreferences.instance
    //     .getDoctorClinicPrescriptionId('doctorPrescriptionId')
    //     .then((value) {
    //   setState(() {
    //     clinicPrescriptionId = value.toString();
    //     print(clinicPrescriptionId);
    //   });
    // });
    // MySharedPreferences.instance
    //     .getDoctorClinicLogo('doctorClinicLogo')
    //     .then((value) {
    //   setState(() {
    //     clinicLogo = value;
    //     print(clinicLogo);
    //   });
    // });
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
    return Consumer<GetManagePrescriptionListNotifier>(
      builder: (context, provider, _) {
        getManagePrescriptionListNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image(
              image: const AssetImage('assets/dashboardmain.png'),
              fit: BoxFit.fill,
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height * 0.35
                      : MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),
            Form(
              key: _key,
              child: imageAndTextField(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, bottom: 10, left: 5.0, right: 15.0),
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
            'Manage Prescription',
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

  Widget imageAndTextField(context) {
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
                'Manage Prescription',
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
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                color: _image != null
                                    ? Colors.white
                                    : const Color(0xff6BA3F9),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                    )
                                  : clinicLogo != ''
                                      ? Image.network(
                                          DataConstants.LIVE_BASE_URL +
                                              '/' +
                                              clinicLogo,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        )
                                      : const Icon(
                                          Icons.camera_alt,
                                          color: Colors.black,
                                        ),
                            ),
                          ),
                          _image != null
                              ? Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: const Color(0xff619AFF),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: Color(0xff619AFF),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateText,
                    controller: clinicNameController,
                    // obscureText: _isObscure1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Clinic Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateNumber,
                    controller: clinicContactController,
                    // obscureText: _isObscure1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Clinic Contact No'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateAddress,
                    controller: addressController,
                    // obscureText: _isObscure1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 3,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      fillColor: Colors.white,
                      filled: true,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text(
                        'Address',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: 180,
                      height: 50,
                      child: ElevatedButton(
                        style: getButtonStyle(context),
                        onPressed: () {
                          print(clinicNameController.text);
                          print(clinicContactController.text);
                          print(addressController.text);
                          print(clinicPrescriptionId);
                          print(fileName.toString());
                          editPrescriptionTemplateNotifier
                              .editPrescriptionTemplate(
                            clinicPrescriptionId,
                            clinicNameController.text,
                            int.parse(clinicContactController.text),
                            addressController.text,
                            imagePath.toString(),
                            fileName,
                          );
                        },
                        child: Text(
                          'Update',
                          style: TextButtonStyle(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
