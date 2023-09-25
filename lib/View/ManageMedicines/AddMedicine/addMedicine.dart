import 'package:doctor_clinic_token_app/Utils/common/app_text_style.dart';
import 'package:doctor_clinic_token_app/Utils/common/app_validators.dart';
import 'package:doctor_clinic_token_app/core/request_response/addCategory/addCategoryNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addContentMeasurment/addContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/addMedicine/addMedicineNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/brandNameList/brandNameListNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getContentMeasurement/getContentMeasurementNotifier.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicineCategory/getMedicineCategoryNotifier.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  GetMedicineCategoryNotifier getMedicineCategoryNotifier =
      GetMedicineCategoryNotifier();
  GetContentMeasuremnetNotifier getContentMeasuremnetNotifier =
      GetContentMeasuremnetNotifier();
  BrandNameListNotifier brandNameListNotifier = BrandNameListNotifier();
  AddMedicineNotifier addMedicineNotifier = AddMedicineNotifier();
  AddContentMeasurementNotifier addContentMeasurementNotifier =
      AddContentMeasurementNotifier();
  AddCategoryNotifier addCategoryNotifier = AddCategoryNotifier();

  String? dropDownMeasurment;
  String? dropDownCategory;
  String? dropDownBrandName;
  int? dropDownCategoryId;
  int? dropDownBrandId;
  int doctorId = 0;
  final measurmentController = TextEditingController();
  final productController = TextEditingController();
  final dosageController = TextEditingController();
  final categoryController = TextEditingController();
  final brandNameController = TextEditingController();

  @override
  void initState() {
    MySharedPreferences.instance.getDoctorId('doctorID').then((value) {
      setState(() {
        doctorId = value;
        print(doctorId);
      });
    });
    Future.delayed(Duration.zero, () async {
      await getMedicineCategoryNotifier.getCategory();
    });
    Future.delayed(Duration.zero, () async {
      await getContentMeasuremnetNotifier.getContentMeasurement();
    });
    Future.delayed(Duration.zero, () async {
      await brandNameListNotifier.getBrandNameList();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddMedicineNotifier>(
      builder: (context, provider, _) {
        addMedicineNotifier = provider;
        return ModalProgressHUD(
          inAsyncCall: addMedicineNotifier.isLoading,
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
                      ? MediaQuery.of(context).size.height * 0.20
                      : MediaQuery.of(context).size.height * 0.115,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(context),
                const SizedBox(
                  height: 45,
                ),
                brandNameDropField(context),
                const SizedBox(
                  height: 20,
                ),
                porductNameField(context),
                const SizedBox(
                  height: 20,
                ),
                categoryField(context),
                const SizedBox(
                  height: 20,
                ),
                dosageField(context),
                const SizedBox(
                  height: 20,
                ),
                contentMeasurementField(context),
                const SizedBox(
                  height: 60,
                ),
                addButton(context),
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

  Widget dosageField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Dosage',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 45,
            child: TextFormField(
              controller: dosageController,
              keyboardType: TextInputType.number,
              validator: validateText,
              decoration: const InputDecoration(
                hintText: '#100',
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
        ],
      ),
    );
  }

  Widget brandNameDropField(context) {
    return Consumer<BrandNameListNotifier>(
      builder: (context, provider7, _) {
        brandNameListNotifier = provider7;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            width: double.infinity,
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
                  value: dropDownBrandName,
                  hint: const Text('brandName'),
                  icon: Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     showAddCategoryDialogue(context);
                      //   },
                      //   icon: Icon(
                      //     Icons.add_circle,
                      //     color: Colors.blueAccent,
                      //   ),
                      // ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      dropDownBrandName = value.toString();
                      for (int i = 0;
                          i <
                              brandNameListNotifier
                                  .getBrandNameListClass.length;
                          i++) {
                        if (brandNameListNotifier
                                .getBrandNameListClass[i].medicineBrandName ==
                            dropDownBrandName) {
                          dropDownBrandId =
                              brandNameListNotifier.getBrandNameListClass[i].id;
                        }
                      }
                      print(dropDownBrandName);
                    });
                  },
                  items:
                      brandNameListNotifier.getBrandNameListClass.map((items) {
                    return DropdownMenuItem(
                      value: items.medicineBrandName,
                      child: Text(
                        items.medicineBrandName.toString(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget brandNameField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          controller: brandNameController,
          validator: validateText,
          decoration: const InputDecoration(
            hintText: 'Brand Name',
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
      ),
    );
  }

  Widget porductNameField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          controller: productController,
          validator: validateText,
          decoration: const InputDecoration(
            hintText: 'Product Name',
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
      ),
    );
  }

  Widget contentMeasurementField(context) {
    return Consumer<GetContentMeasuremnetNotifier>(
      builder: (context, provider1, _) {
        getContentMeasuremnetNotifier = provider1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Content Measurement',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 200,
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
                      value: dropDownMeasurment,
                      hint: const Text('measurement'),
                      icon: Row(
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     showAddMeasurementDialogue(context);
                          //   },
                          //   icon: Icon(
                          //     Icons.add_circle,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                      onChanged: (value) {
                        setState(() {
                          print(value);
                          dropDownMeasurment = value.toString();
                        });
                      },
                      items: getContentMeasuremnetNotifier
                          .getContentMeasurementClass
                          .map((items) {
                        return DropdownMenuItem(
                          value: items.unitName,
                          child: Text(items.unitName.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showAddMeasurementDialogue(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Add Measurment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                addMeasurmentField(context),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        "Add",
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        if (measurmentController.text != '') {
                          await addContentMeasurementNotifier
                              .addContentMeasurement(
                                  doctorId, measurmentController.text);
                          measurmentController.text = '';
                          getContentMeasuremnetNotifier.getContentMeasurement();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter measurement')));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addMeasurmentField(context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xffCAE7FC),
            offset: Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: measurmentController,
        //validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: '#ml',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget categoryField(context) {
    return Consumer<GetMedicineCategoryNotifier>(
      builder: (context, provider2, _) {
        getMedicineCategoryNotifier = provider2;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 200,
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
                      value: dropDownCategory,
                      hint: const Text('category'),
                      icon: Row(
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     showAddCategoryDialogue(context);
                          //   },
                          //   icon: Icon(
                          //     Icons.add_circle,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                      onChanged: (value) {
                        setState(() {
                          dropDownCategory = value.toString();
                          for (int i = 0;
                              i <
                                  getMedicineCategoryNotifier
                                      .getCategoryClass.length;
                              i++) {
                            if (getMedicineCategoryNotifier
                                    .getCategoryClass[i].categoryName ==
                                dropDownCategory) {
                              dropDownCategoryId = getMedicineCategoryNotifier
                                  .getCategoryClass[i].id;
                            }
                          }
                          print(dropDownCategoryId);
                        });
                      },
                      items: getMedicineCategoryNotifier.getCategoryClass
                          .map((items) {
                        return DropdownMenuItem(
                          value: items.categoryName,
                          child: Text(
                            items.categoryName.toString(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showAddCategoryDialogue(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Add Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                addCategoryField(context),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        "Add",
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        if (categoryController.text != '') {
                          await addCategoryNotifier.addCategory(
                              doctorId, categoryController.text);
                          categoryController.text = '';
                          getMedicineCategoryNotifier.getCategory();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter category')));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addCategoryField(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffCAE7FC),
            offset: Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: categoryController,
        //validator: validateText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: '#capsules',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget addButton(context) {
    return Center(
      child: SizedBox(
        width: 180,
        height: 50,
        child: ElevatedButton(
          style: getButtonStyle(context),
          onPressed: () async {
            print(dropDownCategoryId);
            print(dropDownMeasurment);
            print(dosageController);
            if (productController.text != '') {
              if (dropDownCategoryId != null) {
                addMedicineNotifier.addMedicine(
                  doctorId,
                  productController.text,
                  dropDownBrandName != null ? dropDownBrandId.toString() : '',
                  // brandNameController.text.isNotEmpty
                  //     ? brandNameController.text
                  //     : '',
                  int.parse(dropDownCategoryId.toString()),
                  dropDownMeasurment != null
                      ? dropDownMeasurment.toString()
                      : '',
                  dosageController.text.isNotEmpty
                      ? int.parse(dosageController.text)
                      : 0,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select category')));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter product name')));
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
