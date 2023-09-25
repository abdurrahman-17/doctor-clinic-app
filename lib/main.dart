import 'dart:async';
import 'package:doctor_clinic_token_app/Router.dart';
import 'package:doctor_clinic_token_app/View/Dashboard/new_dashboard_screen.dart';
import 'package:doctor_clinic_token_app/View/login/login.dart';
import 'package:doctor_clinic_token_app/core/request_response/aboutUs/aboutUsNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addMedicine/addMedicineNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addMedicinePrescriptionInfo/addMedicinePrescriptionInfoNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addWalkinPatient/addWalkinPatientNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctor/adddoctorNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctorSchedule/addDoctorScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctorScheduleToken/addDoctorScheduleTokenNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDaysStatus/availabilityDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDelete/availabilityDeleteNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/changeAvailabilityScheduleConfirm/changeAvailabilityScheduleConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/changeAvailabilityScheduleType/changeAvailabilityScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/changenewpassword/changepasswordNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/deleteFullSchedule/deleteFullScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/deleteMedicine/deleteMedicineNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeave/doctorLeaveNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveConfirm/doctorLeaveConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveDays/doctorLeaveDaysNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorList/doctorlistNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorTimeLeave/doctorTimeLeaveNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorTimeLeaveConfirm/doctorTimeLeaveConfirmNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorfeedback/doctorfeedbackNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/editMedicines/editMedicineNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/editUserDoctor/editUserDoctorNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/emergencyAppointmentList/emergencyListNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/emergencyPatientFilter/emergencyPatientFilterNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getAllNotification/getAllNotificationNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getContentMeasurement/getContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getDoctorScheduleTime/getDoctorScheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getDoctorScheduleToken/getDoctorScheduleTokenNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicineCategory/getMedicineCategoryNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicineList/getMedicineListNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicinePrescriptionList/getMedicinePrescriptionListNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/graphWeek/graphWeekNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/htmlData/htmlDataNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/listOfPatient/listOfPatientNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/listofavailability/listofavailabilityNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/monthlyGraph/monthlyGraphNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/notification_Count/notification_Notifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/pieChart/pieChartNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/prescription/prescriptionNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/prescriptionUpdate/prescriptionUpdateNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/privacyPolicy/privacyPolicyNotidier.dart';
import 'package:doctor_clinic_token_app/core/request_response/readNotification/readNotificationNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/recordHistory/recordhistoryNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/recordHistoryFilter/recordHistoryFilterNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/registerPatientFilter/registerPatientFilterNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/registeredPatientFilter/registeredPatientFilterNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/registration/registrationNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/termsAndCondition/termsAndConditionNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/timedoctorschedule/timedoctorscheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/forgetpassword/forgetpasswordNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/login/loginNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/otpVerify/OtpVerifyNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayCheckIn/todaycheckinNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayConsulationCount/todayconsultationcountNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayDoneAppointment/todayDoneAppointmentNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayconsultation/todayconsultationNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/tokendoctorschedule/tokendoctorscheduleNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDoctorProfileNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDrawerDoctorProfileNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/updatePolicy/updatePolicyNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateStaffProfile/updateDrawerStaffProfile.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateStaffProfile/updateStaffProfileNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkInPatientFilter/walkInPatientFilterNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkedInPatientList/walkedInListNotifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/common/app_locator.dart';
import 'core/request_response/addstaff/addstaffNotifier.dart';
import 'core/request_response/brandNameList/brandNameListNotifier.dart';
import 'core/request_response/editManagePrescription/editManagePrescriptionNotifier.dart';
import 'core/request_response/getManagePrescription/getManagePrescriptionNotifier.dart';
import 'core/request_response/patientRegister/patientRegisterNotifier.dart';

void main() {
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    setUpRealLocator();
    FirebaseMessaging.onBackgroundMessage(backgroundhandler);
    runApp(MyApp());
  });
}

