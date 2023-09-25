import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/core/request_response/addMedicinePrescriptionInfo/addMedicinePrescriptionInfoNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicineList/getMedicineListNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

class AddPrescriptionMedicine extends StatefulWidget {
  final patientId;

  const AddPrescriptionMedicine({Key? key, this.patientId}) : super(key: key);

  @override
  State<AddPrescriptionMedicine> createState() =>
      _AddPrescriptionMedicineState();
}

class _AddPrescriptionMedicineState extends State<AddPrescriptionMedicine> {
  GetMedicineListNotifier getMedicineListNotifier = GetMedicineListNotifier();
  AddMedicinePrescriptionInfoNotifier addMedicinePrescriptionInfoNotifier =
      AddMedicinePrescriptionInfoNotifier();

  final dropdownValue = TextEditingController();
  final quantityController = TextEditingController();
  final commentController = TextEditingController();
  String? foodGroupTiming;
  String? dropDownTiming;
  String? dropDownFrequency;
  int doctorId = 0;

  List dropDownTimingList = [
    'Before Food',
    'After Food',
  ];

  List dropDownFrequencyList = [
    '1-0-0',
    '0-1-0',
    '0-0-1',
    '1-1-0',
    '0-1-1',
    '1-0-1',
    '1-1-1',
    'S-O-S',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    Future.delayed(Duration.zero, () {
      getMedicineListNotifier.getMedicineList();
      getMedicineListNotifier.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMedicinePrescriptionInfoNotifier>(
      builder: (context, provider, _) {
        provider = addMedicinePrescriptionInfoNotifier;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: const AssetImage('assets/dashboardmain.png'),
              fit: BoxFit.fill,
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height * 0.18
                      : MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(context),
                const SizedBox(
                  height: 45,
                ),
                medicineSearchDropdown(context),
                const SizedBox(
                  height: 20,
                ),
                numberOfMedicine(context),
                const SizedBox(
                  height: 20,
                ),
                frequencyAndTimeField(context),
                const SizedBox(
                  height: 20,
                ),
                commentField(context),
                const SizedBox(
                  height: 35,
                ),
                AddButton(context),
                const SizedBox(
                  height: 15,
                ),
              ],
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
            'Add Medicine',
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

  Widget medicineSearchDropdown(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SearchField(
        suggestions: getMedicineListNotifier.getMedicineListClass
            .map(
              (e) => SearchFieldListItem(
                // (e.medicineBrandName.toString() == 'null'
                //     ? ''
                //     : e.medicineBrandName.toString()) +
                //     ' ' +
                    e.drugName.toString() +
                    ' ' +
                    (e.dosage.toString() == 'null' ? '' : e.dosage.toString()) +
                    ' ' +
                    (e.contentMeasurement.toString() == 'null'
                        ? ''
                        : e.contentMeasurement.toString()),
              ),
            )
            .toList(),
        //autoCorrect: true,
        controller: dropdownValue,
        suggestionState: Suggestion.hidden,
        textInputAction: TextInputAction.next,
        hint: 'Search Medicine',
        hasOverlay: true,
        searchInputDecoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff69A1F8),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff69A1F8),
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        maxSuggestionsInViewPort: 6,
        itemHeight: 50,
      ),
    );
  }

  Widget numberOfMedicine(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              //validator: validateText,
              decoration: const InputDecoration(
                hintText: 'No of medicine',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff69A1F8),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff69A1F8),
                    width: 2,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff68A1F8), width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: dropDownFrequency,
                    hint: const Text('Frequency'),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    onChanged: (value) {
                      setState(
                        () {
                          dropDownFrequency = value.toString();
                        },
                      );
                    },
                    items: dropDownFrequencyList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items.toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget frequencyAndTimingField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff68A1F8), width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: dropDownTiming,
                    hint: const Text('Timing'),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    onChanged: (value) {
                      setState(
                        () {
                          dropDownTiming = value.toString();
                        },
                      );
                    },
                    items: dropDownTimingList.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items.toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget frequencyAndTimeField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Before Food'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 'Before Food',
                groupValue: foodGroupTiming,
                onChanged: (String? value) {
                  setState(() {
                    foodGroupTiming = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('After Food'),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: 'After Food',
                groupValue: foodGroupTiming,
                onChanged: (String? value) {
                  setState(() {
                    foodGroupTiming = value;
                    print(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: commentController,
        maxLines: 5,
        //validator: validateText,
        decoration: const InputDecoration(
          hintText: 'Comments',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff69A1F8),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff69A1F8),
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }

  Widget AddButton(context) {
    return Center(
      child: SizedBox(
        width: 180,
        height: 50,
        child: ElevatedButton(
          style: getButtonStyle(context),
          onPressed: () async {
            print(widget.patientId);
            if (foodGroupTiming != null) {
              if (dropDownFrequency != null) {
                addMedicinePrescriptionInfoNotifier.addMedicinePrescriptionInfo(
                  doctorId,
                  widget.patientId,
                  dropdownValue.text,
                  dropDownFrequency.toString(),
                  quantityController.text,
                  foodGroupTiming.toString(),
                  commentController.text.isEmpty
                      ? 'null'
                      : commentController.text,
                  context,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Select Medicine Frequency')));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select Medicine Timing')));
            }
          },
          child: Text(
            'Add',
            style: TextButtonStyle(context),
          ),
        ),
      ),
    );
  }
}
