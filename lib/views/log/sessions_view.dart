import 'package:any_percent_training_tracker/components/app_bar.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_stack.dart';
import 'package:any_percent_training_tracker/views/log/sessions_list_view.dart';

class SessionsView extends StatefulWidget {
  const SessionsView({
    Key? key,
  }) : super(key: key);

  @override
  State<SessionsView> createState() => _SessionsViewState();
}

class _SessionsViewState extends State<SessionsView> {
  late GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final FirebaseCloudStorage _stacksService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _stacksService = FirebaseCloudStorage();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const tileDensity = -2.5;
    const divHeight = 1.8;
    const tileFontSize = 14.0;

    void openDrawer() {
      _scaffoldKey.currentState!.openDrawer();
    }

    return Scaffold(
      drawer: const CustomDrawer(
        tileFontSize: tileFontSize,
        divHeight: divHeight,
        tileDensity: tileDensity,
      ),
      appBar: CustomAppBar(
        title: 'Training Log',
        scaffoldKey: _scaffoldKey,
        onMenuPressed: openDrawer,
      ),
      body: StreamBuilder(
          stream: _stacksService.allStacks(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allStacks = snapshot.data as Iterable<CloudStack>;
                  return StacksListView(
                    stacks: allStacks,
                    onDeleteStack: (stack) async {
                      await _stacksService.deleteStack(
                          documentId: stack.documentId);
                    },
                    onTap: (stack) {},
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
