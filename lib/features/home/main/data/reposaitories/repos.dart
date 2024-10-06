import 'package:gogreen/core/network/errors/error.model.wings.dart';
import 'package:gogreen/core/network/remote.wings.dart';
import 'package:gogreen/core/states/paginatedData.state.dart';
import '../model/company_model.dart';

class CompanyRepository {
  Future<DataState<PaginationModel<CompanyModel>>> getCompanies({
    int page = 1,
    int limit = 20,
    String filter = 'all',
    String search = '',
  }) async {
    return await WingsRemoteService().send(
      request: WingsRequest(
        url: AppURL.companies,
        queryString: {
          'page': page,
          'perPage': limit,
          'filter': filter,
          'search': search,
        },
      ),
      method: WingsRemoteMethod.get,
      onSuccess: (response, code) {
        return DataSuccess(
          PaginationModel<CompanyModel>.fromJson(response.data, (comp) {
            return CompanyModel.fromJson(comp);
          }),

          // CompanyModel.fromJsonList(response.data['data']),
        );
      },
      onError: (response, code) {
        return DataError<PaginationModel<CompanyModel>>(
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
