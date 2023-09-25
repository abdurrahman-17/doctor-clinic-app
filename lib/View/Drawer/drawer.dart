import 'package:doctor_clinic_token_app/View/AbouUs/aboutUs.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/time_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/token_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Doctor%20List/doctor_list.dart';
import 'package:doctor_clinic_token_app/View/Edit%20Doctor%20Profile/editPrifileDrawer.dart';
import 'package:doctor_clinic_token_app/View/Edit%20Staff/editStaff.dart';
import 'package:doctor_clinic_token_app/View/List%20Of%20Availability/list_availability.dart';
import 'package:doctor_clinic_token_app/View/ListOfAppointment/listOfAppointment.dart';
import 'package:doctor_clinic_token_app/View/ManageMedicines/ManageBrand/manageBrand.dart';
import 'package:doctor_clinic_token_app/View/ManageMedicines/ManageCategory/manageCategory.dart';
import 'package:doctor_clinic_token_app/View/ManageMedicines/ManageUnit/manageUnit.dart';
import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/View/ManagePrescription/editManagePrescription.dart';
import 'package:doctor_clinic_token_app/View/ManagePrescription/managePrescription.dart';
import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/View/PatientList/PatientList.dart';
import 'package:doctor_clinic_token_app/View/Staff%20List/staffList.dart';
import 'package:doctor_clinic_token_app/View/TermsCondition/termsAndCondition.dart';
import 'package:doctor_clinic_token_app/View/editUserDoctor/editUserDoctor.dart';
import 'package:doctor_clinic_token_app/View/login/login.dart';
import 'package:doctor_clinic_token_app/View/privacyPolicy/privacyPolicy.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String userEmail = '';
  String userName = '';
  String phNumber = '';
  String gender = '';
  String education = '';
  String specialization = '';
  String address = '';
  String about = '';
  int experience = 0;
  int patientAttend = 0;
  int userId = 0;
  int role = 0;
  String licenseNo = '';
  String pathImage = '';
  int scheduleType = 0;
  int prescriptionStatus = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        userId = value;
        print(userId);
      });
    });
    MySharedPreferences.instance.getDoctorEmail('doctorEmail').then((value) {
      setState(() {
        userEmail = value;
        print(userEmail);
      });
    });
    MySharedPreferences.instance.getDoctorName('doctorName').then((value) {
      setState(() {
        userName = value;
        print(userName);
      });
    });
    MySharedPreferences.instance.getDoctorAbout('doctorAbout').then((value) {
      setState(() {
        about = value;
        print(about);
      });
    });
    MySharedPreferences.instance
        .getDoctorExperience('doctorExperience')
        .then((value) {
      setState(() {
        experience = value;
        print(experience);
      });
    });
    MySharedPreferences.instance
        .getDoctorSpecialist('doctorSpecialist')
        .then((value) {
      setState(() {
        specialization = value;
        print(userName);
      });
    });
    MySharedPreferences.instance
        .getDoctorPatientAttend('doctorPatientAttend')
        .then((value) {
      setState(() {
        patientAttend = value;
        print(patientAttend);
      });
    });
    MySharedPreferences.instance.getDoctorPhone('doctorPhone').then((value) {
      setState(() {
        phNumber = value;
        print(phNumber);
      });
    });
    MySharedPreferences.instance.getGender('doctorGender').then((value) {
      setState(() {
        gender = value;
        print(gender);
      });
    });
    MySharedPreferences.instance.getEducation('doctorEducation').then((value) {
      setState(() {
        education = value;
        print(education);
      });
    });
    MySharedPreferences.instance.getAddress('doctorAddress').then((value) {
      setState(() {
        address = value;
        print(userName);
      });
    });
    MySharedPreferences.instance.getImage('doctorImage').then((value) {
      setState(() {
        pathImage = value;
        print(pathImage);
      });
    });
    MySharedPreferences.instance.getRole('doctorRole').then((value) {
      setState(() {
        role = value;
        print(role);
      });
    });
    MySharedPreferences.instance.getLicenseNo('doctorLicenseNo').then((value) {
      setState(() {
        licenseNo = value;
        print(role);
      });
    });
    MySharedPreferences.instance
        .getDoctorScheduleType('doctorScheduleType')
        .then((value) {
      setState(() {
        scheduleType = value;
        print(scheduleType);
      });
    });
    MySharedPreferences.instance
        .getPrescriptionStatus('doctorPrescriptionStatus')
        .then((value) {
      setState(() {
        prescriptionStatus = value;
        print(prescriptionStatus);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        role == 2
                            ? EditStaff(
                                staffId: userId.toString(),
                                fullName: userName,
                                email: userEmail,
                                mobNumber: phNumber,
                                address: address,
                                pathImage: pathImage,
                              )
                            : role == 1
                                ? EditDrawerProfile(
                                    userId: userId.toString(),
                                    fullName: userName,
                                    email: userEmail,
                                    mobNumber: phNumber,
                                    gender: gender,
                                    license: licenseNo,
                                    education: education,
                                    specialization: specialization,
                                    address: address,
                                    about: about,
                                    experience: experience.toString(),
                                    patientAttend: patientAttend.toString(),
                                    pathImage: pathImage,
                                  )
                                : EditUserDoctor(
                                    userId: userId.toString(),
                                    fullName: userName,
                                    email: userEmail,
                                    mobNumber: phNumber,
                                    gender: gender,
                                    license: licenseNo,
                                    education: education,
                                    specialization: specialization,
                                    address: address,
                                    about: about,
                                    experience: experience.toString(),
                                    patientAttend: patientAttend.toString(),
                                    pathImage: pathImage,
                                  ),
                  ),
                );
              },
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xffD3D3D3),
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: pathImage != 'null'
                              ? Image.network(
                                  DataConstants.LIVE_BASE_URL + '/' + pathImage,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (context, widget, event) {
                                    if (event == null) return widget;

                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                )
                              : const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FittedBox(
                        child: Text(
                          role == 2
                              ? userName + ' '
                              : 'Dr. ' + userName + ' ' + education,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(userEmail),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  role == 1 || role == 2
                      ? Container()
                      : ListTile(
                          leading: const FaIcon(
                            FontAwesomeIcons.fileMedical,
                            size: 19,
                            color: Color(0xff5A95FD),
                            textDirection: TextDirection.rtl,
                          ),
                          title: const Text(
                            'Manage Prescription',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        prescriptionStatus == 1
                                            ? const EditManagePrescription()
                                            : const ManagePrescription(),
                              ),
                            );
                          },
                        ),
                  role == 1 || role == 2
                      ? Container()
                      : ExpansionTile(
                          leading: const FaIcon(
                            FontAwesomeIcons.prescriptionBottleMedical,
                            color: Color(0xff5A95FD),
                            size: 19,
                            textDirection: TextDirection.rtl,
                          ),
                          title: const Text(
                            'Medicine',
                          ),
                          children: <Widget>[
                            ListTile(
                              leading: const FaIcon(
                                FontAwesomeIcons.pills,
                                size: 19,
                                color: Color(0xff5A95FD),
                                textDirection: TextDirection.rtl,
                              ),
                              title: const Text(
                                'Manage Medicine',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const MedicineList(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const FaIcon(
                                FontAwesomeIcons.award,
                                size: 19,
                                color: Color(0xff5A95FD),
                                textDirection: TextDirection.rtl,
                              ),
                              title: const Text(
                                'Manage Brand',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const ManageBrand(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const FaIcon(
                                FontAwesomeIcons.cubesStacked,
                                size: 19,
                                color: Color(0xff5A95FD),
                                textDirection: TextDirection.rtl,
                              ),
                              title: const Text(
                                'Manage Category',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const ManageCategory(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const FaIcon(
                                FontAwesomeIcons.weightScale,
                                size: 19,
                                color: Color(0xff5A95FD),
                                textDirection: TextDirection.rtl,
                              ),
                              title: const Text(
                                'Manage Measurment Unit',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const ManageContentMeasurement(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  // role == 1 || role == 2
                  //     ? Container()
                  //     : ListTile(
                  //         leading: const FaIcon(
                  //           FontAwesomeIcons.pills,
                  //           size: 18,
                  //           color: Color(0xff5A95FD),
                  //         ),
                  //         title: const Text(
                  //           'Manage Medicine',
                  //         ),
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             PageRouteBuilder(
                  //               pageBuilder:
                  //                   (context, animation, secondaryAnimation) =>
                  //                       MedicineList(),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  role == 1 || role == 2
                      ? Container()
                      : ListTile(
                          leading: const Icon(
                            Icons.local_hospital_outlined,
                            color: Color(0xff5A95FD),
                          ),
                          title: const Text(
                            'Manage Doctor',
                            style: TextStyle(),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const DoctorList(),
                              ),
                            );
                          },
                        ),
                  role == 2
                      ? Container()
                      : ListTile(
                          leading: const Icon(
                            Icons.group_outlined,
                            color: Color(0xff5A95FD),
                          ),
                          title: const Text(
                            'Manage Nurse',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const StaffList(),
                              ),
                            );
                          },
                        ),
                  ListTile(
                    leading: const Icon(
                      Icons.personal_injury,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'Manage Patients',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Patientlist(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.book_online,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'Appointments',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ListOfAppointment(selectedPage: 0),
                        ),
                      );
                    },
                  ),
                  role == 2
                      ? Container()
                      : ExpansionTile(
                          leading: const Icon(
                            Icons.event_available,
                            color: Color(0xff5A95FD),
                          ),
                          title: const Text(
                            'Availability',
                          ),
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(
                                Icons.add_circle_outline,
                                color: Color(0xff5A95FD),
                              ),
                              title: const Text(
                                'Add Avalability',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        scheduleType == 1
                                            ? const TimeTabScreen()
                                            : const TokenTabScreen(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.list,
                                color: Color(0xff5A95FD),
                              ),
                              title: const Text(
                                'My Availability',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const ListOfAVilability(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  role == 2
                      ? Container()
                      : ListTile(
                          leading: const Icon(
                            Icons.directions_walk,
                            color: Color(0xff5A95FD),
                          ),
                          title: const Text(
                            'Out of Office',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const OutOfOffice(),
                              ),
                            );
                          },
                        ),
                  ListTile(
                    leading: const Icon(
                      Icons.error_outline,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'Terms & Condition',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Terms_And_Condition(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'Privacy Policy',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Privacy_Policy(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.help_outline_outlined,
                      color: Color(0xff5A95FD),
                    ),
                    title: const Text(
                      'About Us',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AboutUs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      MySharedPreferences.instance.removeAll();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
