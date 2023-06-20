import 'package:any_percent_training_tracker/components/app_bar.dart';
import 'package:any_percent_training_tracker/components/drawer.dart';
import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:any_percent_training_tracker/views/log/edit_stack_list_view.dart';
import 'package:any_percent_training_tracker/views/log/sessions_list_view.dart';
// import 'package:any_percent_training_tracker/views/log/sessions_list_view.dart';
import 'package:flutter/material.dart';

class EditStackView extends StatefulWidget {
  const EditStackView({
    Key? key,
  }) : super(key: key);

  @override
  State<EditStackView> createState() => _EditStackViewState();
}

class _EditStackViewState extends State<EditStackView> {
  late GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final FirebaseCloudStorage _setsService;
  late final CloudSet _set;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _setsService = FirebaseCloudStorage();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final args = ModalRoute.of(context)!.settings.arguments as EditStackArgs;
    final stackId = args.stack.documentId;
    // final documentId = args.documentId;
    // final ownerUserId = args.ownerUserId;
    // final lift = '';
    // final sessionId = args.sessionId;

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
          stream: _setsService.allSetsByStack(
              ownerUserId: userId, stackId: stackId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  print('SNAPSHOT HAS DATA!!');
                  final allSetsByStack = snapshot.data as Iterable<CloudSet>;
                  print('all sets by stack:');
                  print(allSetsByStack);
                  print('stackId:');
                  print(stackId);
                  print('userId:');
                  print(userId);
                  return EditStacksListView(
                    sets: allSetsByStack,
                    stackId: stackId,
                    userId: userId,
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
