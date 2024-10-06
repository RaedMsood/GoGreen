import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:like_button/like_button.dart';

class DesigningEvaluationCommentsWidget extends StatelessWidget {
  const DesigningEvaluationCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                child: AutoSizeTextWidget(
                  text: "Charette Hanlin",
                  colorText: const Color(0xff616161),

                  fontSize: 12.sp,
                  minFontSize: 12,
                ),
              ),
              const Spacer(),
              RatingBarWidget(
                evaluation: 4.5,
                itemSize: 14.sp,
                unratedColor: const Color(0xfffed9a3),
              ),
              4.w.horizontalSpace,
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.offline_bolt_outlined,
                  size: 22,
                ),
              ),
            ],
          ),
          8.h.verticalSpace,
          AutoSizeText(
            "dhfaf h dad h jdhfjhfhhwakfh lwdjlxj d dnmpoopienc ndkjndcmjdgg jdgsys dhfjhfhhwakfh lwdjlxj d dnmpoopienc ndkjndcmjdgg jdgsys dhfjhfhhwakfh lwdjlxj d dnmpoopienc ndkjndcmjdgg jdgsys",
            style: TextStyle(fontSize: 10.sp),
            minFontSize: 10,
          ),
          8.h.verticalSpace,
          Row(
            children: [
              LikeButton(
                likeCount: 665,
                circleColor: const CircleColor(
                    start: Color(0xfff0687c), end: Colors.red),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xfff0687c),
                  dotSecondaryColor: Colors.red,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    isLiked
                        ? Icons.favorite_sharp
                        : Icons.favorite_border_rounded,
                    color: const Color(0xfff0687c),
                  );
                },
                likeCountPadding: EdgeInsets.only(left: 4.w, right: 24.w),
                countBuilder: (likeCount, isLiked, text) {
                  return Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.5.h),
                child: Text(
                  "6 days ago",
                  style: TextStyle(
                    color: const Color(0xff616161),
                    fontWeight: FontWeight.w300,
                    fontSize: 9.8.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
