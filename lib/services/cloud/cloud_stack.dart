import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudStack {
  final String documentId;
  final String ownerUserId;
  final String lift;
  final String date;
  final String setCount;

  const CloudStack({
    required this.documentId,
    required this.ownerUserId,
    required this.lift,
    required this.date,
    required this.setCount
  });
  CloudStack.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdField],
        lift = snapshot.data()[liftField] as String,
        date = snapshot.data()[dateField] as String,
        setCount = snapshot.data()[setCountField] as String;
}
