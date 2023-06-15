import 'package:flutter/widgets.dart';
import 'package:any_percent_training_tracker/utils/dialogs/generic_dialog.dart';

Future<void> showPasswordResetDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password reset',
    content: 'A password reset link has been sent to your email',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
