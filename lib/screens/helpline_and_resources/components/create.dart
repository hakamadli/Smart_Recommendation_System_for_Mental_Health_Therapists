import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/authentication/professional_help_auth.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

final DateTime timestamp = DateTime.now();

class CreateHelpPage extends StatefulWidget {
  const CreateHelpPage({super.key});

  @override
  State<CreateHelpPage> createState() => _CreateHelpPageState();
}

class _CreateHelpPageState extends State<CreateHelpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hotlineController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  addResource() {
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
                'Adding resource',
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
    addResourceData(
      uid,
      _nameController.text.trim(),
      _hotlineController.text.trim(),
      _emailController.text.trim(),
      _websiteController.text.trim(),
      _descController.text.trim(),
      timestamp,
    );
    Get.to(() => const ProfessionalHelpAuth());
  }

  Future addResourceData(String uid, String name, String hotline, String email,
      String website, String desc, DateTime timestamp) async {
    await FirebaseFirestore.instance
        .collection('helpline_and_resources')
        .doc()
        .set({
      'uid': uid,
      'helpName': name,
      'hotline': hotline,
      'helpEmail': email,
      'website': website,
      'description': desc,
      'timestamp': timestamp,
    });
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
                        'Add resource',
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
                          Get.to(ProfessionalHelpAuth());
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
                              controller: _nameController,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return "Resource name can't be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter resource name',
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
                                  'Name',
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
                              controller: _hotlineController,
                              validator: (hotline) {
                                if (hotline == null || hotline.isEmpty) {
                                  return "Resource hotline can't be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter resource hotline',
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
                                  'Hotline / Contact No.',
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
                              controller: _emailController,
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return "Resource email can't be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter resource email address',
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
                                  'Email',
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
                              controller: _websiteController,
                              validator: (website) {
                                if (website == null || website.isEmpty) {
                                  return "Resource website can't be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter resource website link',
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
                                  'Website',
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
                              controller: _descController,
                              validator: (desc) {
                                if (desc == null || desc.isEmpty) {
                                  return "Resource description can't be empty";
                                }
                                return null;
                              },
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: 'Describe more information',
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
                    ),
                  ),
                  Center(
                    child: OutlinedButton(
                      style: darkOutlinedButton,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addResource();
                          const addedSnackBar = SnackBar(
                            content: Text(
                              "Resource added",
                            ),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(addedSnackBar);
                        }
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
