import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_session.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_stack.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_constants.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');
  final jobs = FirebaseFirestore.instance.collection('jobs');

  final sessions = FirebaseFirestore.instance.collection('sessions');
  final stacks = FirebaseFirestore.instance.collection('stacks');
  final sets = FirebaseFirestore.instance.collection('sets');

  //session

  Future<void> deleteSession({required String documentId}) async {
    try {
      await sessions.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteSessionException();
    }
  }

  Future<void> updateSession({
    required String documentId,
    required String date,
  }) async {
    try {
      await sessions.doc(documentId).update({
        dateField: date,
      });
    } catch (e) {
      throw CouldNotUpdateSessionException();
    }
  }

  Stream<Iterable<CloudSession>> allSessions({required String ownerUserId}) {
    final allSessions = sessions
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .snapshots()
        .map(
            (event) => event.docs.map((doc) => CloudSession.fromSnapshot(doc)));
    return allSessions;
  }

  Future<CloudSession> createNewSession({required String ownerUserId}) async {
    final document = await jobs.add({
      ownerUserIdField: ownerUserId,
      dateField: DateTime.utc,
    });
    final fetchedSession = await document.get();
    return CloudSession(
      documentId: fetchedSession.id,
      ownerUserId: ownerUserId,
      date: '',
    );
  }

  //stack
  Future<void> deleteStack({required String documentId}) async {
    try {
      await stacks.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteStackException();
    }
  }

  Future<void> updateStack({
    required String documentId,
    required String date,
  }) async {
    try {
      await stacks.doc(documentId).update({
        dateField: date,
      });
    } catch (e) {
      throw CouldNotUpdateStackException();
    }
  }

  Stream<Iterable<CloudStack>> allStacks({required String ownerUserId}) {
    final allStacks = stacks
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudStack.fromSnapshot(doc)));
    return allStacks;
  }

  Future<CloudStack> createNewStack(
      {required String ownerUserId, required String lift}) async {
    final currentDateTime = DateTime.now();
    final currentDate =
        '${currentDateTime.year}-${currentDateTime.month}-${currentDateTime.day}';
    final document = await stacks.add({
      ownerUserIdField: ownerUserId,
      liftField: lift,
      dateField: currentDate,
    });
    final fetchedStack = await document.get();
    return CloudStack(
        documentId: fetchedStack.id,
        ownerUserId: ownerUserIdField,
        lift: liftField,
        date: dateField);
  }

  // sets
  Future<void> deleteSet({required String documentId}) async {
    try {
      await sets.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteSetException();
    }
  }

  Future<void> updateSet({
    required String documentId,
    required String reps,
    required String weight,
  }) async {
    try {
      await sets.doc(documentId).update({
        repsField: reps,
        weightField: weight,
      });
    } catch (e) {
      throw CouldNotUpdateSetException();
    }
  }

  Stream<Iterable<CloudSet>> allSets({required String ownerUserId}) {
    final allSets = sets
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudSet.fromSnapshot(doc)));
    return allSets;
  }

  Future<CloudSet> createNewSet(
      {required String ownerUserId, required String stackId}) async {
    final document = await sets.add({
      ownerUserIdField: ownerUserId,
      stackIdField: stackId,
      liftField: '',
      repsField: '',
      weightField: ''
    });
    final fetchedSet = await document.get();
    return CloudSet(
      documentId: fetchedSet.id,
      ownerUserId: ownerUserId,
      lift: '',
      stackId: stackId,
      reps: '',
      weight: '',
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
