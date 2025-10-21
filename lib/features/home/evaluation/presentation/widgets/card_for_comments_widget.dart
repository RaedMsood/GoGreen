import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogreen/core/constants/app_icons.dart';
import 'package:gogreen/core/extension/string.dart';
import 'package:gogreen/core/helpers/flash_bar_helper.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/rating_bar_widget.dart';
import 'package:gogreen/features/services/auth/auth.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:like_button/like_button.dart';
import '../../data/model/comment_model.dart';
import '../riverpod/evaluation_riverpod.dart';
//package="com.example.gogreen"
class CardForCommentsWidget extends ConsumerWidget {
  final CommentModel comment;

  const CardForCommentsWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(addLikeOrDislikeProvider.notifier);
    return Padding(
      padding: EdgeInsets.only(bottom: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7,
                child: AutoSizeTextWidget(
                  text: comment.userName,
                  colorText: AppColors.greySwatch.shade600,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.4.sp,
                  minFontSize: 12,
                ),
              ),
              const Spacer(),
              RatingBarWidget(
                evaluation: comment.reviewValue.toDouble(),
                itemSize: 14.5.sp,
                unratedColor: const Color(0xfffed9a3),
              ),
              7.w.horizontalSpace,
              SvgPicture.asset(
                AppIcons.comment,
              ),
            ],
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: comment.comment,
            colorText: AppColors.greySwatch.shade700,
            fontSize: 11.8.sp,
            minFontSize: 10,
            maxLines: 20,
          ),
          8.h.verticalSpace,
          Row(
            children: [
              LikeButton(
                likeCount: comment.commentLikeCount,
                circleColor: const CircleColor(
                    start: Color(0xfff0687c), end: Colors.red),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xfff0687c),
                  dotSecondaryColor: Colors.red,
                ),
                isLiked: comment.likeStatus.isEmpty
                    ? false
                    : comment.likeStatus[0].status == 0
                        ? false
                        : true,
                onTap: (bool isLiked) async {
                  if (!Auth().loggedIn) {
                    showFlashBarError(
                      context: context,
                      message: "Please login to add like",
                    );
                  }else{
                    isLiked = !isLiked;
                    if (isLiked == false) {
                      ref.read(addLikeOrDislikeProvider.notifier).dislike(
                        context: context,
                        commentId: comment.id,
                      );
                    } else {
                      ref.read(addLikeOrDislikeProvider.notifier).addLike(
                        context: context,
                        commentId: comment.id,
                      );
                    }
                  }

                  return isLiked;
                },
                likeBuilder: (bool isLiked) {

                  return Padding(
                    padding: EdgeInsets.only(
                      top: isLiked ? 1.h : 3.h,
                      bottom: isLiked ? 0.0 : 3.5.h,
                      right: 2.w,
                    ),
                    child: SvgPicture.asset(
                      isLiked ? AppIcons.favoriteActive : AppIcons.favorite,
                      color: const Color(0xfff0687c),
                    ),
                  );
                },
                likeCountPadding: EdgeInsets.only(left: 4.w, right: 24.w),
                countBuilder: (likeCount, isLiked, text) {
                  return AutoSizeTextWidget(
                    text: text,
                    fontSize: 10.8.sp,
                  );
                },
              ),



              AutoSizeTextWidget(
                text: timeago.format(dateTime(comment.createdAt), locale: 'ar') ,
                fontSize: 9.8.sp,
                colorText: AppColors.greySwatch.shade600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
