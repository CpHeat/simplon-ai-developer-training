import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// This widget provides a custom progress indicator
// Display it in entire pages
class LoaderFullPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: SpinKitWave(
        color: Theme.of(context).colorScheme.secondary,
        size: 40.0,
      ),
    );
  }
}
