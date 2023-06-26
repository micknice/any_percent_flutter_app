import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';

double formatDate(String dateString) {
  print('FORMAT DATE INVOKED');
  List<String> parts = dateString.split('-');
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);
  print('PARSED');

  String formattedMonth = month.toString().padLeft(2, '0');
  String formattedDay = day.toString().padLeft(2, '0');

  String formattedDate = '$year$formattedMonth$formattedDay';
  print('FORMATTED');

  return double.parse(formattedDate);
}

List<FlSpot> getMaxWeightOnDate(List<CloudSet> sets) {
  print('GET MAX WEIGHT INVOKED');
  final maxWeights = <double, double>{};

  for (final set in sets) {
    final date = formatDate(set.date);
    final weight = double.tryParse(set.weight) ?? 0.0;

    if (maxWeights.containsKey(date)) {
      // Update the maximum weight if the current weight is greater
      if (weight > maxWeights[date]!) {
        maxWeights[date] = weight;
      }
    } else {
      // Add the date and weight to the map if it doesn't exist
      maxWeights[date] = weight;
    }
  }
  print('POST MAX LOOP');
  
  

  return maxWeights.entries
      .map((entry) => FlSpot(entry.key, entry.value))
      .toList();
}

List<String> getUniqueReps(List<CloudSet> cloudSets) {
  Set<String> uniqueReps = {};

  for (var cloudSet in cloudSets) {
    uniqueReps.add(cloudSet.reps);
  }

  return uniqueReps.toList();
}



