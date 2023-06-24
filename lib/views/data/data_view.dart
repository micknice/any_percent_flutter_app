import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:any_percent_training_tracker/utils/data_helpers/util_funcs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
// import 'package:any_percent_training_tracker/utils/data_helpers/util_funcs.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  late final FirebaseCloudStorage _setsService;
  late final CloudSet _set;
  String get userId => AuthService.firebase().currentUser!.id;
  final String _lift = 'Barbell Bench Press';

  @override
  void initState() {
    _setsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _setsService.allSets(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allSets = snapshot.data as Iterable<CloudSet>;
                  final List<CloudSet> setsByLift = allSets
                      .where((element) => element.lift == _lift)
                      .toList();

                  setsByLift.sort((a, b) => a.date.compareTo(b.date));

                  final maxWeightOnDate = getMaxWeightOnDate(setsByLift);
                  print('maxweight[0].x');
                  print(maxWeightOnDate[0].x);

                  final length = maxWeightOnDate.length;
                  final double minX = maxWeightOnDate[0].x;
                  final double maxX = maxWeightOnDate[length - 1].x;
                  const double minY = 0;
                  const double maxY = 300;
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineChart(LineChartData(
                              gridData: const FlGridData(
                                  show: true,
                                  horizontalInterval: 50,
                                  verticalInterval: 1),
                              titlesData: const FlTitlesData(
                                show: true,
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles:
                                      SideTitles(showTitles: true, interval: 1),
                                ),
                              ),
                              minX: minX,
                              maxX: maxX,
                              minY: minY,
                              maxY: maxY,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [...maxWeightOnDate],
                                )
                              ])),
                        ),
                      )
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
