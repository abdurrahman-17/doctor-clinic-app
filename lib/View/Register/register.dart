import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/View/ForgetScreen/forget_screen.dart';
import 'package:doctor_clinic_token_app/core/request_response/registration/registrationNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:doctor_clinic_token_app/utils/common/app_validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterNotifier registerNotifier = RegisterNotifier();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _isObscure = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final aboutController = TextEditingController();
  final experienceController = TextEditingController();
  final specialistController = TextEditingController();
  final degreeController = TextEditingController();
  final phoneController = TextEditingController();
  final clinicAddressController = TextEditingController();
  final scheduleTypeController = TextEditingController();
  final patientAttendController = TextEditingController();

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
                  child: Text(
                    'Retry',
                  ))
            ],
            title: new Text(
              "No Internet Connection",
              style: TextStyle(color: Colors.black),
            ),
            content: new Text(
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
    return Consumer<RegisterNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          color: Colors.transparent,
          child: Scaffold(
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundImage(context),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                welcomeText(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      buildName(context),
                      buildEmail(context),
                      buildPassword(context),
                      buildAddress(context),
                      buildCity(context),
                      buildState(context),
                      buildZip(context),
                      buildAbout(context),
                      buildExperience(context),
                      buildSpecialist(context),
                      buildDegree(context),
                      buildPhone(context),
                      buildClinicAddress(context),
                      buildScheduleType(context),
                      // buildPatientAttend(context),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //buildForgotPass(context),
                buildLoginButton(context),
                buildYouhaveanac(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget backgroundImage(context) {
    return Image(
      image: const AssetImage('assets/dashboard.png'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget welcomeText(context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          'Registration',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildEntry(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(85),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Welcome Back To Clinic',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogintitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: const Center(
        child: Text(
          'Log In',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Color(0xff5B5B5B),
          ),
        ),
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: emailController,
        validator: validateEmail,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.mail),
          ),
          hintText: 'Email',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: nameController,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.person),
          ),
          hintText: 'Name',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildAddress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: addressController,
        validator: validateAddress,
        maxLines: 5,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 72),
            child: Icon(Icons.home),
          ),
          hintText: 'Address',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildCity(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: cityController,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.apartment),
          ),
          hintText: 'City',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: stateController,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.explore),
          ),
          hintText: 'State',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildZip(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: zipCodeController,
        validator: validateAddress,
        maxLength: 6,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.my_location),
          ),
          hintText: 'Zip Code',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildAbout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: aboutController,
        validator: validateText,
        maxLines: 5,
        maxLength: 200,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 72),
            child: Icon(Icons.info),
          ),
          hintText: 'About',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildExperience(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.height * 0.025,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: experienceController,
        validator: validateText,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.verified),
          ),
          hintText: 'Experience',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildSpecialist(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: specialistController,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.star),
          ),
          hintText: 'Specialist',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildDegree(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.height * 0.025,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: degreeController,
        validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.school),
          ),
          hintText: 'Degree',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildPhone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: phoneController,
        validator: validateNumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.call),
          ),
          hintText: 'Mobile Number',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildClinicAddress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: clinicAddressController,
        validator: validateText,
        maxLines: 5,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 72),
            child: Icon(Icons.local_hospital),
          ),
          hintText: 'Clinic Address',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildScheduleType(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: scheduleTypeController,
        validator: validateText,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.schedule),
          ),
          hintText: 'Schedule Type',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildPatientAttend(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: patientAttendController,
        validator: validateText,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.mail),
          ),
          hintText: 'Patient Attended',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        controller: passwordController,
        validator: validatePassword,
        obscureText: _isObscure,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.vpn_key),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          hintText: 'Password',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget buildForgotPass(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForgetScreen()));
          },
          child: const Text(
            'Forgot Password ?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff7B859A),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    registerNotifier = Provider.of<RegisterNotifier?>(context, listen: false)!;
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.06,
          bottom: MediaQuery.of(context).size.height * 0.02),
      child: SizedBox(
        width: 235,
        height: 50,
        child: ElevatedButton(
          style: getButtonStyle(context),
          onPressed: () async {
            if (_key.currentState!.validate()) {
              registerNotifier.doctorRegister(
                emailController.text,
                passwordController.text,
                nameController.text,
                addressController.text,
                cityController.text,
                stateController.text,
                int.parse(zipCodeController.text),
                aboutController.text,
                int.parse(experienceController.text),
                specialistController.text,
                degreeController.text,
                int.parse(phoneController.text),
                clinicAddressController.text,
                int.parse(scheduleTypeController.text),
              );
            }
          },
          child: Text(
            'Register',
            style: TextButtonStyle(context),
          ),
        ),
      ),
    );
  }

  Widget buildYouhaveanac(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.012,
          bottom: MediaQuery.of(context).size.height * 0.12),
      child: RichText(
        text: TextSpan(
          text: 'Already have an account',
          style: TextForgetStyle(context),
          children: [
            TextSpan(
              text: ' Login',
              style: RichtextStyle(context),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //Navigator.pushNamed(context, RoutePaths.SIGNUP
                },
            ),
          ],
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
