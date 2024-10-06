import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/constants/app_images.dart';
import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/features/home/details/presentation/riverpod/company_detail_riverpod.dart';
import 'package:gogreen/features/home/details/presentation/widgets/categories_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/search_for_a_product_and_view_offers_for_the_company_details_appbar_sliver_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/list_of_product_card_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/product_shimmer_card_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/search_for_the_product_company_details_appbar_sliver_widget.dart';
import 'package:gogreen/features/home/details/presentation/widgets/view_cart_button_for_company_details_widget.dart';

class CompanyDetailsPage extends ConsumerStatefulWidget {
  final int id;
  final String companyName;

  const CompanyDetailsPage(
      {super.key, required this.id, required this.companyName});

  @override
  ConsumerState<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends ConsumerState<CompanyDetailsPage> {
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
      ref.read(companyDetailProvider(widget.id).notifier).getData(
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
    var controller = ref.watch(companyDetailProvider(widget.id));
    var provider = ref.read(companyDetailProvider(widget.id).notifier);

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () async {
        ref.refresh(companyDetailProvider(widget.id));
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [

            /// If the search value is empty the search box is displayed with the offers. If it is not empty, only the search box is displayed.
            if (provider.searchController.text.isEmpty)
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate:
                SearchForAProductAndViewOffersForTheCompanyDetailsAppBarSliverWidget(
                  id: widget.id,
                  title: widget.companyName.toString(),
                  expandedHeight: 290.h,
                  controller: provider,
                  scrollController: _scrollController,
                ),
              )
            else
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate:
                SearchForAProductForTheCompanyDetailsAppBarSliverWidget(
                  id: widget.id,
                  companyName: widget.companyName.toString(),
                  controller: provider,
                ),
              ),
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: CategoriesWidget(
                  id: widget.id,
                  height:
                  provider.filteredCategories.isNotEmpty ? 140.h : 89.h),
            ),
            if (controller.data.products.data.isEmpty &&
                controller.viewState == ViewState.loadingMore)
              const SliverToBoxAdapter(child: ProductShimmerCardWidget()),
            if (controller.data.products.data.isEmpty &&
                controller.viewState == ViewState.success)
              SliverToBoxAdapter(
                child: ErrorState.container(
                  error: ErrorModel(
                    message: "No Products",
                    icon: AppImages.noData,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: ListOfProductCardWidget(
                id: widget.id,
              ),
            ),
            if (controller.data.products.data.isNotEmpty &&
                controller.viewState == ViewState.loadingMore)
              const SliverToBoxAdapter(
                child: CircularProgressIndicatorWidget(),
              ),
          ],
        ),
        bottomNavigationBar: UIState(
            state: controller.viewState,
            loadingState: const SizedBox(),
            errorState: const SizedBox(),
            child: ViewCartButtonForCompanyDetailsWidget(companyId: widget.id)),
      ),
    );
  }
}
