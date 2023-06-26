import 'package:flutter/foundation.dart';

class RepsProvider extends ChangeNotifier {
  String _reps = 'All';

  void updateReps(String reps) {
    _reps = reps;
    notifyListeners();
  }

  String get reps => _reps;
}


