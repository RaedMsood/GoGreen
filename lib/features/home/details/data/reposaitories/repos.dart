import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/features/home/details/data/model/company_detail_model.dart';
import 'package:gogreen/features/home/details/data/model/product_detail_model.dart';

class CompanyDetailRepository {
  Future<DataState<CompanyDetailModel>> getCompanyDetail({
    required int id,
    int limit = 10,
    String search = '',
    int page = 1,
    int? sectionId,
    List<int>? categoryIds,
  }) async {
    //[1,2,3] => 1,2,3
    var categoryIdsString = categoryIds?.join(',');

    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.companyDetail,
        id: id,
        queryString: {
          'page': page,
          'perPage': limit,
          'search': search,
          'section_id': sectionId ?? "",
          'category_id': categoryIdsString ?? "",
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess<CompanyDetailModel>(
          CompanyDetailModel.fromJson(
            response.data,
          ),
        );
      },
      onError: (response, code) {
        return DataError<CompanyDetailModel>(
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

Future<DataState<ProductDetailModel>> getProductDetail(int id) async {
  return await WingsRemoteService().send(
    request: WingsRequest(
      url: AppURL.productDetail,
      id: id,
    ),
    method: WingsRemoteMethod.get,
    onSuccess: (response, code) {
      return DataSuccess(
        ProductDetailModel.fromJson(
          response.data,
        ),
      );
    },
    onError: (response, code) {
      return DataError<ProductDetailModel>(
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
}
