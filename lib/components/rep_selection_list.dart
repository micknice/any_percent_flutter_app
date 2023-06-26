import 'package:any_percent_training_tracker/providers/reps_provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

typedef RepsCallback = void Function();

class RepsSelectionListData extends StatefulWidget {
  const RepsSelectionListData({
    super.key,
    required this.validRepRangeList,
  });

  final List<String> validRepRangeList;
  @override
  State<RepsSelectionListData> createState() => _ExerciseSearchListDataState();
}

class _ExerciseSearchListDataState extends State<RepsSelectionListData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SearchableList<String>(
        initialList: widget.validRepRangeList,
        builder: (String repCount) => RepItemData(
          repCount: repCount,
        ),
        filter: (value) => widget.validRepRangeList
            .where(
              (element) => element.contains(value),
            )
            .toList(),
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
            labelText: "Select Rep Range",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16)),
      ),
    );
  }
}

class RepItemData extends StatelessWidget {
  final String repCount;
  const RepItemData({
    Key? key,
    required this.repCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<RepsProvider>(
          builder: (context, provider, child) {
            return GestureDetector(
              onTap: () {
                provider.updateReps(repCount);
                Navigator.pop(context);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.fitness_center_sharp,
                      color: Colors.yellow[700],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$repCount Reps',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no repCount is found with this name'),
      ],
    );
  }
}
