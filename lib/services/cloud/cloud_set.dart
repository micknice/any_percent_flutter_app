import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudSet {
  final String documentId;
  final String ownerUserId;
  final String lift;
  final String reps;  
  final String stackId;
  final String weight;

  const CloudSet({
    required this.documentId,
    required this.ownerUserId,
    required this.lift,
    required this.reps,    
    required this.stackId,
    required this.weight,
  });
  CloudSet.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdField],
        lift = snapshot.data()[liftField] as String,
        reps = snapshot.data()[repsField] as String,       
        stackId = snapshot.data()[stackIdField] as String,
        weight = snapshot.data()[weightField] as String;
}
