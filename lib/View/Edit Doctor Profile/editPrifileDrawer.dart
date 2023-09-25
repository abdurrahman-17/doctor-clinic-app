import 'dart:io';

import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDoctorProfileNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDrawerDoctorProfileNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditDrawerProfile extends StatefulWidget {
  String userId;
  String fullName;
  String email;
  String mobNumber;
  String gender;
  String license;
  String education;
  String specialization;
  String address;
  String about;
  String experience;
  String patientAttend;
  String pathImage;

  EditDrawerProfile({
    Key? key,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.mobNumber,
    required this.gender,
    required this.license,
    required this.education,
    required this.specialization,
    required this.address,
    required this.about,
    required this.experience,
    required this.patientAttend,
    required this.pathImage,
  }) : super(key: key);

  @override
  _EditDrawerProfileState createState() => _EditDrawerProfileState();
}

class _EditDrawerProfileState extends State<EditDrawerProfile> {
  UpdateDrawerDoctorProfileNotifier updateDrawerDoctorProfileNotifier =
      UpdateDrawerDoctorProfileNotifier();
  final _key = GlobalKey<FormState>();
  var doctorNames = "";

  File? _image;
  String fileName = '';
  var imagePath;

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

  String? dropDownGenderValue;
  String? Gender;

  var slotGenderItems = [
    'Male',
    'Female',
  ];

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
    MySharedPreferences.instance.getDoctorName('doctorName').then((value) {
      setState(() {
        doctorNames = value;
        fullNameController.text = widget.fullName;
        emailController.text = widget.email;
        mobileController.text = widget.mobNumber;
        genderController.text = widget.gender;
        licenseController.text = widget.license;
        educationController.text = widget.education;
        specializationController.text = widget.specialization;
        addressController.text = widget.address;
        aboutController.text = widget.about;
        experienceController.text = widget.experience;
        patientController.text = widget.patientAttend;
        print(widget.gender);
        if (widget.gender != 'null') {
          dropDownGenderValue = widget.gender == 'M' || widget.gender == 'Male'
              ? 'Male'
              : widget.gender == 'F' || widget.gender == 'Female'
                  ? 'Female'
                  : 'Others';
          Gender = widget.gender;
        }
      });
    });
  }

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final genderController = TextEditingController();
  final licenseController = TextEditingController();
  final educationController = TextEditingController();
  final specializationController = TextEditingController();
  final addressController = TextEditingController();
  final aboutController = TextEditingController();
  final experienceController = TextEditingController();
  final patientController = TextEditingController();

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
            title: new Text(
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
    return Consumer<UpdateDoctorProfileNotifier>(
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
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
          );
        });
  }

  Widget buildBody(context) {
    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/dashboardmain.png'),
          fit: BoxFit.fill,
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.35
              : MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
        ),
        Form(key: _key, child: imageAndTextField(context)),
      ],
    );
  }

  Widget imageAndTextField(context) {
    updateDrawerDoctorProfileNotifier =
        Provider.of<UpdateDrawerDoctorProfileNotifier>(context, listen: false);
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
                'Edit Profile',
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
                                  : widget.pathImage != 'null'
                                      ? Image.network(
                                          DataConstants.LIVE_BASE_URL +
                                              '/' +
                                              widget.pathImage,
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: const Color(0xff619AFF),
                                            width: 2,
                                          )),
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
                    controller: fullNameController,
                    // obscureText: _isObscure1,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Full Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    controller: emailController,
                    enabled: false,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    // obscureText: _isObscure1,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Email'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateNumber,
                    controller: mobileController,
                    maxLength: 10,
                    // obscureText: _isObscure1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Mobile Number'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade600,
                        width: 1.1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('Gender'),
                          value: dropDownGenderValue,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          onChanged: (String? value) {
                            setState(() {
                              dropDownGenderValue = value;
                              if (value == 'Male') {
                                Gender = 'M';
                                print(Gender);
                              } else if (value == 'Female') {
                                Gender = 'F';
                                print(Gender);
                              } else {
                                Gender = 'Other';
                                print(Gender);
                              }
                            });
                          },
                          items: slotGenderItems.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateText,
                    controller: licenseController,
                    // obscureText: _isObscure1,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('License No'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateText,
                    controller: educationController,
                    // obscureText: _isObscure1,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Education'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateText,
                    controller: specializationController,
                    // obscureText: _isObscure1,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Specialization'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateAddress,
                    controller: addressController,
                    // obscureText: _isObscure1,
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
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateText,
                    controller: aboutController,
                    // obscureText: _isObscure1,
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
                      label: const Text('About'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          validator: validateText,
                          controller: experienceController,
                          // obscureText: _isObscure1,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            label: const Text('Experience'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextFormField(
                          validator: validateText,
                          controller: patientController,
                          // obscureText: _isObscure1,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                            label: const Text('Total Patient'),
                          ),
                        ),
                      ),
                    ],
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
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            updateDrawerDoctorProfileNotifier
                                .updateDrawerDoctorProfileInfo(
                              int.parse(widget.userId),
                              fullNameController.text,
                              emailController.text,
                              imagePath.toString(),
                              fileName.toString(),
                              int.parse(mobileController.text),
                              Gender.toString(),
                              licenseController.text == widget.license
                                  ? ''
                                  : licenseController.text,
                              educationController.text,
                              specializationController.text,
                              addressController.text,
                              aboutController.text,
                              int.parse(experienceController.text),
                              int.parse(patientController.text),
                            );
                          }
                          //Navigator.pushNamed(context, RoutePaths.PatientData);
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
}
