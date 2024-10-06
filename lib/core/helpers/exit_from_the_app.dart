import 'package:flutter/material.dart';
import 'flash_bar_helper.dart';

class ExitFromAppWidget extends StatefulWidget {

  ExitFromAppWidget({super.key, required this.child});
  final Widget child;

  @override
  State<ExitFromAppWidget> createState() => _ExitFromAppWidgetState();
}

class _ExitFromAppWidgetState extends State<ExitFromAppWidget> {
  DateTime backPress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: widget.child,
      onWillPop: () async {
        final timeGap = DateTime.now().difference(backPress);
        final canExit = timeGap >= const Duration(seconds: 2);

        backPress = DateTime.now();

        if (canExit) {
          pressAgainToExit(context: context);
          return  false;
        } else {
          return true;
        }
      },
    );
  }
}
