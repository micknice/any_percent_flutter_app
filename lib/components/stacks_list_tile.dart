import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';

typedef SetCallback = void Function(
    CloudSet set, String stackId, int currentStackSets);

class StackListTile extends StatefulWidget {
  final FirebaseCloudStorage setsService;
  final CloudSet set;
  final int currentStackSets;
  final SetCallback onDeleteSet;

  const StackListTile({
    Key? key,
    required this.setsService,
    required this.set,
    required this.currentStackSets,
    required this.onDeleteSet,
  }) : super(key: key);

  @override
  State<StackListTile> createState() => _StackListTileState();
}

class _StackListTileState extends State<StackListTile> {
  CloudSet? _set;
  late final FirebaseCloudStorage _setsService;
  late final TextEditingController _weight;
  late final TextEditingController _reps;

  void _saveSetIfFieldsNotEmpty() async {
    final set = _set;
    final weight = _weight.text;
    final reps = _reps.text;
    if (set != null) {
      await _setsService.updateSet(
          setId: set.documentId, weight: weight, reps: reps);
    }
  }

  Future<CloudSet> getExistingSet(BuildContext context) async {
    final widgetSet = widget.set;
    if (widgetSet != null) {
      _set = widgetSet;
      _weight.text = widgetSet.weight;
      _reps.text = widgetSet.reps;
      return widgetSet;
    }
    final existingSet = _set;
    if (existingSet != null) {
      return existingSet;
    }
    return CloudSet(
        documentId: widgetSet.documentId,
        ownerUserId: widgetSet.ownerUserId,
        lift: widgetSet.lift,
        reps: widgetSet.reps,
        stackId: widgetSet.stackId,
        weight: widgetSet.weight,
        setOrder: widgetSet.setOrder,
        date: widgetSet.date);
  }

  @override
  void initState() {
    _setsService = FirebaseCloudStorage();
    _weight = TextEditingController();
    _reps = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final set = _set;
    if (set == null) {
      return;
    }
    final weight = _weight.text;
    final reps = _reps.text;
  }

  void _setupTextControllerListener() {
    _weight.removeListener(_textControllerListener);
    _reps.removeListener(_textControllerListener);
    _weight.addListener(_textControllerListener);
    _reps.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    _saveSetIfFieldsNotEmpty();
    _weight.dispose();
    _reps.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = 10.0;
    return FutureBuilder(
      future: getExistingSet(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            _setupTextControllerListener();
            return Container(
              height: 77,
              decoration: const BoxDecoration(
                color:   Color.fromRGBO(238, 238, 238, 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 335,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10, height: 2.0),
                              onTap: () {
                                _saveSetIfFieldsNotEmpty();
                              },
                              controller: _weight,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'WEIGHT',
                                  suffixText: 'Kg',
                                  labelStyle: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold)),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10, height: 2.0),
                              onTap: () {
                                _saveSetIfFieldsNotEmpty();
                              },
                              controller: _reps,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'REPS',
                                  labelStyle: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold)),
                            )),
                            Column(
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  'Set ${widget.set.setOrder}',
                                  style: const TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _saveSetIfFieldsNotEmpty();
                                      widget.onDeleteSet(
                                          widget.set,
                                          widget.set.stackId,
                                          widget.currentStackSets);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
