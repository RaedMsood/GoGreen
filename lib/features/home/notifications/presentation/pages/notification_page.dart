import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/core/states/error.state.dart';
import 'package:gogreen/core/states/ui.state.dart';
import 'package:gogreen/core/states/view.state.dart';
import 'package:gogreen/core/widget/appbar_widget.dart';
import 'package:gogreen/core/widget/loading_widget.dart';
import 'package:gogreen/features/home/notifications/presentation/riverpod/notifications_riverpod.dart';
import 'package:gogreen/features/home/notifications/presentation/widgets/notification_card_widget.dart';
import 'package:gogreen/features/home/notifications/presentation/widgets/notification_shimmer_card_widget.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
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
      ref.read(notificationsProvider.notifier).getData(
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
    var controller = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Notifications',
        titleFontSize: 17.sp,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(notificationsProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
                child: UIState(
              state: controller.viewState,
              loadingState: const NotificationShimmerCardWidget(),
              errorState: ErrorState.container(
                error: controller.errorModel,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(18.sp),
                    itemBuilder: (context, index) {
                      return NotificationCardWidget(
                        notification: controller.data.data[index],
                      );
                    },
                    itemCount: controller.data.data == null
                        ? 0
                        : controller.data.data.length,
                  ),
                  if (controller.viewState == ViewState.loadingMore)
                    Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: const CircularProgressIndicatorWidget(),
                    )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
