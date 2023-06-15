import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:any_percent_training_tracker/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudSession {
  final String documentId;
  final String ownerUserId;
  final String date;

  const CloudSession({
    required this.documentId,
    required this.ownerUserId,
    required this.date,
  });
  CloudSession.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdField],
        date = snapshot.data()[dateField] as String;
}
