import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/self_treatment/components/create_treatment.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/self_treatment/components/view_remedies.dart';
import '../../authentication/login_auth.dart';
import '../../shared/loading.dart';
import '../../shared/resources/font_manager.dart';
import '../../shared/resources/styles_manager.dart';
import '../../shared/resources/values_manager.dart';
import '../../shared/snackbar.dart';
import '../../utils/constants.dart';

class SelfTreatmentPage extends StatefulWidget {
  const SelfTreatmentPage({super.key});

  @override
  State<SelfTreatmentPage> createState() => _SelfTreatmentPageState();
}

class _SelfTreatmentPageState extends State<SelfTreatmentPage> {
  final Stream<QuerySnapshot> _treatmentStream =
      FirebaseFirestore.instance.collection('selfcare_treatments').snapshots();

  @override
  Widget build(BuildContext context) {
    void viewTreatment(DocumentSnapshot treatment) {
      Get.to(() => ViewRemediesPage(treatment: treatment));
    }

    void showDeleteOptions(DocumentSnapshot treatment) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Do you want to delete ${treatment['treatmentName']}?',
            style: TextStyle(
              color: myDarkPurple,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('selfcare_treatments')
                      .doc(treatment.id)
                      .delete();
                  showSnackBar('Treatment deleted', context);
                  FirebaseFirestore.instance
                      .collection('treatment_remedies')
                      .where('treatmentID', isEqualTo: treatment.id)
                      .get()
                      .then((snapshot) => {
                            for (DocumentSnapshot remedy in snapshot.docs)
                              {
                                remedy.reference.delete(),
                              }
                          });
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: myDarkPurple,
                  size: AppSize.s25,
                ),
                label: Text(
                  'Yes',
                  style: getRegularStyle(
                    color: myDarkPurple,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.cancel,
                  color: myRed,
                  size: AppSize.s25,
                ),
                label: Text(
                  'Cancel',
                  style: getRegularStyle(
                    color: myDarkPurple,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: myMediumPurple,
          icon: Icon(Icons.add),
          onPressed: (() {
            Get.to(const CreateTreatmentPage());
          }),
          label: Text("Add Therapy"),
          // child: const Icon(
          //   Icons.add,
          //   color: Colors.white,
          // ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Selfcare",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Lato-Bold',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginAuthPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.home,
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: StreamBuilder(
                  stream: _treatmentStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "An error occured!",
                          style: getRegularStyle(color: myRedAccent),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Loading();
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No treatment available",
                          style: getRegularStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var treatmentData = snapshot.data!.docs[index];
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                            bottom: 8,
                          ),
                          child: Card(
                            elevation: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Text(
                                      treatmentData['treatmentName'],
                                      style: const TextStyle(
                                        color: myDarkPurple,
                                        fontFamily: 'Lato',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          treatmentData['treatmentDescription'],
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: "Expected duration: ",
                                                  style: TextStyle(
                                                    color: myMediumPurple,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: treatmentData[
                                                          'treatmentDuration']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: " min",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: "By ",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: treatmentData[
                                                      'therapistName'],
                                                  style: const TextStyle(
                                                    color: Colors.grey,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: (() {
                                        viewTreatment(treatmentData);
                                      }),
                                      child: const Text(
                                        "View",
                                        style: TextStyle(color: myDarkPurple),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: (() {
                                        showDeleteOptions(treatmentData);
                                      }),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: myRed),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
