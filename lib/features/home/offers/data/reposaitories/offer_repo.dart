import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/home/offers/data/model/offer_model.dart';

class OfferRepository {
  Future<DataState<List<OfferModel>>> getHomeOffers() async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.offers,
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        var offers = OfferModel.empty().fromJsonList(
          response.data,
        );
        return DataSuccess(offers);
      },
      onError: (response, code) {
        return DataError<List<OfferModel>>(
          message: response.message,
          code: response.code,
          error: ErrorModel.fromCode(
            response.code,
            response.statusCode,
          ),
        );
      },
    );
  }

// Future<DataState<OfferDetailModel>> getOfferDetail(int offerId) async {
//   return await WingsRemoteService().send(
//     request: WingsRequest(
//       url: AppURL.offerDetail,
//       id: offerId,
//     ),
//     method: WingsRemoteMethod.get,
//     onSuccess: (response, code) {
//       return DataSuccess(
//         OfferDetailModel.fromJson(
//           response.data,
//         ),
//       );
//     },
//     onError: (response, code) {
//       return DataError<OfferDetailModel>(
//         message: response.message,
//         code: response.code,
//         error: ErrorModel.fromCode(
//           response.code,
//           response.statusCode,
//         ),
//       );
//     },
//   );
// }
}
