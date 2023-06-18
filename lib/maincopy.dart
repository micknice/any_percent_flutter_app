import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'components/app_bar.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';
import 'package:any_percent_training_tracker/constants/exercises.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'models/exercise_model.dart';
import 'package:any_percent_training_tracker/components/basic_search_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    const tileDensity = -2.5;
    const divHeight = 1.8;
    const tileFontSize = 14.0;
    final exercises = seedExercises;

    void openDrawer() {
      _scaffoldKey.currentState!.openDrawer();
    }

    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          drawer: const CustomDrawer(
              tileFontSize: tileFontSize,
              divHeight: divHeight,
              tileDensity: tileDensity),
          appBar: CustomAppBar(title: 'Home',
              scaffoldKey: _scaffoldKey, onMenuPressed: openDrawer),
          body: BasicSearchList(exercises: exercises)),
    );
  }
}
