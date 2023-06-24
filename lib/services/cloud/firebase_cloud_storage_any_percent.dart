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

  Stream<Iterable<CloudStack>> allStacksByDateAndLift({
    required String ownerUserId,
    required String date,
    required String lift,
  }) {
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
    required String setId,
    required String weight,
    required String reps,
  }) async {
    try {
      await sets.doc(setId).update({
        weightField: weight,
        repsField: reps,
      });
    } catch (e) {
      throw CouldNotUpdateStackException();
    }
  }

  Future<void> updateSetOrder({
    required String stackId,
    required String deletedOrder,
  }) async {
    try {
      final QuerySnapshot snapshot = await sets
          .where('stackId', isEqualTo: stackId)
          .where('setOrder', isGreaterThan: deletedOrder)
          .get();

      final List<Future<void>> updateOperations = [];

      for (final DocumentSnapshot doc in snapshot.docs) {
        final dynamic data = doc.data();
        final String? currentOrder = data?['setOrder'] as String?;

        if (currentOrder != null) {
          final int newOrder = int.parse(currentOrder) - 1;
          final String newOrderString = newOrder.toString();

          updateOperations.add(
            doc.reference.update({'setOrder': newOrderString}),
          );
        }
      }

      await Future.wait(updateOperations);
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
  Stream<Iterable<CloudSet>> allSetsByLift(
      {required String ownerUserId, required String lift}) {
    final allSets = sets
        .where(ownerUserIdField, isEqualTo: ownerUserId)
        .where(liftField, isEqualTo: lift)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudSet.fromSnapshot(doc)));
    return allSets;
  }

  Future<CloudSet> createNewSet({
    required String ownerUserId,
    required String stackId,
    required String setOrder,
    required String lift,
    required String date,
  }) async {
    
    final document = await sets.add({
      ownerUserIdField: ownerUserId,
      stackIdField: stackId,
      liftField: lift,
      repsField: '',
      weightField: '',
      setOrderField: setOrder,
      dateField: date
    });
    final fetchedSet = await document.get();
    return CloudSet(
      documentId: fetchedSet.id,
      ownerUserId: ownerUserId,
      lift: lift,
      stackId: stackId,
      reps: '',
      weight: '',
      setOrder: '',
      date: '',
    );
  }

  Future<CloudSet> createFirstSet({
    required String ownerUserId,
    required String stackId,
    required String lift,
    required String date,
  }) async {
    
    final document = await sets.add({
      ownerUserIdField: ownerUserId,
      stackIdField: stackId,
      liftField: lift,
      repsField: '',
      weightField: '',
      setOrderField: '1',
      dateField: date,
    });
    final fetchedSet = await document.get();
    return CloudSet(
      documentId: fetchedSet.id,
      ownerUserId: ownerUserId,
      lift: lift,
      stackId: stackId,
      reps: '',
      weight: '',
      setOrder: setOrderField,
      date: dateField,
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
