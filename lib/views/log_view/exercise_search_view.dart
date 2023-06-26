import 'package:any_percent_training_tracker/components/exercise_search_list.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:any_percent_training_tracker/constants/exercises.dart';
import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/views/log_view/sessions_list_view.dart';
import 'package:flutter/material.dart';

class ExerciseSearchView extends StatefulWidget {
  const ExerciseSearchView({Key? key}) : super(key: key);

  @override
  State<ExerciseSearchView> createState() => _ExerciseSearchViewState();
}

class _ExerciseSearchViewState extends State<ExerciseSearchView> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewStackArgs;
    final sessionStacks = args.sessionStacks;

    const tileDensity = -2.5;
    const divHeight = 1.8;
    const tileFontSize = 14.0;
    final exercises = seedExercises.where((exercise) {
      return !sessionStacks.any((stack) => stack.lift == exercise.name);
    }).toList();

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
      body: ExerciseSearchList(exercises: exercises),
    );
  }
}
