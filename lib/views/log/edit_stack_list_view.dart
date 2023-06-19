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
  late int _stackSets;
  late final FirebaseCloudStorage _setsService;

  @override
  void initState() {
    _stackSets = widget.sets.length;
    _setsService = FirebaseCloudStorage();
    super.initState();
  }

  void deleteSet(String stackId) async {
    await _setsService.deleteStack(documentId: stackId);
  }

  Future<CloudSet> createSet(
      String userId, String stackId, String setOrder) async {
    final newSet = await _setsService.createNewSet(
        ownerUserId: userId, stackId: stackId, setOrder: setOrder);
    return newSet;
  }

  Future<CloudSet> createFirstSet(String userId, String stackId) async {
    final newSet = await _setsService.createFirstSet(
        ownerUserId: userId, stackId: stackId);
    return newSet;
  }

  @override
  Widget build(BuildContext context) {
    final sets = widget.sets;
    print(sets);
    if (sets.isEmpty) {
      print('SETS IS EMPTY!!!');
      final newSet = createFirstSet(widget.userId, widget.stackId);
      setState(() {
        print('-stacksets preIncrement create firstSet');
        print(_stackSets);
        _stackSets += 1;
        print('-stacksets postIncrement create firstSet');
        print(_stackSets);
      });
    } else {}

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
                onPressed: () {
                  print('widget.sets.length at newSet preCreation');
                  print(widget.sets.length);
                  print('_stackSets at newSet preCreation');
                  print(_stackSets);
                  createSet(
                    widget.userId,
                    widget.stackId,
                    _stackSets.toString(),
                  );
                  setState(() {
                    _stackSets += 1;
                  });
                  print('widget.sets.length at newSet postCreation');
                  print(widget.sets.length);
                  print('_stackSets at newSet postCreation');
                  print(_stackSets);
                },
                child: const Icon(Icons.add),
              )),
        )
      ]),
    );
  }
}
