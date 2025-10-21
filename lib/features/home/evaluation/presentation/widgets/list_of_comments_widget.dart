import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/evaluation_riverpod.dart';
import 'card_for_comments_widget.dart';

class ListOfCommentsWidget extends ConsumerWidget {
  final int id;

  const ListOfCommentsWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getEvaluationAndCommentProvider(id));

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.data.comment.data.length,
      itemBuilder: (context, index) {
        return CardForCommentsWidget(
          comment: controller.data.comment.data[index],
        );
      },
    );
  }
}
