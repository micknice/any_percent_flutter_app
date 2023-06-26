import 'package:any_percent_training_tracker/providers/exercise_provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:any_percent_training_tracker/models/exercise_model.dart';

typedef ExerciseCallback = void Function();

class ExerciseSearchListData extends StatefulWidget {
  const ExerciseSearchListData({
    super.key,
    required this.exercises,
  });
  final List<Exercise> exercises;
  @override
  State<ExerciseSearchListData> createState() => _ExerciseSearchListDataState();
}

class _ExerciseSearchListDataState extends State<ExerciseSearchListData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SearchableList<Exercise>(
        initialList: widget.exercises,
        builder: (Exercise exercise) => ExerciseItemData(
          exercise: exercise,
        ),
        filter: (value) => widget.exercises
            .where(
              (element) => element.name.toLowerCase().contains(value),
            )
            .toList(),
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
            labelText: "Search Exercise",
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

class ExerciseItemData extends StatelessWidget {
  final Exercise exercise;

  const ExerciseItemData({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ExerciseProvider>(
          builder: (context, provider, child) {
            return GestureDetector(
              onTap: () {
                provider.updateExercise(exercise.name);
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
                          exercise.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          exercise.bodyPart,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          exercise.movementType,
                          style: const TextStyle(
                            color: Colors.black,
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
        Text('no exercise is found with this name'),
      ],
    );
  }
}
