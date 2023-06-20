import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_stack.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_set.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_constants.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final stacks = FirebaseFirestore.instance.collection('stacks');
  final sets = FirebaseFirestore.instance.collection('sets');

  //stack
  Future<void> deleteStack({required String documentId}) async {
    try {
      await stacks.doc(documentId).delete();
      final querySnapshot =
          await sets.where(stackIdField, isEqualTo: documentId).get();
      for (final document in querySnapshot.docs) {
        await document.reference.delete();
      }
    } catch (e) {
      throw CouldNotDeleteStackException();
    }
  }

  Future<void> updateStack({
    required String documentId,    
    required String setCount,
  }) async {
    try {
      await stacks.doc(documentId).update({
        setCountField: setCount,
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

  Stream<Iterable<CloudStack>> allStacksByDate(
      {required String ownerUserId, required String date}) {
    final allStacks = stacks
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .where(dateField, isEqualTo: date)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudStack.fromSnapshot(doc)));
    return allStacks;
  }

  Stream<Iterable<CloudStack>> allStacksByDateAndLift(
      {required String ownerUserId,
      required String date,
      required String lift}) {
    final allStacks = stacks
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .where(dateField, isEqualTo: date)
        .where(liftField, isEqualTo: lift)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudStack.fromSnapshot(doc)));
    return allStacks;
  }

  Future<CloudStack> createNewStack({
    required String ownerUserId,
    required String lift,
    required String date,
  }) async {
    final document = await stacks.add({
      ownerUserIdField: ownerUserId,
      liftField: lift,
      dateField: date,
      setCountField: '',
    });

    final fetchedStack = await document.get();
    return CloudStack(
      documentId: fetchedStack.id,
      ownerUserId: ownerUserIdField,
      lift: liftField,
      date: dateField,
      setCount: setCountField,
    );
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
    required String setOrder,
  }) async {
    try {
      await sets.doc(documentId).update({
        repsField: reps,
        weightField: weight,
        setOrderField: setOrder,
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

  Stream<Iterable<CloudSet>> allSetsByStack(
      {required String ownerUserId, required String stackId}) {
    final allSets = sets
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .where(stackIdField, isEqualTo: stackId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudSet.fromSnapshot(doc)));
    return allSets;
  }

  Future<CloudSet> createNewSet(
      {required String ownerUserId,
      required String stackId,
      required String setOrder}) async {
    final document = await sets.add({
      ownerUserIdField: ownerUserId,
      stackIdField: stackId,
      liftField: '',
      repsField: '',
      weightField: '',
      setOrderField: setOrder,
    });
    final fetchedSet = await document.get();
    return CloudSet(
      documentId: fetchedSet.id,
      ownerUserId: ownerUserId,
      lift: '',
      stackId: stackId,
      reps: '',
      weight: '',
      setOrder: '',
    );
  }

  Future<CloudSet> createFirstSet(
      {required String ownerUserId, required String stackId}) async {
    final document = await sets.add({
      ownerUserIdField: ownerUserId,
      stackIdField: stackId,
      liftField: '',
      repsField: '',
      weightField: '',
      setOrderField: '0'
    });
    final fetchedSet = await document.get();
    return CloudSet(
      documentId: fetchedSet.id,
      ownerUserId: ownerUserId,
      lift: '',
      stackId: stackId,
      reps: '',
      weight: '',
      setOrder: setOrderField,
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
