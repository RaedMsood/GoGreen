import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';

import '../riverpod/evaluation_riverpod.dart';

class AddARatingOrCommentDialog extends ConsumerStatefulWidget {
  final int id;

  const AddARatingOrCommentDialog({super.key, required this.id});

  @override
  ConsumerState<AddARatingOrCommentDialog> createState() =>
      _AddARatingOrCommentDialogState();
}

class _AddARatingOrCommentDialogState
    extends ConsumerState<AddARatingOrCommentDialog> {
  TextEditingController comment = TextEditingController();

  double countEvaluation = 2.5;

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(addEvaluationAndCommentProvider(widget.id));

    return Padding(
      padding: EdgeInsets.all(14.0.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: "Can you leave your review?",
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w400,
          ),
          18.h.verticalSpace,
          AutoSizeTextWidget(
            text: "$countEvaluation",
            fontSize: 17.sp,
            colorText: const Color(0xff616161),
          ),
          20.h.verticalSpace,
          RatingBar.builder(
            initialRating: 2.5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            unratedColor: const Color(0xfffed9a3),
            itemPadding: const EdgeInsets.symmetric(horizontal: 9.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rate,
              color: Color(0xffffbd30),
            ),
            onRatingUpdate: (rating) {
              setState(() {
                countEvaluation = rating;
              });
            },
          ),
          23.h.verticalSpace,
          TextFormFieldWidget(
            controller: comment,
            type: TextInputType.text,
            hintText: "add a comment",
            hintTextColor:AppColors.greySwatch.shade600.withOpacity(.7) ,
            hintFontSize: 11.5.sp,
            fillColor: AppColors.greySwatch.shade50,
            prefix: Padding(
              padding:  EdgeInsets.all(11.4.sp),
              child: SvgPicture.asset(AppIcons.addComment,height: 8.h,),
            )
          ),
          23.h.verticalSpace,
          DefaultButtonWidget(
            text: "Submit evaluation",
            height: 45.h,
            borderRadius: 14.sp,
            isLoading: controller.viewState == ViewState.loading,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              ref.read(addEvaluationAndCommentProvider(widget.id).notifier).add(
                    context: context,
                    rating: double.parse(countEvaluation.round().toString()),
                    comment: comment.text,
                    onSuccess: () {
                      Navigator.pop(context);
                      ref.refresh(getEvaluationAndCommentProvider(widget.id));
                      showFlashBarSuccess(
                        message: "Added successfully",
                        context: context,
                      );
                    },
                  );
            },
          ),
        ],
      ),
    );
  }
}
