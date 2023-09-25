import 'package:doctor_clinic_token_app/core/source/cache/cache.dart';
import 'package:doctor_clinic_token_app/core/source/cache/cache_impl.dart';
import 'package:doctor_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:doctor_clinic_token_app/core/source/shared_pref/shared_pref_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*Why GetIt ?
-------------
As your App grows, at some point you will need to put your app's logic in classes that are separated from your Widgets.
Keeping your widgets from having direct dependencies makes your code better organized and easier to test and maintain.*/

GetIt locator = GetIt.instance;

Future _setupLocator() async {
  // Cache
  locator.registerLazySingleton<Cache>(() => CacheImpl());

  SharedPreferences _preferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPref>(SharedPrefImpl(_preferences));

  // var instance = await SharedPrefImpl.getInstance();
  // locator.registerSingleton<SharedPref>(instance);

  // locator.registerSingletonAsync<SharedPref>(() async {
  //   final configService = SharedPrefImpl();
  //   await configService.init();
  //   return configService;
  // });

  // Repository
  //locator.registerFactory<LoginRepo>(() => LoginRepoImpl());


  // View Model
  //locator.registerFactory<LoginUseCase>(() => LoginUseCaseImpl());
}
Future setUpRealLocator() async {
  // locator.registerFactory<WebService>(() => WebServiceImpl());
  await _setupLocator();
}
/*

Future setUpRealLocator() async {
  locator.registerFactory<WebService>(() => WebServiceImpl());
  await _setupLocator();
}

setupMockLocator() async {
  locator.registerFactory<WebService>(() => MockWebServiceImpl());
  _setupLocator();
}
*/
