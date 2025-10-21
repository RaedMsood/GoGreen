import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/evaluation_riverpod.dart';
import 'evaluation_linear_progress_indicator_widget.dart';

class ListOfEvaluationLinearProgressIndicatorWidget extends ConsumerWidget {
  final int id;

  const ListOfEvaluationLinearProgressIndicatorWidget(
      {super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getEvaluationAndCommentProvider(id));
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.data.ratingLineBar.length,
      itemBuilder: (context, index) {
        index = controller.data.ratingLineBar.length - 1 - index;

        return EvaluationLinearProgressIndicatorWidget(
          value: controller.data.ratingLineBar[index].value /
              controller.data.total,
          numberingLinearProgressIndicator:
              controller.data.ratingLineBar[index].lineNumber,
        );
      },
    );
  }
}
