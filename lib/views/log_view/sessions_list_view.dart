import 'package:any_percent_training_tracker/constants/routes.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_stack.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/carbon_fibre_texture.jpg'))),
      child: Center(
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
              dotsColor: const Color(0xFF333A47),
              locale: 'en_ISO',
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.stacks.length,
                itemBuilder: (context, index) {
                  final stacksFilteredByDate = widget.stacks
                      .where((element) => element.date == _logDate);
                  if (stacksFilteredByDate.isNotEmpty &&
                      index < stacksFilteredByDate.length) {
                    final stack = stacksFilteredByDate.elementAt(index);
                    return Dismissible(
                      key: Key(stack.lift),
                      onDismissed: (direction) {
                        deleteStack(stack.documentId);
                      },
                      background: Container(),
                      child: Card(
                        color: Colors.transparent,
                        shape: const ContinuousRectangleBorder(),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(95, 95, 95, 0.212),
                            // image: DecorationImage(
                            //   opacity: 0.3,
                            //   fit: BoxFit.cover,
                            //   image: NetworkImage(
                            //       'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/eb6ef061-447e-4136-8a39-06fafccb861d/d24t45p-49aba1d3-cb6e-49e4-a40e-23f10d0f1243.jpg/v1/fill/w_600,h_405,q_75,strp/white_diamond_plate_by_enframed_d24t45p-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NDA1IiwicGF0aCI6IlwvZlwvZWI2ZWYwNjEtNDQ3ZS00MTM2LThhMzktMDZmYWZjY2I4NjFkXC9kMjR0NDVwLTQ5YWJhMWQzLWNiNmUtNDllNC1hNDBlLTIzZjEwZDBmMTI0My5qcGciLCJ3aWR0aCI6Ijw9NjAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.6rM1TWatwxKQGlz1ldGgVmCZBOcjaU6raUTVP3sEJys'),
                            // ),
                          ),
                          child: ListTile(
                            tileColor: Color.fromARGB(59, 93, 93, 93),
                            shape: const ContinuousRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            onTap: () {
                              widget.onTap(stack);
                            },
                            title: Text(
                              stack.lift,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Sets: ${stack.setCount}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      deleteStack(stack.documentId);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          editStackViewRoute,
                                          arguments: EditStackArgs(stack));
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.white)),
                              ],
                            ),
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
      ),
    );
  }
}

class NewStackArgs {
  final String date;
  final Iterable<CloudStack> sessionStacks;
  NewStackArgs(this.date, this.sessionStacks);
}

class EditStackArgs {
  final CloudStack stack;

  EditStackArgs(this.stack);
}
