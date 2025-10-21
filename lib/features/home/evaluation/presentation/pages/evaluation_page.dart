import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/appbar_sliver_persistent_header_widget.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/auto_size_text_widget.dart';
import 'package:gogreen/core/widget/buttons/default_button.dart';
import 'package:gogreen/core/widget/general_design_of_the_company_card_widget.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/core/widget/show_modal_bottom_sheet_widget.dart';

import '../riverpod/evaluation_riverpod.dart';
import '../widgets/evaluation_value_and_number_of_rating_stars_widget.dart';
import '../widgets/list_of_comments_widget.dart';
import '../widgets/list_of_evaluation_linear_progress_indicator_widget.dart';
import '../widgets/shimmer_for_evaluation_widget.dart';
import 'add_a_rating_or_comment_dialog.dart';

class EvaluationPage extends ConsumerStatefulWidget {
  final int id;
  final String companyImage;
  final String companyName;
  final String companyAddress;
  final bool? addARating;

  const EvaluationPage({
    super.key,
    required this.id,
    required this.companyImage,
    required this.companyName,
    required this.companyAddress,
    this.addARating = false,
  });

  @override
  ConsumerState<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends ConsumerState<EvaluationPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //call getData from the provider
      ref.read(getEvaluationAndCommentProvider(widget.id).notifier).getData(
            moreData: true,
          );
    }
  }

  //dispose
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(getEvaluationAndCommentProvider(widget.id));
    return Scaffold(
      appBar: controller.viewState == ViewState.failure
          ? AppBarWidget(title: "Evaluation")
          : null,
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.refresh(getEvaluationAndCommentProvider(widget.id));
        },
        child: UIState(
          state: controller.viewState,
          loadingState: const ShimmerForEvaluationWidget(),
          errorState: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ErrorState.container(
              error: controller.errorModel,
            ),
          ),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: AppbarSliverPersistentHeaderWidget(
                  title: "Evaluation",
                  expandedHeight: 234.h,
                  child: GeneralDesignOfTheCompanyCardWidget(
                    image: widget.companyImage,
                    name: widget.companyName,
                    evaluation: controller.data.rates,
                    address: widget.companyAddress,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          /// Class Evaluation Value And Number Of Rating Stars
                          EvaluationValueAndNumberOfRatingStarsWidget(
                            rates: controller.data.rates,
                            total: controller.data.total.toDouble(),
                          ),
                          Expanded(
                            child:
                                ListOfEvaluationLinearProgressIndicatorWidget(
                              id: widget.id,
                            ),
                          ),
                        ],
                      ),
                      14.h.verticalSpace,
                      const AutoSizeTextWidget(
                        text: "Comments",
                      ),

                      /// Class List Of Designing Evaluation Comments
                      ListOfCommentsWidget(
                        id: widget.id,
                      ),

                      // ShimmerForEvaluationPage(),
                    ],
                  ),
                ),
              ),
              if (controller.viewState == ViewState.loadingMore)
                const SliverToBoxAdapter(
                  child: CircularProgressIndicatorWidget(),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.addARating == false
          ? const SizedBox.shrink()
          : UIState(
              state: controller.viewState,
              loadingState: const SizedBox.shrink(),
              errorState: const SizedBox.shrink(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: DefaultButtonWidget(
                  text: "Add a rating",
                  onPressed: () {
                    showModalBottomSheetWidget(
                      context: context,
                      page: AddARatingOrCommentDialog(
                        id: widget.id,
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
