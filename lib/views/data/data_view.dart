import 'package:any_percent_training_tracker/constants/routes.dart';
import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:any_percent_training_tracker/utils/data_helpers/util_funcs.dart';
import 'package:any_percent_training_tracker/exercise_provider_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:provider/provider.dart';
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
  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _setsService = FirebaseCloudStorage();
    super.initState();
  }

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseProvider>(builder: (context, provider, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(provider.exercise),
        ),
        body: StreamBuilder(
            stream: _setsService.allSets(ownerUserId: userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allSets = snapshot.data as Iterable<CloudSet>;
                    final List<CloudSet> setsByLift = allSets
                        .where((element) => element.lift == provider.exercise)
                        .toList();
                    setsByLift.sort((a, b) => a.date.compareTo(b.date));
                    final maxWeightOnDate = getMaxWeightOnDate(setsByLift);
                    final length = maxWeightOnDate.length;
                    final double minX = maxWeightOnDate[0].x;
                    final double maxX = maxWeightOnDate[length - 1].x;
                    const double minY = 0;
                    const double maxY = 300;
                    List<Color> gradientColors = [
                      Colors.blueGrey,
                      Colors.blueGrey
                    ];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                const Text('LIFT'),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          exerciseSearchViewDataRoute);
                                    },
                                    icon:
                                        const Icon(Icons.fitness_center_sharp)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('REPS'),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          repsSelectionViewDataRoute);
                                    },
                                    icon: const Icon(Icons.dynamic_feed)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 300,
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
                                    sideTitles: SideTitles(
                                        showTitles: false, interval: 1),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(color: Colors.black),
                                ),
                                minX: minX,
                                maxX: maxX,
                                minY: minY,
                                maxY: maxY,
                                lineBarsData: [
                                  LineChartBarData(
                                      spots: [...maxWeightOnDate],
                                      isCurved: false,
                                      belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                              colors: gradientColors)))
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
    });
  }
}
