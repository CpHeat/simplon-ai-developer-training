import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/widgets/buttons/rounded_button.dart';

// This widget provides two buttons to display in bottom sheet.
// It includes a default cancel button and an another button to customize (title, color, callback)
class TwoButtonsSheet extends StatelessWidget {
  final String title;
  final Function action;

  TwoButtonsSheet({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: RoundedButton(title: Translation.of(context).cancel, backgroundColor: Colors.red),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            child: RoundedButton(title: title, backgroundColor: Colors.grey),
            onTap: () => {
              Navigator.pop(context),
              action.call(),
            },
          ),
        ],
      ),
    );
  }
}

// This widget provides two buttons to display in bottom sheet.
// It includes a default cancel button and two another buttons to customize (title, color, callback)
class ThreeButtonsSheet extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final Function firstAction;
  final Function secondAction;

  ThreeButtonsSheet({required this.firstTitle, required this.secondTitle, required this.firstAction, required this.secondAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: RoundedButton(title: Translation.of(context).cancel, backgroundColor: Colors.red),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            child: RoundedButton(title: firstTitle, backgroundColor: Colors.grey),
            onTap: () => {
              Navigator.pop(context),
              firstAction.call(),
            },
          ),
          GestureDetector(
            child: RoundedButton(title: secondTitle, backgroundColor: Colors.green),
            onTap: () => {
              Navigator.pop(context),
              secondAction.call(),
            },
          ),
        ],
      ),
    );
  }
}
