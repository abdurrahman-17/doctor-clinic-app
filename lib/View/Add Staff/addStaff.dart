import 'dart:io';

import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/request_response/addstaff/addstaffNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({Key? key}) : super(key: key);

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  AddStaffNotifier addStaffNotifier = AddStaffNotifier();
  final _key = GlobalKey<FormState>();

  File? _image;
  String fileName = '';
  var imagePath;
  int doctorId = 0;

  bool _isObscure = true;
  bool _isObscure1 = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (formConfirmPassword!.isEmpty) {
      return "Password Is Required";
    }
    if (passwordController.text != confirmPasswordController.text) {
      return "Password Does Not Match";
    }
    return null;
  }

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
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {}
    return Consumer<AddStaffNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: buildBody(context),
        );
      },
    );
  }

  Widget buildBody(context) {
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
            Form(key: _key, child: imageAndTextField(context)),
          ],
        ),
      ),
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

  Widget imageAndTextField(context) {
    addStaffNotifier = Provider.of<AddStaffNotifier?>(context, listen: false)!;
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
                'Add Nurse',
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
                                        color: const Color(0xff619AFF),
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
                    controller: nameController,
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
                      label: const Text('Full Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    controller: emailController,
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
                      label: const Text('Email'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validatePassword,
                    controller: passwordController,
                    obscureText: _isObscure,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      label: const Text('Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   validator: validateConfirmPassword,
                  //   controller: confirmPasswordController,
                  //   obscureText: _isObscure1,
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   decoration: InputDecoration(
                  //     contentPadding:
                  //         const EdgeInsets.symmetric(horizontal: 20),
                  //     fillColor: Colors.white,
                  //     filled: true,
                  //     suffixIcon: Padding(
                  //       padding: const EdgeInsets.only(
                  //         right: 10,
                  //       ),
                  //       child: IconButton(
                  //         icon: Icon(_isObscure1
                  //             ? Icons.visibility
                  //             : Icons.visibility_off),
                  //         onPressed: () {
                  //           setState(() {
                  //             _isObscure1 = !_isObscure1;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: const BorderSide(),
                  //     ),
                  //     label: const Text('Confirm Password'),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  TextFormField(
                    validator: validateNumber,
                    controller: mobileNumberController,
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
                      label: const Text('Mobile Number'),
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
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            addStaffNotifier.addStaffInfo(
                              doctorId,
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              imagePath.toString(),
                              fileName.toString(),
                              int.parse(mobileNumberController.text),
                              addressController.text,
                            );
                          }
                          //Navigator.pushNamed(context, RoutePaths.PatientData);
                        },
                        child: Text(
                          'Create',
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
