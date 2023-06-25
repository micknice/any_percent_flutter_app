import 'package:flutter/foundation.dart';

class ExerciseProvider extends ChangeNotifier {
  String _exercise = 'Barbell Bench Press';

  void updateExercise(String exercise) {
    _exercise = exercise;
    notifyListeners();
  }

  String get exercise => _exercise;
}
