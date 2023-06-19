import 'package:any_percent_training_tracker/constants/routes.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import '../../services/cloud/cloud_stack.dart';

typedef StackCallback = void Function(CloudStack stack);

class StacksListView extends StatefulWidget {
  final Iterable<CloudStack> stacks;
  final StackCallback onDeleteStack;
  final StackCallback onTap;

  const StacksListView({
    super.key,
    required this.stacks,
    required this.onDeleteStack,
    required this.onTap,
  });

  @override
  State<StacksListView> createState() => _StacksListViewState();
}

class _StacksListViewState extends State<StacksListView> {
  late String _logDate;
  late Iterable<CloudStack> _sessionStacks;
  late final FirebaseCloudStorage _stacksService;
  late DateTime _selectedDate;

  @override
  void initState() {
    _sessionStacks = widget.stacks;
    _stacksService = FirebaseCloudStorage();
    final currentDateTime = DateTime.now();
    _logDate =
        '${currentDateTime.year}-${currentDateTime.month}-${currentDateTime.day}';
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  void deleteStack(String stackId) async {
    await _stacksService.deleteStack(documentId: stackId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          CalendarTimeline(
            showYears: false,
            initialDate: _selectedDate,
            firstDate: DateTime.utc(2023, 1, 1),
            lastDate: DateTime.utc(2050, 1, 1),
            onDateSelected: (date) {
              final currentDate = '${date.year}-${date.month}-${date.day}';
              setState(() {
                _selectedDate = date;
                _logDate = currentDate;
              });
            },
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            locale: 'en_ISO',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.stacks.length,
              itemBuilder: (context, index) {
                final stacksFilteredByDate =
                    widget.stacks.where((element) => element.date == _logDate);

                if (stacksFilteredByDate.isNotEmpty &&
                    index < stacksFilteredByDate.length) {
                  final stack = stacksFilteredByDate.elementAt(index);
                  return ListTile(
                    onTap: () {
                      widget.onTap(stack);
                    },
                    title: Text(stack.lift),
                    subtitle: Row(children: [
                      const Text('sets'),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {
                                    deleteStack(stack.documentId);
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ))
                    ]),
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
                    final stacksFilteredByDate = widget.stacks
                        .where((element) => element.date == _logDate);
                    _sessionStacks = stacksFilteredByDate;
                  });
                  Navigator.of(context).pushNamed(exerciseSearchViewRoute,
                      arguments: NewStackArgs(_logDate, _sessionStacks));
                },
                child: const Icon(Icons.add),
              )),
        )
      ]),
    );
  }
}

class NewStackArgs {
  final String date;
  final Iterable<CloudStack> sessionStacks;

  NewStackArgs(this.date, this.sessionStacks);
}