Future<void> backgroundhandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apiToken = '';

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = prefs.getString('doctorToken').toString();
      print('Hello');
      print(apiToken);
      print('Hi');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginNotifier()),
          ChangeNotifierProvider(create: (_) => ForgetPasswordNotifier()),
          ChangeNotifierProvider(create: (_) => OtpVerifyNotifier()),
          ChangeNotifierProvider(create: (_) => ChangePasswordNotifier()),
          ChangeNotifierProvider(create: (_) => TimeDoctorScheduleNotifier()),
          ChangeNotifierProvider(create: (_) => AddPatientInfoNotifier()),
          ChangeNotifierProvider(
              create: (_) => TodayConsultationCountNotifiers()),
          ChangeNotifierProvider(create: (_) => TodayCheckedInNotifier()),
          ChangeNotifierProvider(create: (_) => TokenDoctorScheduleNotifier()),
          ChangeNotifierProvider(create: (_) => ListOfAvailabilityNotifier()),
          ChangeNotifierProvider(create: (_) => AddDoctorNotifier()),
          ChangeNotifierProvider(create: (_) => AddStaffNotifier()),
          ChangeNotifierProvider(create: (_) => TodayConsultationNotifier()),
          ChangeNotifierProvider(create: (_) => TodayDoneAppointmentNotifier()),
          ChangeNotifierProvider(create: (_) => StaffListNotifier()),
          ChangeNotifierProvider(create: (_) => DoctorListNotifier()),
          ChangeNotifierProvider(create: (_) => RecordHistoryNotifier()),
          ChangeNotifierProvider(create: (_) => UpdateDoctorProfileNotifier()),
          ChangeNotifierProvider(create: (_) => UpdateStaffProfileNotifier()),
          ChangeNotifierProvider(create: (_) => ListOfPatientNotifier()),
          ChangeNotifierProvider(create: (_) => AboutUsNotifier()),
          ChangeNotifierProvider(create: (_) => PrivacyPolicyNotifier()),
          ChangeNotifierProvider(create: (_) => TermsAndCondition_Notifier()),
          ChangeNotifierProvider(create: (_) => RecordHistoryFilterNotifier()),
          ChangeNotifierProvider(create: (_) => RegisterNotifier()),
          ChangeNotifierProvider(create: (_) => DoctorFeedbackNotifier()),
          ChangeNotifierProvider(create: (_) => AppointmentDetailNotifier()),
          ChangeNotifierProvider(create: (_) => GraphWeekNotifier()),
          ChangeNotifierProvider(create: (_) => AddDoctorScheduleNotifier()),
          ChangeNotifierProvider(create: (_) => DoctorLeaveNotifier()),
          ChangeNotifierProvider(create: (_) => DoctorLeaveConfirmNotifier()),
          ChangeNotifierProvider(create: (_) => DoctorLeaveDaysNotifier()),
          ChangeNotifierProvider(create: (_) => DoctorTimeLeaveNotifier()),
          ChangeNotifierProvider(
              create: (_) => DoctorTimeLeaveConfirmNotifier()),
          ChangeNotifierProvider(
              create: (_) => AvailabilityDayStatusNotifier()),
          ChangeNotifierProvider(create: (_) => AvailabilityDeleteNotifier()),
          ChangeNotifierProvider(
              create: (_) => DoctorScheduleDayStatusNotifier()),
          ChangeNotifierProvider(create: (_) => GraphMonthNotifier()),
          ChangeNotifierProvider(
              create: (_) => AddDoctorScheduleTokenNotifier()),
          ChangeNotifierProvider(create: (_) => AddWalkinNotifier()),
          ChangeNotifierProvider(create: (_) => PieChartNotifier()),
          ChangeNotifierProvider(create: (_) => EmergencyListNotifier()),
          ChangeNotifierProvider(create: (_) => WalkedInPatientListNotifier()),
          ChangeNotifierProvider(create: (_) => DeleteAllScheduleNotifier()),
          ChangeNotifierProvider(
              create: (_) => ChangeAvailabilityScheduleNotifier()),
          ChangeNotifierProvider(
              create: (_) => ChangeAvailabilityScheduleConfirmNotifier()),
          ChangeNotifierProvider(
              create: (_) => WalkedInPatientFilterNotifier()),
          ChangeNotifierProvider(
              create: (_) => EmergencyPatientFilterNotifier()),
          ChangeNotifierProvider(create: (_) => PrescriptionUpdateNotifier()),
          ChangeNotifierProvider(
              create: (_) => RegisteredPatientFilterNotifier()),
          ChangeNotifierProvider(create: (_) => GetDoctorScheduleNotifier()),
          ChangeNotifierProvider(
              create: (_) => GetDoctorTokenScheduleNotifier()),
          ChangeNotifierProvider(create: (_) => EditUserDoctorNotifier()),
          ChangeNotifierProvider(
              create: (_) => UpdateDrawerDoctorProfileNotifier()),
          ChangeNotifierProvider(
              create: (_) => UpdateDrawerStaffProfileNotifier()),
          ChangeNotifierProvider(create: (_) => PatientRegisterNotifier()),
          ChangeNotifierProvider(create: (_) => GetMedicineCategoryNotifier()),
          ChangeNotifierProvider(create: (_) => GetMedicineListNotifier()),
          ChangeNotifierProvider(
              create: (_) => GetContentMeasuremnetNotifier()),
          ChangeNotifierProvider(create: (_) => AddMedicineNotifier()),
          ChangeNotifierProvider(create: (_) => DeleteMedicineNotifier()),
          ChangeNotifierProvider(create: (_) => EditMedicineNotifier()),
          ChangeNotifierProvider(
              create: (_) => AddMedicinePrescriptionInfoNotifier()),
          ChangeNotifierProvider(
              create: (_) => GetMedicinePrescriptionListNotifier()),
          ChangeNotifierProvider(create: (_) => HTMLDataNotifier()),
          ChangeNotifierProvider(create: (_) => UpdatePolicyNotifier()),
          ChangeNotifierProvider(create: (_) => BrandNameListNotifier()),
          ChangeNotifierProvider(
              create: (_) => GetManagePrescriptionListNotifier()),
          ChangeNotifierProvider(
              create: (_) => EditPrescriptionTemplateNotifier()),
          ChangeNotifierProvider(
              create: (_) => RegisterPatientFilterNotifier()),
          ChangeNotifierProvider(create: (_) => GetAllNotificationNotifier()),
          ChangeNotifierProvider(create: (_) => ReadNotificationNotfier()),
          ChangeNotifierProvider(create: (_) => NotificationCountNotifier()),
        ],
        child: GetMaterialApp(
            defaultTransition: Transition.noTransition,
            transitionDuration: Duration(seconds: 0),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: MyRouter.generateRoute,
            home: apiToken == 'null' ? Login() : DashboardScreens()),
      ),
    );
  }
}
