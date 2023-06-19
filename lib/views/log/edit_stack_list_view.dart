import 'package:any_percent_training_tracker/constants/routes.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:flutter/material.dart';
import '../../services/cloud/cloud_stack.dart';

typedef SetCallback = void Function(CloudSet set);

class EditStacksListView extends StatefulWidget {
  final Iterable<CloudSet> sets;
  final String stackId;
  final String userId;

  const EditStacksListView(
      {super.key,
      required this.sets,
      required this.stackId,
      required this.userId});

  @override
  State<EditStacksListView> createState() => _EditStacksListViewState();
}

class _EditStacksListViewState extends State<EditStacksListView> {
  late String _logDate;
  late Iterable<CloudSet> _stackSets;
  late final FirebaseCloudStorage _setsService;

  @override
  void initState() {
    _stackSets = widget.sets;
    _setsService = FirebaseCloudStorage();
    super.initState();
  }

  void deleteSet(String stackId) async {
    await _setsService.deleteStack(documentId: stackId);
  }

  void createSet(String userId, String stackId) async {
    await _setsService.createNewSet(ownerUserId: userId, stackId: stackId);
  }

  @override
  Widget build(BuildContext context) {
    final sets = widget.sets;
    print(sets);
    if (sets.isEmpty) {
      print('SETS IS EMPTY!!!');
      createSet(widget.userId, widget.stackId);
    }

    return Center(
      child: Stack(children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.sets.length,
              itemBuilder: (context, index) {
                if (sets.isNotEmpty && index < sets.length) {
                  print('SETS IS NOT EMPTY!!!');
                  final set = sets.elementAt(index);
                  return ListTile(
                    onTap: () {},
                    title: Text('item'),
                  );
                }
              },
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.small(
                onPressed: () {},
                child: const Icon(Icons.add),
              )),
        )
      ]),
    );
  }
}
