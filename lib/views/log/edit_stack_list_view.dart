import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/constants/routes.dart';

typedef SetCallback = void Function(CloudSet set);

class EditStacksListView extends StatefulWidget {
  final Iterable<CloudSet> sets;
  final String stackId;
  final String userId;

  const EditStacksListView({
    super.key,
    required this.sets,
    required this.stackId,
    required this.userId,
  });

  @override
  State<EditStacksListView> createState() => _EditStacksListViewState();
}

class _EditStacksListViewState extends State<EditStacksListView> {
  late int _stackSets;
  late final FirebaseCloudStorage _setsService;

  @override
  void initState() {
    _stackSets = widget.sets.length;
    _setsService = FirebaseCloudStorage();
    super.initState();
  }

  void deleteSet(String setId) async {
    print('deleteMethod invoked');
    await _setsService.deleteSet(documentId: setId);
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

  void updateStack(String stackId, String setCount) async {
    await _setsService.updateStack(documentId: stackId, setCount: setCount);
  }

  void updateSetOrderOnDeleteSet(String stackId, String deletedOrder) async {
    await _setsService.updateSetOrder(
        stackId: stackId, deletedOrder: deletedOrder);
  }

  @override
  Widget build(BuildContext context) {
    final setsList = widget.sets;
    List<CloudSet> sets = List.from(setsList);
    sets.sort((a, b) => int.parse(a.setOrder).compareTo(int.parse(b.setOrder)));
    if (sets.isEmpty) {
      createFirstSet(widget.userId, widget.stackId);
      setState(() {
        _stackSets += 1;
      });
      updateStack(widget.stackId, _stackSets.toString());
    } else {}

    return Center(
      child: Stack(children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.sets.length,
              itemBuilder: (context, index) {
                if (sets.isNotEmpty && index < sets.length) {
                  final set = sets.elementAt(index);
                  return Dismissible(
                    key: Key(set.setOrder),
                    onDismissed: (direction) {
                      final deletedSetId = set.documentId;
                      final deletedSetStackId = set.stackId;
                      final deletedSetOrder = set.stackId;
                      print('sets.length pre deletion');
                      print(sets.length);
                      deleteSet(deletedSetId);
                      setState(() {
                        _stackSets -= 1;
                      });
                      updateSetOrderOnDeleteSet(
                          deletedSetStackId, deletedSetOrder);

                      updateStack(widget.stackId, _stackSets.toString());
                      print('sets.length post deletion');
                      print(sets.length);
                    },
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text('Set ${index + 1}'),
                        subtitle:  Text(set.documentId),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  final deletedSetId = set.documentId;
                                  final deletedSetStackId = set.stackId;
                                  final deletedSetOrder = set.stackId;
                                  deleteSet(deletedSetId);
                                  setState(() {
                                    _stackSets -= 1;
                                  });
                                  updateSetOrderOnDeleteSet(
                                      deletedSetStackId, deletedSetOrder);
                                  updateStack(
                                      widget.stackId, _stackSets.toString());
                                },
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(editSetViewRoute);
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    ),
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
                  setState(() {
                    _stackSets += 1;
                  });
                  createSet(
                    widget.userId,
                    widget.stackId,
                    _stackSets.toString(),
                  );
                  updateStack(widget.stackId, _stackSets.toString());
                },
                child: const Icon(Icons.add),
              )),
        )
      ]),
    );
  }
}
