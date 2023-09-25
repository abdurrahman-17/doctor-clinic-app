import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/core/request_response/patientRegister/patientRegisterNotifier.dart';
import 'package:doctor_clinic_token_app/utils/Connectivity%20Check/connectivityCheck.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddPatientRegister extends StatefulWidget {
  const AddPatientRegister({Key? key}) : super(key: key);

  @override
  State<AddPatientRegister> createState() => _AddPatientRegisterState();
}

class _AddPatientRegisterState extends State<AddPatientRegister> {
  bool valuesecond = false;
  bool _isObscure = true;
  bool _isObscure1 = true;
  final FocusNode name = FocusNode();
  final FocusNode mobilenumber = FocusNode();
  final FocusNode password = FocusNode();
  final FocusNode confirm_password = FocusNode();
  final FocusNode DOB = FocusNode();
  final FocusNode address = FocusNode();
  final FocusNode city = FocusNode();
  final FocusNode state = FocusNode();
  final FocusNode pincode = FocusNode();
  final FocusNode email = FocusNode();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _DOB = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zipcode = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  PatientRegisterNotifier patientRegisterNotifier = PatientRegisterNotifier();
  String devicetype = '';
  String FCMkey = '';
  bool dobcontrol = false;

  @override
  void initState() {
    Networkcheck().check().then((value) {
      print(value);
      if (value == false) {
        _showConnectionState();
      }
    });
  }

