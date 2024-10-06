class MessageOfErorrApi implements Exception {
  static List<String> getExeptionMessage(int statusCode) {
    switch (statusCode) {
      case 204:
        return ['No Data', 'Please try again'];
      case 401:
        return ['Unauthenticated Exception', 'Please try again'];
      case 404:
        /// Server error
        return ['Something went wrong', 'Please try again'];
      case 406:
        /// لم يستجب الخادم لطلب العميل
        return ['Something went wrong', 'Please try again'];
      case 400:
        /// ارسل التطبيق طلب غير صالح
        return ['Invalid Exception', 'Please try again'];
      case 408:
        /// Time out Exception
        return ['Sorry, there is an internet issue', 'Please try again'];
      case 410:
        return ['The requested resource is no longer available', ''];
      case 422:
        return [
          /// Invalid Inputs Exception
          'Invalid inputs', 'Please try again'
        ];
      case 434:
        /// User Exists Exception
        return ['User exists', ''];
      case 439:
        /// Blocked Exception
        return ['Something went wrong', 'Please try again'];
      default:
        return [
          'There is a problem with the internet connection',
          'Please check your internet connection'
        ];
    }
  }
}
