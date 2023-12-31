import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/components/stacks_list_tile.dart';

typedef SetCallback = void Function(CloudSet set);

class EditStacksListView extends StatefulWidget {
  final Iterable<CloudSet> sets;
  final String stackId;
  final String userId;
  final String lift;
  final String date;

  const EditStacksListView(
      {super.key,
      required this.sets,
      required this.stackId,
      required this.userId,
      required this.lift,
      required this.date});

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
    await _setsService.deleteSet(documentId: setId);
  }

  Future<CloudSet> createSet(
    String userId,
    String stackId,
    String setOrder,
    String lift,
    String date,
  ) async {
    final newSet = await _setsService.createNewSet(
        ownerUserId: userId,
        stackId: stackId,
        setOrder: setOrder,
        lift: lift,
        date: date);
    return newSet;
  }

  Future<CloudSet> createFirstSet(
    String userId,
    String stackId,
    String lift,
    String date,
  ) async {
    final newSet = await _setsService.createFirstSet(
        ownerUserId: userId, stackId: stackId, lift: lift, date: date);
    return newSet;
  }

  void updateStack(String stackId, String setCount) async {
    await _setsService.updateStack(documentId: stackId, setCount: setCount);
  }

  void updateSetOrderOnDeleteSet(String stackId, String deletedOrder) async {
    await _setsService.updateSetOrder(
        stackId: stackId, deletedOrder: deletedOrder);
  }

  void onDeleteSet(CloudSet set, String stackId, int stacksets) async {
    final deletedSetId = set.documentId;
    final deletedSetStackId = set.stackId;
    final deletedSetOrder = set.setOrder;
    deleteSet(deletedSetId);
    setState(() {
      _stackSets -= 1;
    });
    updateSetOrderOnDeleteSet(deletedSetStackId, deletedSetOrder);
    updateStack(widget.stackId, _stackSets.toString());
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = 0;
    final setsList = widget.sets;
    List<CloudSet> sets = List.from(setsList);
    sets.sort((a, b) => int.parse(a.setOrder).compareTo(int.parse(b.setOrder)));
    if (sets.isEmpty) {
      createFirstSet(
        widget.userId,
        widget.stackId,
        widget.lift,
        widget.date,
      );
      setState(() {
        _stackSets += 1;
      });
      updateStack(widget.stackId, _stackSets.toString());
    } else {}

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
              image: AssetImage('assets/carbon_fibre_texture.jpg'))),
      child: Center(
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
                        final deletedSetOrder = set.setOrder;
                        deleteSet(deletedSetId);
                        setState(() {
                          _stackSets -= 1;
                        });
                        updateSetOrderOnDeleteSet(
                            deletedSetStackId, deletedSetOrder);
                        updateStack(widget.stackId, _stackSets.toString());
                      },
                      child: Card(shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
                        
                        color: const Color.fromARGB(59, 93, 93, 93),
                          child: StackListTile(
                        setsService: _setsService,
                        set: set,
                        currentStackSets: _stackSets,
                        onDeleteSet: onDeleteSet,
                      )),
                    );
                  }
                  // else {
                  //   return const CircularProgressIndicator();
                  // }
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
                      widget.lift,
                      widget.date,
                    );
                    updateStack(widget.stackId, _stackSets.toString());
                  },
                  child: const Icon(Icons.add),
                )),
          )
        ]),
      ),
    );
  }
}