  DateTime? todayDate = DateTime.now();
  String formatted = '';

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );
    if (picked != null && picked != todayDate) {
      setState(() {
        todayDate = picked;
        final DateFormat format = DateFormat('yyyy-MM-dd');
        formatted = format.format(picked);
        _DOB.text = formatted;
        dobcontrol = true;
        print(formatted);
      });
    }
  }

  void _showConnectionState() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Networkcheck().check().then(
                    (value) {
                      print(value);
                      if (value == true) {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
                child: const Text(
                  'Retry',
                ),
              ),
            ],
            title: new Text(
              "No Internet Connection",
              style: const TextStyle(color: Colors.black),
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
    return Consumer<PatientRegisterNotifier>(
      builder: (context, provider, _) {
        return ModalProgressHUD(
          color: Colors.transparent,
          inAsyncCall: provider.isLoading,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: _buildbody(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildbody(BuildContext context) {
    return SingleChildScrollView(
      child: buildBacgroundAndBody(context),
    );
  }

  Widget backgroundImage(context) {
    return Image(
      image: const AssetImage('assets/dashboard.png'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget buildBacgroundAndBody(BuildContext context) {
    return Stack(
      children: [
        backgroundImage(context),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            buildRegisterTitle(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            buildTextFieldWIthValidator(context),
            buildRegisterButton(context),
          ],
        ),
      ],
    );
  }

  Widget buildTextFieldWIthValidator(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          buildFullName(context),
          buildNumber(context),
          buildEmail(context),
          buildPassword(context),
          buildConfirmPassword(context),
          buildDOB(context),
          buildAddress(context),
          buildCity(context),
          buildState(context),
          buildZIPcode(context),
        ],
      ),
    );
  }

  Widget buildRegisterTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: const Center(
        child: Text(
          "Patient Registeration",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildFullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.035,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: validateText,
        focusNode: name,
        controller: _name,
        validator: (names) {
          if (names!.isEmpty) {
            return "Field is Required";
          }

          return null;
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.person)),
          hintText: "Full Name",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.035,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: mobilenumber,
        keyboardType: TextInputType.number,
        maxLength: 10,
        controller: _number,
        validator: (nums) {
          if (nums!.isEmpty) {
            return "Number is Required";
          } else if (nums.length < 10) {
            return "Please Enter 10 digit Valid Number";
          }
          return null;
        },
        decoration: InputDecoration(
          counterText: '',
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.phone_outlined),
          ),
          hintText: "Mobile Number",
          hintStyle: TextFieldStyle(context),
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: email,
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        validator: (emails) {
          if (emails!.isEmpty) {
            return "Email Is Required";
          }
          String pattern = r'\w+@\w+\.\w+';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(emails)) {
            return 'Invalid Email';
          }
        },
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
          hintText: "Email",
          hintStyle: TextFieldStyle(context),
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: password,
        validator: validatePassword,
        controller: _password,
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
          hintText: "Password",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: confirm_password,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password Is Required";
          }
          if (_password.text != value) {
            return "Password Does Not Match";
          }
        },
        controller: _confirmpassword,
        obscureText: _isObscure1,
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
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(_isObscure1 ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure1 = !_isObscure1;
                });
              },
            ),
          ),
          hintText: "Confirm Password",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildDOB(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.025,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
      ),
      child: TextFormField(
        onTap: () {
          _selectDate(context);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: DOB,
        controller: _DOB,
        readOnly: true,
        validator: (dob) {
          if (dob!.isEmpty) {
            return "Date of Birth is Required";
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.calendar_today_outlined,
              color: DOB.hasFocus ? Colors.grey : Colors.grey,
            ),
          ),
          hintText: "Select Date of Birth",
          hintStyle: TextFieldStyle(context),
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
        textCapitalization: TextCapitalization.words,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: address,
        controller: _address,
        validator: (adds) {
          if (adds!.isEmpty) {
            return "Address is Required";
          } else if (adds.length < 6) {
            return "Please Enter Atleast 6 Character";
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.home),
          ),
          hintText: "Address",
          hintStyle: TextFieldStyle(context),
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
        textCapitalization: TextCapitalization.words,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: city,
        controller: _city,
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
          hintText: "City",
          hintStyle: TextFieldStyle(context),
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
        textCapitalization: TextCapitalization.words,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        focusNode: state,
        controller: _state,
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
          hintText: "State",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildZIPcode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.025,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.done,
        focusNode: pincode,
        controller: _zipcode,
        maxLength: 6,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field is Required";
          } else if (value.length < 6) {
            return "Zip Code length is less then 6";
          }

          return null;
        },
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.my_location),
          ),
          hintText: "Pin Code",
          hintStyle: TextFieldStyle(context),
        ),
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    patientRegisterNotifier =
        Provider.of<PatientRegisterNotifier?>(context, listen: false)!;
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.08,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          bottom: MediaQuery.of(context).size.height * 0.05),
      child: SizedBox(
        height: 50,
        width: 235,
        child: ElevatedButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              patientRegisterNotifier.PatientRegister(
                _email.text.trim(),
                _password.text.trim(),
                _name.text.trim(),
                _DOB.text.trim(),
                _address.text.trim(),
                _city.text.trim(),
                _state.text.trim(),
                _zipcode.text.trim(),
                _number.text,
              );
            } else if (_name.text.isEmpty && _name.text.length < 5) {
              name.requestFocus();
            } else if (_number.text.isEmpty && _number.text.length < 10) {
              mobilenumber.requestFocus();
            } else if (_email.text.isEmpty) {
              email.requestFocus();
            } else if (_password.text.isEmpty) {
              password.requestFocus();
            } else if (_confirmpassword.text.isEmpty) {
              confirm_password.requestFocus();
            } else if (_DOB.text.isEmpty) {
              DOB.requestFocus();
            } else if (_address.text.isEmpty) {
              address.requestFocus();
            } else if (_city.text.isEmpty) {
              city.requestFocus();
            } else if (_state.text.isEmpty) {
              state.requestFocus();
            } else if (_zipcode.text.isEmpty) {
              pincode.requestFocus();
            } else if (_zipcode.text.length < 6) {
              pincode.requestFocus();
            }
          },
          style: getButtonStyle(context),
          child: Text(
            "Register",
            style: TextButtonStyle(context),
          ),
        ),
      ),
    );
  }
}
