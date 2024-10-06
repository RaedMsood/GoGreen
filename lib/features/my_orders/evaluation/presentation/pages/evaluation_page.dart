import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';
import 'package:gogreen/features/my_orders/evaluation/presentation/widgets/evaluation_linear_progress_indicator_widge.dart';
import 'package:gogreen/features/my_orders/evaluation/presentation/widgets/evaluation_value_and_number_of_rating_stars_widget.dart';
import 'package:gogreen/features/my_orders/evaluation/presentation/widgets/list_of_designing_evaluation_comments_widget.dart';

import 'add_a_rating_or_comment_page.dart';


class EvaluationPage extends StatelessWidget {
  const EvaluationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Evaluation",
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(14.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Row(
                    children: [
                      /// Class Evaluation Value And Number Of Rating Stars
                      EvaluationValueAndNumberOfRatingStarsWidget(),
                      Expanded(
                        child: Column(
                          children: [
                            EvaluationLinearProgressIndicatorWidget(
                                numberingLinearProgressIndicator: 5),
                            EvaluationLinearProgressIndicatorWidget(
                                numberingLinearProgressIndicator: 4),
                            EvaluationLinearProgressIndicatorWidget(
                                numberingLinearProgressIndicator: 3),
                            EvaluationLinearProgressIndicatorWidget(
                                numberingLinearProgressIndicator: 2),
                            EvaluationLinearProgressIndicatorWidget(
                                numberingLinearProgressIndicator: 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                  18.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: "Comments",
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),

                  /// Class List Of Designing Evaluation Comments
                  const ListOfDesigningEvaluationCommentsWidget(),
                  // ShimmerForEvaluationPage(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: DefaultButtonWidget(
              text: "Add a rating",
              onPressed: () {
                showModalBottomSheetWidget(
                    context: context, page: AddARatingOrCommentPage());
              },
            ),
          ),
        ],
      ),
    );
  }
}
