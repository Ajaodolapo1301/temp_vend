// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
// // import 'package:primhex/core/features/authentication/api/data_source/local_data_source/user_hive.dart';
//
// import 'package:primhex/core/network/network_info.dart';
// import 'package:primhex/features/authentication/api/repository/repository.dart';
//
// final locator = GetIt.instance;
//
// Future <void> init() async{
//   print("inittttttt");
//   // locator.registerFactory(() => LoginState(
//   //   // user: locator(),
//   //    userRepository: locator()
//   // ));
//   //
//   //
//   // // locator.registerLazySingleton<HiveUserAbstract>(
//   // //       () => UserHive(hive: locator()),
//   // // );
//   //
//   //
//   locator.registerLazySingleton<UserRepository>(
//         () => UserRepositoryImpl(
//
//       networkInfo: locator(),
//
//     ),
//   );
//
//
//
//   locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
//
//   // locator.registerLazySingleton(() => Hive);
//
//   locator.registerLazySingleton(() => DataConnectionChecker());
// }
