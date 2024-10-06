import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/theme.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/inputs/text_form_field.dart';

class AddARatingOrCommentPage extends StatefulWidget {
  TextEditingController comment = TextEditingController();

  AddARatingOrCommentPage({super.key});

  @override
  State<AddARatingOrCommentPage> createState() =>
      _AddARatingOrCommentPageState();
}

class _AddARatingOrCommentPageState extends State<AddARatingOrCommentPage> {
  double countEvaluation = 2.5;

  @override
  Widget build(BuildContext context) {
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
            controller: widget.comment,
            type: TextInputType.text,
            hintText: "add a comment",
            fillColor: secondary,
            prefix: Icon(
              Icons.messenger_outline,
              color: Colors.grey[500],
            ),
          ),
          23.h.verticalSpace,
          DefaultButtonWidget(
            text: "Submit evaluation",
            height: 45.h,
            borderRadius: 14.sp,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

            },
          ),
        ],
      ),
    );
  }
}
