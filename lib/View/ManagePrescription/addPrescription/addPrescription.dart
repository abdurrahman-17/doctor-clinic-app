import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/View/CheckedInfoData/CheckedInInfo.dart';
import 'package:doctor_clinic_token_app/View/ManagePrescription/addPrescriptionMedicine.dart';
import 'package:doctor_clinic_token_app/core/request_response/deleteMedicinePrescription/deleteMedicinePrescriptionNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicinePrescriptionList/getMedicinePrescriptionListNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/htmlData/htmlDataNotifier.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddPrescription extends StatefulWidget {
  final patientId;

  const AddPrescription({Key? key, this.patientId}) : super(key: key);

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  GetMedicinePrescriptionListNotifier getMedicinePrescriptionListNotifier =
      GetMedicinePrescriptionListNotifier();
  DeleteMedicinePrescriptionNotifier deleteMedicinePrescriptionNotifier =
      DeleteMedicinePrescriptionNotifier();
  HTMLDataNotifier htmlDataNotifier = HTMLDataNotifier();
  final dropdownValue = TextEditingController();

  @override
  void initState() {
    hitGetApi();
    // TODO: implement initState
    super.initState();
  }

  hitGetApi() {
    Future.delayed(Duration.zero, () {
      print(widget.patientId);
      getMedicinePrescriptionListNotifier.getMedicinePrescriptionList(
        widget.patientId,
      );
      getMedicinePrescriptionListNotifier.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetMedicinePrescriptionListNotifier>(
      builder: (context, provider1, _) {
        getMedicinePrescriptionListNotifier = provider1;
        return ModalProgressHUD(
          inAsyncCall: getMedicinePrescriptionListNotifier.isLoading,
          child: Scaffold(
            body: buildBody(context),
          ),
        );
      },
    );
  }

  Widget buildBody(context) {
    return SafeArea(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('assets/dashboardmain.png'),
            fit: BoxFit.fill,
            height: MediaQuery.of(context).orientation == Orientation.landscape
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
              medicineCard(context),
              // medicineSearchDropdown(context),
              getMedicinePrescriptionListNotifier
                      .getMedicinePrescriptionListClass.isNotEmpty
                  ? createButton(context)
                  : Container(),
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
            'Add Prescription',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 25,
            width: 65,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AddPrescriptionMedicine(
                      patientId: widget.patientId,
                    ),
                  ),
                ).then((val) => val ? hitGetApi() : null);
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
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: FittedBox(
                child: const Text(
                  'Add +',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget medicineCard(context) {
    return Expanded(
      child: getMedicinePrescriptionListNotifier
              .getMedicinePrescriptionListClass.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.pills,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'No Medicine Added Yet',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: getMedicinePrescriptionListNotifier
                  .getMedicinePrescriptionListClass.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffCAE7FC),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  getMedicinePrescriptionListNotifier
                                      .getMedicinePrescriptionListClass[index]
                                      .medicineName
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await deleteMedicinePrescriptionNotifier
                                      .deleteMedicinePrescription(
                                    getMedicinePrescriptionListNotifier
                                        .getMedicinePrescriptionListClass[index]
                                        .id
                                        .toString(),
                                    widget.patientId,
                                  );
                                  hitGetApi();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.scaleBalanced,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      getMedicinePrescriptionListNotifier
                                          .getMedicinePrescriptionListClass[
                                              index]
                                          .medicineQuantity
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.burger,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        getMedicinePrescriptionListNotifier
                                            .getMedicinePrescriptionListClass[
                                                index]
                                            .medicineTiming
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.solidClock,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      getMedicinePrescriptionListNotifier
                                          .getMedicinePrescriptionListClass[
                                              index]
                                          .medicineFrequency
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          getMedicinePrescriptionListNotifier
                                      .getMedicinePrescriptionListClass[index]
                                      .medicineComment ==
                                  null
                              ? Container()
                              : const SizedBox(
                                  height: 20,
                                ),
                          getMedicinePrescriptionListNotifier
                                      .getMedicinePrescriptionListClass[index]
                                      .medicineComment ==
                                  null
                              ? Container()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.solidComment,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            getMedicinePrescriptionListNotifier
                                                .getMedicinePrescriptionListClass[
                                                    index]
                                                .medicineComment
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget createButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: SizedBox(
          width: 180,
          height: 50,
          child: ElevatedButton(
            style: getButtonStyle(context),
            onPressed: () async {
              if (getMedicinePrescriptionListNotifier
                  .getMedicinePrescriptionListClass.isEmpty) {
                appShowToast('Medicine list is empty');
              } else {
                appShowToast('Prescription created successfully');
                Navigator.pop(context, true);
              }
            },
            child: Text(
              'Create',
              style: TextButtonStyle(context),
            ),
          ),
        ),
      ),
    );
  }
}
