import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/features/home/main/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/home/main/presentation/widget/search_and_offers_for_the_main_appbar_sliver_widget.dart';
import 'package:gogreen/features/home/main/presentation/widget/list_of_company_card_widget.dart';
import 'package:gogreen/features/home/offers/presentation/riverpod/offers_riverpod.dart';

import '../widget/categories_of_companies_widget.dart';

class HomePage extends ConsumerStatefulWidget {


  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
      ref.read(companiesProvider.notifier).getData(
            moreData: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.refresh(homeOffersControllerProvider.notifier);
          ref.refresh(companiesProvider.notifier);
        },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SearchAndOffersForTheMainAppBarSliverWidget(expandedHeight: 290.h),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: CategoriesOfCompanyWidget(),
            ),

            SliverToBoxAdapter(
               child: ListOfCompanyCardWidget(scrollController:_scrollController),
            ),


          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

