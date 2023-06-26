import 'package:any_percent_training_tracker/components/exercise_search_list.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:any_percent_training_tracker/components/exercise_search_list_data.dart';
import 'package:any_percent_training_tracker/components/rep_selection_list.dart';
import 'package:any_percent_training_tracker/constants/exercises.dart';
import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/views/log_view/sessions_list_view.dart';
import 'package:flutter/material.dart';

class RepsSelectionViewData extends StatefulWidget {
  const RepsSelectionViewData({Key? key}) : super(key: key);

  @override
  State<RepsSelectionViewData> createState() => _RepsSelectionViewDataState();
}

class _RepsSelectionViewDataState extends State<RepsSelectionViewData> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validRepRangeList = ModalRoute.of(context)!.settings.arguments as List<String>;
    const tileDensity = -2.5;
    const divHeight = 1.8;
    const tileFontSize = 14.0;

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
      body: RepsSelectionListData(validRepRangeList: validRepRangeList,),
    );
  }
}
