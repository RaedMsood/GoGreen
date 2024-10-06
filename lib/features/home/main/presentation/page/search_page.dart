import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/theme/app_colors.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/features/home/main/presentation/riverpod/riverpod.dart';
import 'package:gogreen/features/home/main/presentation/widget/appbar_search_companies_header_delegate_widget.dart';
import 'package:gogreen/features/home/main/presentation/widget/list_of_company_search_results_widget.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
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
      ref.read(searchCompaniesProvider.notifier).getData(
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Consumer(
        builder: (context, ref, child) {
          var controller = ref.watch(searchCompaniesProvider);

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: AppBarSearchCompaniesHeaderDelegate(
                  controller: ref.read(searchCompaniesProvider.notifier),
                ),
              ),
              const SliverToBoxAdapter(
                child: ListOfCompanySearchResultsWidget(),
              ),
              if (controller.viewState == ViewState.loadingMore)
                const SliverToBoxAdapter(
                  child: CircularProgressIndicatorWidget()
                ),
            ],
          );
        },
      ),
    );
  }
}
