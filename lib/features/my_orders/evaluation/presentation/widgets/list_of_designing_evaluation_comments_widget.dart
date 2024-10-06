import 'package:flutter/material.dart';

import 'designing_evaluation_comments_widget.dart';

class ListOfDesigningEvaluationCommentsWidget extends StatelessWidget {
  const ListOfDesigningEvaluationCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const DesigningEvaluationCommentsWidget();
      },
    );
  }
}
