import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/self_treatment/components/create_remedies.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/self_treatment/self_treatment.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

final DateTime timestamp = DateTime.now();

class CreateTreatmentPage extends StatefulWidget {
  const CreateTreatmentPage({super.key});

  @override
  State<CreateTreatmentPage> createState() => _CreateTreatmentPageState();
}

class _CreateTreatmentPageState extends State<CreateTreatmentPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _numRemediesController = TextEditingController();
  bool forDepression = false;
  bool forAnxiety = false;
  bool forStress = false;

  String therapistID = '';
  String therapistName = '';

  Future getTherapistName() async {
    await FirebaseFirestore.instance
        .collection('therapists')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((document) {
                Map<String, dynamic> data = document.data();
                therapistID = document.reference.id;
                therapistName = data['name'];
              })
            });
  }

  @override
  void initState() {
    super.initState();
    getTherapistName();
  }

  // addTreatment() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: const [
  //             SpinKitWanderingCubes(
  //               color: Colors.white,
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               'Adding treatment',
  //               style: TextStyle(
  //                 fontFamily: 'Lato',
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.normal,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   String uid = FirebaseAuth.instance.currentUser?.uid as String;
  //   // Add user details
  //   addTreatmentData(
  //     uid,
  //     therapistName,
  //     _titleController.text.trim(),
  //     _descriptionController.text.trim(),
  //     int.parse(_durationController.text.trim()),
  //     int.parse(_numRemediesController.text.trim()),
  //     forDepression,
  //     forAnxiety,
  //     forStress,
  //     timestamp,
  //   );
  //   Get.to(() => const SelfTreatmentPage());
  // }

  // Future addTreatmentData(
  //     String uid,
  //     String therapistName,
  //     String title,
  //     String desc,
  //     int duration,
  //     int numOfRemedies,
  //     bool forDepression,
  //     bool forAnxiety,
  //     bool forStress,
  //     DateTime timestamp) async {
  //   await FirebaseFirestore.instance
  //       .collection('selfcare_treatments')
  //       .doc()
  //       .set({
  //     'uid': uid,
  //     'therapistName': therapistName,
  //     'title': title,
  //     'description': desc,
  //     'duration': duration,
  //     'numOfRemedies': numOfRemedies,
  //     'forDepression': forDepression,
  //     'forAnxiety': forAnxiety,
  //     'forStress': forStress,
  //     'timestamp': timestamp,
  //   });
  // }

  String randomID = "treatment_" + DateTime.now().millisecondsSinceEpoch.toString() + "_" + new Random().nextInt(1000000).toString();

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
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add treatment',
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
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _titleController,
                              validator: (title) {
                                if (title == null || title.isEmpty) {
                                  return "Title can't be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter treatment title',
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
                                  'Title',
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
                              controller: _descriptionController,
                              keyboardType: TextInputType.multiline,
                              validator: (desc) {
                                if (desc == null || desc.isEmpty) {
                                  return "Please describe this treatment";
                                }
                                return null;
                              },
                              maxLines: 4,
                              decoration: const InputDecoration(
                                hintText: 'Enter treatment description',
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
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: _durationController,
                              validator: (dur) {
                                if (dur == null || dur.isEmpty) {
                                  return "Please enter expected treatment duration";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter expected treatment duration',
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
                                  'Duration (min)',
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
                              controller: _numRemediesController,
                              validator: (remedies) {
                                if (remedies == null || remedies.isEmpty) {
                                  return "Please enter the number of remedies";
                                } else if (int.parse(remedies) == 0) {
                                  return "Please enter a valid number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter number of remedies',
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
                                  'Number of remedies',
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.0),
                                    child: Text(
                                      "Category: ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: myLightPurple,
                                            checkColor: myDarkPurple,
                                            value: forDepression,
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                forDepression =
                                                    newValue ?? false;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "Depression ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Lato',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: myLightPurple,
                                            checkColor: myDarkPurple,
                                            value: forAnxiety,
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                forAnxiety = newValue ?? false;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "Anxiety ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Lato',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: myLightPurple,
                                            checkColor: myDarkPurple,
                                            value: forStress,
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                forStress = newValue ?? false;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "Stress ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Lato',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: OutlinedButton(
                      style: darkOutlinedButton,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // addTreatment();
                          Get.to(() => CreateRemediesPage(
                                uid: user.uid,
                                therapistName: therapistName,
                                treatmentTitle: _titleController.text.trim(),
                                treatmentDesc:
                                    _descriptionController.text.trim(),
                                duration:
                                    int.parse(_durationController.text.trim()),
                                remediesCount:
                                    int.parse(_numRemediesController.text),
                                forDepression: forDepression,
                                forAnxiety: forAnxiety,
                                forStress: forStress,
                                timestamp: timestamp,
                                randomID: randomID,
                              ));
                        }
                      },
                      child: const Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
