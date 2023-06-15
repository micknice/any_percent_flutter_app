import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/utils/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
