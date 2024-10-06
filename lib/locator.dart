import 'package:get_it/get_it.dart';
import 'package:gogreen/features/profiles/my_account/data/reposaitories/my_account_repo.dart';
import 'core/local/secure.storage.dart';
import 'features/address/data/reposaitories/address_repos.dart';
import 'features/home/notifications/data/reposaitories/notifications_repo.dart';
import 'features/my_orders/orders/data/repositories/orders.repo.dart';
import 'features/profiles/profile/data/reposaitories/profile_repo.dart';
import 'features/user/data/repos/user_repo.dart';
import 'features/cart/data/repositories/cart_repo.dart';
import 'features/home/details/data/reposaitories/repos.dart';
import 'features/home/main/data/reposaitories/repos.dart';
import 'features/home/offers/data/reposaitories/offer_repo.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WingsSecureStorage('uC3":%}ek10bE@6q'));

  locator.registerSingleton(() => UserRepository());
  locator.registerLazySingleton(() => CompanyRepository());
  locator.registerLazySingleton(() => OfferRepository());
  locator.registerLazySingleton(() => NotificationsRepository());
  locator.registerLazySingleton(() => CompanyDetailRepository());
  locator.registerLazySingleton(() => CartReposaitories());
  locator.registerLazySingleton(() => AddressesRepository());
  locator.registerLazySingleton(() => OrdersRepository());
  locator.registerLazySingleton(() => ProfileRepository());
  locator.registerLazySingleton(() => MyAccountRepository());

}
