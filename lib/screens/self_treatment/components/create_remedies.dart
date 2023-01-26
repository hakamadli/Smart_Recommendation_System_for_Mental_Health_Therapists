import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/authentication/professional_help_auth.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/self_treatment/self_treatment.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

final DateTime timestamp = DateTime.now();

class CreateRemediesPage extends StatefulWidget {
  const CreateRemediesPage({
    Key? key,
    required this.uid,
    required this.therapistName,
    required this.treatmentTitle,
    required this.treatmentDesc,
    required this.duration,
    required this.remediesCount,
    required this.forDepression,
    required this.forAnxiety,
    required this.forStress,
    required this.timestamp,
    required this.randomID,
  }) : super(key: key);

  final String uid;
  final String therapistName;
  final String treatmentTitle;
  final String treatmentDesc;
  final int duration;
  final int remediesCount;
  final bool forDepression;
  final bool forAnxiety;
  final bool forStress;
  final DateTime timestamp;
  final String randomID;
  // final DocumentSnapshot treatment;

  @override
  State<CreateRemediesPage> createState() => _CreateRemediesPageState(
        uid: uid,
        therapistName: therapistName,
        treatmentTitle: treatmentTitle,
        treatmentDesc: treatmentDesc,
        duration: duration,
        remediesCount: remediesCount,
        forDepression: forDepression,
        forAnxiety: forAnxiety,
        forStress: forStress,
        timestamp: timestamp,
        randomID: randomID,
      );
}

class _CreateRemediesPageState extends State<CreateRemediesPage> {
  _CreateRemediesPageState({
    Key? key,
    required this.uid,
    required this.therapistName,
    required this.treatmentTitle,
    required this.treatmentDesc,
    required this.duration,
    required this.remediesCount,
    required this.forDepression,
    required this.forAnxiety,
    required this.forStress,
    required this.timestamp,
    required this.randomID,
  });

  final String uid;
  final String therapistName;
  final String treatmentTitle;
  final String treatmentDesc;
  final int duration;
  final int remediesCount;
  final bool forDepression;
  final bool forAnxiety;
  final bool forStress;
  final DateTime timestamp;
  final String randomID;
  // final DocumentSnapshot treatment;

  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<TextEditingController> _remedyTitleControllers = [];
  List<TextEditingController> _remedyDescControllers = [];

  addTreatment() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SpinKitWanderingCubes(
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Adding treatment',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
    String uid = FirebaseAuth.instance.currentUser?.uid as String;
    // Add user details
    addTreatmentData(
      uid,
      therapistName,
      treatmentTitle,
      treatmentDesc,
      duration,
      remediesCount,
      forDepression,
      forAnxiety,
      forStress,
      timestamp,
      randomID,
    );
    Get.to(() => const SelfTreatmentPage());
  }

