import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/authentication/settings_auth.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/home/components/das_stats.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/home/components/manage_treatment_section.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/home/components/nav_box.dart';
import '../../services/user_data/get_user_displayname.dart';
import '../../shared/loading.dart';
import 'package:ionicons/ionicons.dart';
import '../../utils/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final therapistsRef = FirebaseFirestore.instance.collection('therapists');
  final Stream<QuerySnapshot> _therapistsStream =
      FirebaseFirestore.instance.collection('therapists').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Container(
          child: StreamBuilder(
            stream: _therapistsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              NavBox(),
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: 16, top: 8),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Features for you",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Lato-Bold',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF543E7A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ManageTreatmentSection(),
                            ],
                          ),
                        ),
                        DASStatsChart(),
                      ],
                    ),
                  ],
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
      ),
    );
  }
}
