import 'package:any_percent_training_tracker/components/exercise_search_list.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:any_percent_training_tracker/components/exercise_search_list_data.dart';
import 'package:any_percent_training_tracker/constants/exercises.dart';
import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/views/log/sessions_list_view.dart';
import 'package:flutter/material.dart';

class ExerciseSearchViewData extends StatefulWidget {
  const ExerciseSearchViewData({Key? key}) : super(key: key);

  @override
  State<ExerciseSearchViewData> createState() => _ExerciseSearchViewDataState();
}

class _ExerciseSearchViewDataState extends State<ExerciseSearchViewData> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String get userId => AuthService.firebase().currentUser!.id;
  late final _lift;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const tileDensity = -2.5;
    const divHeight = 1.8;
    const tileFontSize = 14.0;
    final exercises = seedExercises;

    // void openDrawer() {
    //   // print(_scaffoldKey);
    //   // _scaffoldKey.currentState!.openDrawer();
    // }

    return Scaffold(
      drawer: const CustomDrawer(
        tileFontSize: tileFontSize,
        divHeight: divHeight,
        tileDensity: tileDensity,
      ),
      // appBar: CustomAppBar(
      //   title: 'Add an Exercise',
      //   scaffoldKey: _scaffoldKey,
      //   onMenuPressed: openDrawer,
      // ),
      body: ExerciseSearchListData(exercises: exercises),
    );
  }
}
