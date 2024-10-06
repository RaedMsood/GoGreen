import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gogreen/core/states/data.state.dart';
import 'package:gogreen/core/states/generateData.state.dart';
import 'package:gogreen/features/home/offers/data/model/offer_model.dart';
import 'package:gogreen/features/home/offers/data/reposaitories/offer_repo.dart';
import 'package:gogreen/locator.dart';


class OffersRiverpodController
    extends StateNotifier<GenerateDataState<List<OfferModel>>> {
  OffersRiverpodController() : super(GenerateDataState.initial([])) {
    getHomeOffers();
  }

  final _controller = locator<OfferRepository>();

  Future<void> getHomeOffers() async {
    state = state.loading();
    final offers = await _controller.getHomeOffers();

    if (offers is DataSuccess) {
      state = state.success(offers.data!);
    } else {
      state = state.failure(
        offers.message,
        error: offers.error,
      );
    }
  }
}

final homeOffersControllerProvider =
    StateNotifierProvider<OffersRiverpodController, GenerateDataState>(
  (ref) => OffersRiverpodController(),
);
