import 'package:any_percent_training_tracker/services/auth/auth_service.dart';
import 'package:any_percent_training_tracker/views/log/sessions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:any_percent_training_tracker/models/exercise_model.dart';
import 'package:any_percent_training_tracker/services/cloud/firebase_cloud_storage_any_percent.dart';

class ExerciseSearchList extends StatefulWidget {
  const ExerciseSearchList({
    super.key,
    required this.exercises,
  });
  final List<Exercise> exercises;
  @override
  State<ExerciseSearchList> createState() => _ExerciseSearchListState();
}

class _ExerciseSearchListState extends State<ExerciseSearchList> {
  late final FirebaseCloudStorage _stacksService;

  @override
  void initState() {
    _stacksService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SearchableList<Exercise>(
        initialList: widget.exercises,
        builder: (Exercise exercise) =>
            ExerciseItem(exercise: exercise, stacksService: _stacksService),
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

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final FirebaseCloudStorage stacksService;

  const ExerciseItem(
      {Key? key, required this.exercise, required this.stacksService})
      : super(key: key);

  void createStackWithSelectedExercise(String lift, String date) async {
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    await stacksService.createNewStack(
        ownerUserId: userId, lift: lift, date: date);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewStackArgs;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          createStackWithSelectedExercise(exercise.name, args.date);
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
      ),
    );
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
