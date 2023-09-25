class DataConstants {
  DataConstants._internal();

  static const LIVE_BASE_URL =
      'https://almuhasabah.colanapps.in/admin/clinic2/public';

  //static const User_Image_Base_Url = '$LIVE_BASE_URL/uploads/app_users/';

  static const String Login = "/api/doctor_login";
  static const String ForgetPassword = "/api/doctor_sendotp";
  static const String OtpVerify = "/api/doctor_otpverify";
  static const String ChangePassword = "/api/doctor_newpassword";
  static const String TimeDoctorScheduler = "/api/doctor_schedule";
  static const String TokenDoctorScheduler = "/api/doctor_schedule";
  static const String AddPatientInfo = "/api/add_patient_info";
  static const String ConsultationCount = "/api/today_consultation_count";
  static const String TodayCheckIn = "/api/today_check_in";
  static const String ListOfAvailability = "/api/list_doctor_schedule";
  static const String AddDoctor = "/api/AddDoctors";
  static const String AddStaff = "/api/AddStaff";
  static const String TodayConsultation = "/api/today_consultation";
  static const String TodayDoneAppointment = "/api/today_done_appointment";
  static const String StaffList = "/api/AddStaffList";
  static const String DoctorList = "/api/AddedDoctorList";
  static const String AddDoctorUpdate = "/api/AddedDoctorUpdateProfile";
  static const String RecordHistory = "/api/Doctor_module_GetpatientReports";
  static const String UpdateDoctorProfile = "/api/AddedDoctorUpdateProfile";
  static const String UpdateStaffProfile = "/api/AddStaffUpdateProfile";
  static const String ListOfPatient = "/api/patient_appoinment_list";
  static const String AboutUs = "/api/AboutUs_doctor";
  static const String PrivacyPolicy = "/api/PrivacyPolicy_doctor";
  static const String TermsAndCondition = "/api/termsCondtion_doctor";
  static const String RecordHistoryFilter =
      "/api/Doctor_module_GetallpatientReports";
  static const String Register = "/api/doctor_register";
  static const String PatientRegister = "/api/patient_register";
  static const String DoctorFeedBack = "/api/doctorfeedback";
  static const String AppointmentDetail = "/api/get_appointment_detail";
  static const String GraphWeekly = "/api/PattientVisitedGraphAPI";
  static const String AddDoctorSchedule = "/api/add_doctor_schedule";
  static const String DoctorLeave = "/api/DoctorLeave";
  static const String DoctorLeaveConfirm = "/api/DoctorLeaveConfirm";
  static const String DoctorLeaveDays = "/api/DoctorLeaveDays";
  static const String DoctorLeaveDelete = "/api/DoctorLeaveDaysDelete";
  static const String DoctorTimeLeave = "/api/DoctorLeaveTimeBased";
  static const String DoctorTimeLeaveConfirm =
      "/api/doctorLeaveConfirmTimeBased";
  static const String AvailabilityDayStatus = "/api/list_doctor_schedule";
  static const String AvailabilityDelete = "/api/delete_schedule_day";
  static const String AvailabilityDeleteConfirm =
      "/api/delete_schedule_day_confirm";
  static const String DoctorScheduleDayStatus =
      "/api/doctor_schedule_day_status";
  static const String GraphMonthly = "/api/MonthlyGraphAPI";
  static const String AddDoctorScheduleToken = "/api/add_doctor_schedule_token";
  static const String TimeWalkedPatient = "/api/get_doctor_schedule_day";
  static const String AddWalkInInfo = "/api/add_walkin";
  static const String PieChart = "/api/PieChartGraphAPI";
  static const String EmergencyList = "/api/emergency_appoinment_list";
  static const String WalkedInList = "/api/walk_in_appoinment_list";
  static const String DeleteAllSchedule = "/api/Delete_doctor_shedule";
  static const String ChangeScheduleList = "/api/Delete_doctor_shedule_list";
  static const String ChangeScheduleConfirm =
      "/api/Delete_doctor_shedule_confirm";
  static const String WalkedInFilter = "/api/walkin_appoinment_filter";
  static const String EmergencyFilter = "/api/Emergency_appoinment_filter";
  static const String PrescriptionUpdate = "/api/patient_prescription";
  static const String RegisteredFilter = "/api/patient_all_appoinment_filter";
  static const String GetDoctorScheduleTime =
      "/api/get_doctor_schedule_day_walkin";
  static const String GetDoctorScheduleToken =
      "/api/get_doctor_schedule_day_token_based_walkin";
  static const String EditUserDoctor = "/api/doctor_profile_update";
  static const String GetMedicineCategory = "/api/get_medicine_categories";
  static const String GetMedicineList = "/api/medicine_prescription_list";
  static const String GetContentMeasurement = "/api/get_Content_Measurement";
  static const String AddMedicine = "/api/add_medicine_prescription";
  static const String AddContentMeasurement = "/api/Content_Measurement";
  static const String AddCategory = "/api/create_medicine_category";
  static const String DeleteMedicine = "/api/delete_medicine_prescription";
  static const String EditMedicine = "/api/edit_medicine_prescription";
  static const String AddMedicnePrescriptionInfo =
      "/api/add_medicine_prescription_info";
  static const String GetMedicinePrescriptionList =
      "/api/patient_medicine_prescription_info_list";
  static const String DeleteMedicinePrescription =
      "/api/patient_medicine_prescription_info_delete";
  static const String EditPrescriptionTemplate =
      "/api/edit_doctor_prescription_theme";
  static const String AddPrescriptionTemplate =
      "/api/add_docotr_prescription_template";
  static const String HTMLDataFormat =
      "/api/patient_medicine_prescription_details";
  static const String UpdatePolicy = "/api/UpdatePolicy";
  static const String BrandNameList = "/api/get_medicine_brand_names";
  static const String EditBrandName = "/api/edit_medicine_brand_name";
  static const String AddBrandName = "/api/create_medicine_brand_name";
  static const String DeleteCategory = "/api/delete_medicine_category";
  static const String DeleteContentMeasurement =
      "/api/delete_Content_Measurements";
  static const String EditCategory = "/api/edit_medicine_category";
  static const String EditContentMeasurement = "/api/edit_Content_Measurement";
  static const String Notificationcount = "/api/doctor_notification_count";
  static const String readNotification = "/api/doctor_read_notification";
  static const String GetManagePrescription = "/api/manage_prescription_list";
  static const String RegisterDataFilter = "/api/registered_patient_filter";
  static const String GetAllNotifications = "/api/doctor_get_all_notification";
}
// const VOUCHER_IMAGE_BASE_URL = 'http://3.22.236.90/uploads/voucher/';
// const OUTLET_IMAGE_BASE_URL = 'http://3.22.236.90/uploads/outlets/';
