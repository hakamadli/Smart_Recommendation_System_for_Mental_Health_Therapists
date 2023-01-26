import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/shared/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../shared/resources/styles_manager.dart';
import '../../../utils/constants.dart';

class DASStatsChart extends StatefulWidget {
  const DASStatsChart({Key? key}) : super(key: key);

  @override
  State<DASStatsChart> createState() => _DASStatsChartState();
}

class _DASStatsChartState extends State<DASStatsChart> {
  final user = FirebaseAuth.instance.currentUser!;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final yearNow = DateTime.now().year;
  final dasRef = FirebaseFirestore.instance.collection('mental_statistics');
  final Stream<QuerySnapshot> dasStream =
      FirebaseFirestore.instance.collection('mental_statistics').snapshots();
  final Stream<DocumentSnapshot> dasDoc = FirebaseFirestore.instance
      .collection('mental_statistics')
      .doc()
      .snapshots();

  var teenWithDepression;
  var teenWithAnxiety;
  var teenWithStress;
  var youngAdultWithDepression;
  var youngAdultWithAnxiety;
  var youngAdultWithStress;
  var adultWithDepression;
  var adultWithAnxiety;
  var adultWithStress;

  Future getDASStats() async {
    try {
      var depressionSnapshot =
          await dasRef.doc('depressionStats_$yearNow').get();
      var anxietySnapshot = await dasRef.doc('anxietyStats_$yearNow').get();
      var stressSnapshot = await dasRef.doc('stressStats_$yearNow').get();
      setState(() {
        teenWithDepression = depressionSnapshot.get('teenWithDepression');
        youngAdultWithDepression =
            depressionSnapshot.get('youngAdultWithDepression');
        adultWithDepression = depressionSnapshot.get('adultWithDepression');
        teenWithAnxiety = anxietySnapshot.get('teenWithAnxiety');
        youngAdultWithAnxiety = anxietySnapshot.get('youngAdultWithAnxiety');
        adultWithAnxiety = anxietySnapshot.get('adultWithAnxiety');
        teenWithStress = stressSnapshot.get('teenWithStress');
        youngAdultWithStress = stressSnapshot.get('youngAdultWithStress');
        adultWithStress = stressSnapshot.get('adultWithStress');
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    teenWithDepression = 0;
    teenWithAnxiety = 0;
    teenWithStress = 0;
    youngAdultWithDepression = 0;
    youngAdultWithAnxiety = 0;
    youngAdultWithStress = 0;
    adultWithDepression = 0;
    adultWithAnxiety = 0;
    adultWithStress = 0;
    getDASStats();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData('Depression', teenWithDepression, youngAdultWithDepression,
          adultWithDepression),
      ChartData(
          'Anxiety', teenWithAnxiety, youngAdultWithAnxiety, adultWithAnxiety),
      ChartData(
          'Stress', teenWithStress, youngAdultWithStress, adultWithStress),
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: StreamBuilder<QuerySnapshot>(
        stream: dasStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "En error occured!",
                style: getRegularStyle(color: myRedAccent),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Loading(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Text(
                  "Statistics ($yearNow)",
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Lato-Bold',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF543E7A),
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: SfCartesianChart(
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        // legendItemBuilder: (String name, dynamic series,
                        //     dynamic point, int index) {
                        //   return Text("data");
                        // },
                      ),
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          enableTooltip: true,
                          name: 'Teenager',
                        ),
                        ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1,
                          enableTooltip: true,
                          name: 'Young Adult',
                        ),
                        ColumnSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y2,
                          enableTooltip: true,
                          name: 'Adult',
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          );
        },
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final int? y;
  final int? y1;
  final int? y2;
}
