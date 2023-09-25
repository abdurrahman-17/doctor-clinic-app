import 'package:doctor_clinic_token_app/View/Add%20Availability/time_and_token_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/time_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Availability/token_tab_screen.dart';
import 'package:doctor_clinic_token_app/View/Add%20Info%20Of%20Patient/addinfopatient.dart';
import 'package:doctor_clinic_token_app/View/Add%20Staff/addStaff.dart';
import 'package:doctor_clinic_token_app/View/Change%20New%20Password/change_new_password.dart';
import 'package:doctor_clinic_token_app/View/Dashboard/new_dashboard_screen.dart';
import 'package:doctor_clinic_token_app/View/Doctor%20List/doctor_list.dart';
import 'package:doctor_clinic_token_app/View/Edit%20Doctor%20Profile/edit_profile.dart';
import 'package:doctor_clinic_token_app/View/Edit%20Staff/editStaff.dart';
import 'package:doctor_clinic_token_app/View/ForgetScreen/forget_screen.dart';
import 'package:doctor_clinic_token_app/View/Health%20Record/health_records.dart';
import 'package:doctor_clinic_token_app/View/List%20Of%20Availability/list_availability.dart';
import 'package:doctor_clinic_token_app/View/ListOfAppointment/listOfAppointment.dart';
import 'package:doctor_clinic_token_app/View/Notification/notification.dart';
import 'package:doctor_clinic_token_app/View/OTP%20Verification/otp_verificationscreen.dart';
import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/patient_data.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Info/patient_info.dart';
import 'package:doctor_clinic_token_app/View/Pharmacy/pharmacy.dart';
import 'package:doctor_clinic_token_app/View/Prescription/prescription.dart';
import 'package:doctor_clinic_token_app/View/Reappointment/reappointment_screen.dart';
import 'package:doctor_clinic_token_app/View/Staff%20List/staffList.dart';
import 'package:doctor_clinic_token_app/View/Todays%20Consultancy/checkedin_screen.dart';
import 'package:doctor_clinic_token_app/View/Todays%20Consultancy/checkin_and_doneappointment_tabbar.dart';
import 'package:doctor_clinic_token_app/View/Todays%20Consultancy/done_appointment_screen.dart';
import 'package:doctor_clinic_token_app/View/login/login.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LOGIN:
        return MaterialPageRoute(
            builder: (BuildContext context) => Login(), settings: settings);
      case RoutePaths.Dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => DashboardScreens(),
            settings: settings);
      case RoutePaths.FORGOT:
        return MaterialPageRoute(
            builder: (BuildContext context) => ForgetScreen(),
            settings: settings);
      case RoutePaths.OTPVERIFICATION:
        return MaterialPageRoute(
            builder: (BuildContext context) => OtpVerification(),
            settings: settings);
      case RoutePaths.CHANGENEWPASSWORD:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChangeNewPassword(),
            settings: settings);
      case RoutePaths.TimeAndToken:
        return MaterialPageRoute(
            builder: (BuildContext context) => TimeAndTokenScreen(),
            settings: settings);
      case RoutePaths.TimeBased:
        return MaterialPageRoute(
            builder: (BuildContext context) => TimeTabScreen(),
            settings: settings);
      case RoutePaths.TokenBased:
        return MaterialPageRoute(
            builder: (BuildContext context) => TokenTabScreen(),
            settings: settings);
      case RoutePaths.AddInfo:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddInfoPatient(),
            settings: settings);
      case RoutePaths.HealthRecord:
        return MaterialPageRoute(
            builder: (BuildContext context) => Health_Record(),
            settings: settings);
      case RoutePaths.ListAvailability:
        return MaterialPageRoute(
            builder: (BuildContext context) => ListOfAVilability(),
            settings: settings);
      case RoutePaths.PatientData:
        return MaterialPageRoute(
            builder: (BuildContext context) => PatientData(),
            settings: settings);
      case RoutePaths.PatientInfo:
        return MaterialPageRoute(
            builder: (BuildContext context) => PatientInfo(),
            settings: settings);
      case RoutePaths.Pharmacy:
        return MaterialPageRoute(
            builder: (BuildContext context) => Pharmacy(), settings: settings);
      case RoutePaths.Prescription:
        return MaterialPageRoute(
            builder: (BuildContext context) => Prescription(),
            settings: settings);
      case RoutePaths.ReAppointment:
        return MaterialPageRoute(
            builder: (BuildContext context) => ReAppointmentScreen(),
            settings: settings);
      case RoutePaths.CheckedInAndDone:
        return MaterialPageRoute(
            builder: (BuildContext context) => CheckInAndDoneAppointment(),
            settings: settings);
      case RoutePaths.CheckedIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => CheckedInScreen(),
            settings: settings);
      case RoutePaths.DoneAppointment:
        return MaterialPageRoute(
            builder: (BuildContext context) => DoneAppointment(),
            settings: settings);
      case RoutePaths.DoctorList:
        return MaterialPageRoute(
            builder: (BuildContext context) => DoctorList(),
            settings: settings);
      case RoutePaths.Notification_New:
        return MaterialPageRoute(
            builder: (BuildContext context) => NotificationScreen(),
            settings: settings);
      case RoutePaths.EditAdminProfile:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditProfile(
                  userId: '',
                  gender: '',
                  patientAttend: '',
                  experience: '',
                  education: '',
                  specialization: '',
                  about: '',
                  fullName: '',
                  mobNumber: '',
                  email: '',
                  address: '',
                  pathImage: '',
                  licenseNo: '',
                ),
            settings: settings);
      case RoutePaths.StaffList:
        return MaterialPageRoute(
            builder: (BuildContext context) => StaffList(), settings: settings);
      case RoutePaths.EditStaffList:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditStaff(
                  staffId: '',
                  address: '',
                  email: '',
                  fullName: '',
                  mobNumber: '',
                  pathImage: '',
                ),
            settings: settings);
      case RoutePaths.AddStaffList:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddStaff(), settings: settings);
      case RoutePaths.OutOfOffice:
        return MaterialPageRoute(
            builder: (BuildContext context) => OutOfOffice(),
            settings: settings);
      case RoutePaths.ListOfAppointment:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ListOfAppointment(selectedPage: 0),
            settings: settings);
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
