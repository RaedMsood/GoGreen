import 'package:flutter/material.dart';
import 'package:gogreen/core/logger.dart';

import 'view.state.dart';


class UIState extends StatelessWidget {
  final ViewState state;
  final Widget child;

  final Widget? loadingState;
  final Widget? errorState;

  const UIState({
    super.key,
    required this.state,
    required this.child,
    this.loadingState,
    this.errorState,
  });

  @override
  Widget build(BuildContext context) {
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    wingsLogger.logWarning(state.toString());

    if (state == ViewState.loading && loadingState != null) {
      return loadingState!;
    }
    if (state == ViewState.failure && errorState != null) {
      return errorState!;
    }

    return child;
  }
}
