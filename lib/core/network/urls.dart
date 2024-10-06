class AppURL {
  static String get base => 'https://gogreen.dev-station.com';

//https://tajer-backend.dev-station.com
  //https://gogreen.dev-station.com
  static String get baseURL => '$base/api/app';

  static String get baseImageURL => '$base/api/v1/app/delivery/';

  static String get login => '/auth/login';

  static String get register => '/auth/register';

  static String get profile => '/profile';

  static String get updateProfile => '/profile/update';

  static String get updatePassword => '/profile/update_password';

  static String get verifyPhone => '/auth/verify_phone';

  static String get forgetPassword => '/auth/forget_password';

  static String get resetPassword => '/auth/reset_password';

  static String get addFcmToken => '/auth/fcmToken';

  static String get removeFcmToken => '/auth/removeFcmToken';

  static String get sendOtp => '/auth/send_otp';

  static String get checkOtp => '/auth/check_otp';

  static String get resendOtp => '/auth/update_otp';

  static String get companies => '/companies';

  static String get companyDetail => '/companies/company_details';

  static String get companyReview => '/companies/review';

  static String get getCompanyReviews => '/companies/company_reviews';

  static String get productDetail => '/companies/product';

  static String get offers => '/offers';

  static String get offerDetail => '/offers';

  static String get vehicles => '/orders/get_vehicle_types';

  static String get user => '/user';

  static String get notifications => '/notifications';

  static String get statics => '/statics';

  static String get addresses => '/addresses';

  static String get createAddress => '/addresses/store';

  static String get updateAddress => '/addresses/update';

  static String get deleteAddress => '/addresses/delete';

  static String get orders => '/orders';

  static String get orderDetail => '/orders/show';

  static String get orderData => '/orders/get_order_data';

  static String get sendOrder => '/orders/store';

  static String get floosakPay => '/orders/floosak/pay';

  static String get applyCoupon => '/orders/apply_coupon';

  static String get getDeliveryPrice => '/orders/get_delivery_cost';

  static String get getStates => '/states';

  static String get getCities => '/cities';

  static String get getDistricts => '/districts';

  static String get appInfo => '/get_application_data';
}
