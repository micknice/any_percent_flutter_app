import 'package:flutter/material.dart';
import 'package:any_percent_training_tracker/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error occurred',
    content: text,
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
