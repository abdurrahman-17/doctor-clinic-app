import 'package:doctor_clinic_token_app/View/ManageMedicines/AddMedicine/addMedicine.dart';
import 'package:doctor_clinic_token_app/View/ManageMedicines/editMedicine/editMedicine.dart';
import 'package:doctor_clinic_token_app/core/request_response/deleteMedicine/deleteMedicineNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicineList/getMedicineListNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  GetMedicineListNotifier getMedicineListNotifier = GetMedicineListNotifier();
  DeleteMedicineNotifier deleteMedicineNotifier = DeleteMedicineNotifier();

  int doctorId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      getMedicineListNotifier.getMedicineList();
      getMedicineListNotifier.notifyListeners();
    });
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetMedicineListNotifier>(
      builder: (context, provider, _) {
        getMedicineListNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: provider.isLoading,
          child: Scaffold(
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/dashboardmain.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.height * 0.20
                : MediaQuery.of(context).size.height * 0.115,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(context),
              const SizedBox(
                height: 25,
              ),
              searchBar(context),
              const SizedBox(
                height: 20,
              ),
              medicineList(context),
            ],
          ),
        ],
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
            'Medicines List',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 25,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMedicine(),
                  ),
                );
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: const Text(
                'Add Medicine',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 15.0, bottom: 5, left: 25.0, right: 25.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              spreadRadius: 4,
              blurRadius: 10,
            ),
          ],
        ),
        child: TextFormField(
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              getMedicineListNotifier.getMedicineSearchListClass =
                  getMedicineListNotifier.getMedicineListClass.where((list) {
                var drugList = list.drugName!.toLowerCase();
                return drugList.contains(text);
              }).toList();
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Container(
              decoration: BoxDecoration(
                color: const Color(0xff4889FD),
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            hintText: 'Search Medicines',
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget medicineList(context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: getMedicineListNotifier.getMedicineSearchListClass.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10.0),
            child: ListTile(
              minLeadingWidth: 25,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    getMedicineListNotifier
                                .getMedicineSearchListClass[index].categoryId ==
                            1
                        ? FontAwesomeIcons.prescriptionBottle
                        : getMedicineListNotifier
                                    .getMedicineSearchListClass[index]
                                    .categoryId ==
                                2
                            ? FontAwesomeIcons.tablets
                            : getMedicineListNotifier
                                        .getMedicineSearchListClass[index]
                                        .categoryId ==
                                    3
                                ? FontAwesomeIcons.capsules
                                : getMedicineListNotifier
                                            .getMedicineSearchListClass[index]
                                            .categoryId ==
                                        4
                                    ? FontAwesomeIcons.pumpMedical
                                    : getMedicineListNotifier
                                                .getMedicineSearchListClass[
                                                    index]
                                                .categoryId ==
                                            5
                                        ? FontAwesomeIcons.pumpMedical
                                        : getMedicineListNotifier
                                                    .getMedicineSearchListClass[
                                                        index]
                                                    .categoryId ==
                                                6
                                            ? FontAwesomeIcons.pumpMedical
                                            : getMedicineListNotifier
                                                        .getMedicineSearchListClass[
                                                            index]
                                                        .categoryId ==
                                                    7
                                                ? FontAwesomeIcons.pumpMedical
                                                : getMedicineListNotifier
                                                            .getMedicineSearchListClass[
                                                                index]
                                                            .categoryId ==
                                                        8
                                                    ? FontAwesomeIcons
                                                        .eyeDropper
                                                    : getMedicineListNotifier
                                                                .getMedicineSearchListClass[
                                                                    index]
                                                                .categoryId ==
                                                            9
                                                        ? FontAwesomeIcons
                                                            .syringe
                                                        : getMedicineListNotifier
                                                                    .getMedicineSearchListClass[
                                                                        index]
                                                                    .categoryId ==
                                                                10
                                                            ? FontAwesomeIcons
                                                                .maskVentilator
                                                            : getMedicineListNotifier
                                                                        .getMedicineSearchListClass[
                                                                            index]
                                                                        .categoryId ==
                                                                    11
                                                                ? FontAwesomeIcons
                                                                    .bandage
                                                                : FontAwesomeIcons
                                                                    .pills,
                    size: 18,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              title: Text(getMedicineListNotifier
                      .getMedicineSearchListClass[index].drugName
                      .toString() +
                  ' ' +
                  (getMedicineListNotifier
                              .getMedicineSearchListClass[index].dosage
                              .toString() ==
                          'null'
                      ? ''
                      : getMedicineListNotifier
                          .getMedicineSearchListClass[index].dosage
                          .toString()) +
                  ' ' +
                  (getMedicineListNotifier.getMedicineSearchListClass[index]
                              .contentMeasurement
                              .toString() ==
                          'null'
                      ? ''
                      : getMedicineListNotifier
                          .getMedicineSearchListClass[index].contentMeasurement
                          .toString())),
              subtitle: Text((getMedicineListNotifier
                          .getMedicineSearchListClass[index].medicineBrandName
                          .toString() ==
                      'null'
                  ? ''
                  : getMedicineListNotifier
                      .getMedicineSearchListClass[index].medicineBrandName
                      .toString())),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditMedicine(
                            medicineId: getMedicineListNotifier
                                .getMedicineSearchListClass[index].id
                                .toString(),
                            categoryName: getMedicineListNotifier
                                .getMedicineSearchListClass[index].categoryName
                                .toString(),
                            productName: getMedicineListNotifier
                                .getMedicineSearchListClass[index].drugName
                                .toString(),
                            brandName: getMedicineListNotifier
                                        .getMedicineSearchListClass[index]
                                        .medicineBrandName ==
                                    null
                                ? ''
                                : getMedicineListNotifier
                                    .getMedicineSearchListClass[index]
                                    .medicineBrandName
                                    .toString(),
                            dosage: getMedicineListNotifier
                                .getMedicineSearchListClass[index].dosage
                                .toString(),
                            contentMeasurement: getMedicineListNotifier
                                .getMedicineSearchListClass[index]
                                .contentMeasurement
                                .toString(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDeleteMedicineDialog(getMedicineListNotifier
                          .getMedicineSearchListClass[index].id
                          .toString());
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteMedicineDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Medicine",
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            "Are You sure want to delete this medicine?",
            style: TextStyle(color: Colors.grey.shade700),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                setState(() {
                  deleteMedicineNotifier.deleteMedicine(
                    doctorId,
                    int.parse(id),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
