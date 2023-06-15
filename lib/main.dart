import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'components/app_bar.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:getwidget/components/floating_widget/gf_floating_widget.dart';

void main() {
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
        appBar:
            CustomAppBar(scaffoldKey: _scaffoldKey, onMenuPressed: openDrawer),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: [
              CalendarTimeline(

                
                showYears: true,
                initialDate: DateTime.now(),
                firstDate: DateTime.utc(2023, 1, 1),
                lastDate: DateTime.utc(2050, 1, 1),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: Colors.blueGrey,
                dayColor: Colors.teal[200],
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.redAccent[100],
                dotsColor: Color(0xFF333A47),
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
                
              ),
              SingleChildScrollView(
                child:  Column(
                  children: [
                     ListView(children: const [ListTile(title: Text('example'),)],)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
