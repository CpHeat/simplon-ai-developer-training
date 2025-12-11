import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';

// This widget provides a custom failure dialog with given :
// - title text
// - message text
// The dialog appearance changes according to the platform that the app is running on
class FailureDialog extends StatelessWidget {
  final BuildContext dialogContext;
  final String title;
  final String message;

  FailureDialog({required this.dialogContext, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    // Check platform before building the dialog
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(Translation.of(context).close),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              ElevatedButton(
                child: Text(Translation.of(context).close),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              )
            ],
          );
  }
}
