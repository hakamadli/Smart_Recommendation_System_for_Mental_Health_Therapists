import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/self_treatment/self_treatment.dart';

class ManageTreatmentSection extends StatefulWidget {
  const ManageTreatmentSection({super.key});

  @override
  State<ManageTreatmentSection> createState() => _ManageTreatmentSectionState();
}

class _ManageTreatmentSectionState extends State<ManageTreatmentSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SelfTreatmentPage());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: const DecorationImage(
            image: AssetImage('assets/images/treatment_banner2.png'),
            fit: BoxFit.fitHeight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: (Colors.grey[400])!,
              blurRadius: 10,
              offset: const Offset(
                0,
                3,
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Manage Selfcare",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato-Bold',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF543E7A),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
                    "Lead the way of a healthier mind",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato-Bold',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF746BA0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
