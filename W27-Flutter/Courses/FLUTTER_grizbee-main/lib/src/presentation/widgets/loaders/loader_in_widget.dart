import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// This widget provides a custom progress indicator
// Display it inside another widget like Cards, Row lines etc...
class LoaderInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: Theme.of(context).colorScheme.secondary,
      size: 20.0,
    );
  }
}