  Future addTreatmentData(
      String uid,
      String therapistName,
      String treatmentTitle,
      String treatmentDesc,
      int duration,
      int numOfRemedies,
      bool forDepression,
      bool forAnxiety,
      bool forStress,
      DateTime timestamp,
      String randomID) async {
    await FirebaseFirestore.instance
        .collection('selfcare_treatments')
        .doc(randomID)
        .set({
      'uid': uid,
      'therapistName': therapistName,
      'treatmentName': treatmentTitle,
      'treatmentDescription': treatmentDesc,
      'treatmentDuration': duration,
      'numOfRemedies': numOfRemedies,
      'forDepression': forDepression,
      'forAnxiety': forAnxiety,
      'forStress': forStress,
      'timestamp': timestamp,
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<GlobalKey<FormState>> _formKeys = [];
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _remediesList = [];
  @override
  void initState() {
    super.initState();
    // _formKeys = List.generate(remediesCount, (_) => GlobalKey<FormState>());
    // for (int i = 0; i < remediesCount; i++) {
    //   _remedyTitleControllers.add(TextEditingController());
    //   _remedyDescControllers.add(TextEditingController());
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.fitWidth),
        color: myDarkPurple,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton:
            WidgetsBinding.instance.window.viewInsets.bottom > 0.0
                ? FloatingActionButton(
                    backgroundColor: myDarkPurple,
                    onPressed: () => FocusScope.of(context).unfocus(),
                    child: const Icon(
                      Icons.keyboard,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox.shrink(),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add remedies',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato-Bold',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => SelfTreatmentPage());
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView.separated(
                      itemCount: remediesCount,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            color: myLightPurple,
                          ),
                      itemBuilder: (context, index) {
                        _remedyTitleControllers.add(TextEditingController());
                        _remedyDescControllers.add(TextEditingController());
                        return Container(
                          margin: const EdgeInsets.all(12),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: Text(
                                        'Remedy ' + (index + 1).toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Lato-Bold',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: _remedyTitleControllers[index],
                                  validator: (title) {
                                    if (title == null || title.isEmpty) {
                                      return "Title can't be empty";
                                    }
                                    return null;
                                  },
                                  // onSaved: ((newRemedyTitle) {
                                  //   _remediesList[index]['remedyTitle'] =
                                  //       newRemedyTitle!;
                                  //   FocusScope.of(context)
                                  //       .requestFocus(focusNode);
                                  // }),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter remedy title',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF8E8E8E),
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    label: Text(
                                      'Remedy',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                    contentPadding: EdgeInsets.all(16),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: _remedyDescControllers[index],
                                  validator: (desc) {
                                    if (desc == null || desc.isEmpty) {
                                      return "Please describe this remedy";
                                    }
                                    return null;
                                  },
                                  // onSaved: ((newRemedyDesc) {
                                  //   _remediesList[index]['remedyDesc'] =
                                  //       newRemedyDesc!;
                                  //   FocusScope.of(context)
                                  //       .requestFocus(focusNode);
                                  // }),
                                  maxLines: 4,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter remedy description',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF8E8E8E),
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    label: Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                    contentPadding: EdgeInsets.all(16),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Column(
                    children: [
                      OutlinedButton(
                        style: darkOutlinedButton,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            for (var i = 0; i < remediesCount; i++) {
                              _remediesList.add({
                                'remedyTitle': _remedyTitleControllers[i].text,
                                'remedyDescription':
                                    _remedyDescControllers[i].text,
                                'treatmentID': randomID,
                                'treatmentName': treatmentTitle,
                                'therapistID': uid,
                                'treatmentDescription': treatmentDesc,
                                'treatmentDuration': duration,
                                'numOfRemedies': remediesCount,
                                'forDepression': forDepression,
                                'forAnxiety': forAnxiety,
                                'forStress': forStress,
                                'timestamp': timestamp,
                              });
                            }
                            addTreatment();
                            for (var i = 0; i < _remediesList.length; i++) {
                              _firestore
                                  .collection('treatment_remedies')
                                  .doc()
                                  .set(_remediesList[i]);
                            }
                            _remedyTitleControllers
                                .forEach((controller) => controller.clear());
                            _remedyDescControllers
                                .forEach((controller) => controller.clear());
                          }
                          // bool allValid = true;
                          // _formKeys.forEach((key) {
                          //   if (!key.currentState!.validate()) {
                          //     allValid = false;
                          //   }
                          // });
                          // if (allValid) {
                          //   // addTreatment();
                          //   // for (var i = 0; i < remediesCount; i++) {
                          //   //   _remediesList.add({
                          //   //     'remedyTitle':
                          //   //         _remedyTitleControllers[remediesCount].text,
                          //   //     'remedyDescription':
                          //   //         _remedyDescControllers[remediesCount].text,
                          //   //     // 'remedyTitle': _titleController.text.trim(),
                          //   //     // 'remedyDescription':
                          //   //     //     _descriptionController.text.trim()
                          //   //   });
                          //   // }
                          // }
                          // // final _formKey = GlobalKey<FormState>();
                          // // if (_formKey.currentState!.validate()) {
                          // //   _formKey.currentState!.save();
                          // //   _remediesList.add({
                          // //     'remedyTitle': _titleController.text.trim(),
                          // //     'remedyDescription':
                          // //         _descriptionController.text.trim()
                          // //   });
                          // // }
                          // print(_remediesList);
                          // for (var i = 0; i < _remediesList.length; i++) {
                          //   // _firestore
                          //   //     .collection('treatment_remedies')
                          //   //     .doc()
                          //   //     .set(_remediesList[i]);
                          //   print(_remediesList[i]);
                          // }
                          // // for (var i = 0; i < remediesCount; i++) {
                          // //   final _formKey = GlobalKey<FormState>();
                          // //   if (_formKey.currentState!.validate()) {
                          // //     _formKey.currentState!.save();
                          // //     _remediesList.add({
                          // //       'remedyTitle': _titleController.text.trim(),
                          // //       'remedyDescription':
                          // //           _descriptionController.text.trim()
                          // //     });
                          // //   }
                          // // }
                          const addedSnackBar = SnackBar(
                            content: Text(
                              "Treatment remedies added",
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(addedSnackBar);
                        },
                        child: const Text(
                          'Add',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                      TextButton(
                          onPressed: (() {
                            Get.back();
                          }),
                          child: Text(
                            "Go back",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
