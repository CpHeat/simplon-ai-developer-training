import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/widgets/dialogs/failure_dialog.dart';

// This widget provides row for list of additional features in "more" section
class AdditionalFeatureRow extends StatelessWidget {
  final IconData iconData;
  final String title;

  AdditionalFeatureRow({required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(children: [
              Icon(iconData, color: Colors.blueAccent),
              SizedBox(width: 30),
              Expanded(child: Text(title)),
              Icon(CupertinoIcons.chevron_right),
            ]),
          ],
        ),
      ),
      onTap: () => showDialog(
        context: context,
        builder: (innerContext) => FailureDialog(
          dialogContext: innerContext,
          title: Translation.of(context).featureAvailability,
          message: Translation.of(context).thanksForPatience,
        ),
      ),
    );
  }
}
