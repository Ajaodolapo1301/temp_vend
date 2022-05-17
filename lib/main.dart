import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vend_express/translation/codegen_loader.g.dart';

import 'core/GlobalState/appState.dart';
import 'core/GlobalState/baseState.dart';
import 'core/utils/apiUrls/env.dart';
import 'core/utils/function/dev_utils.dart';
import 'core/utils/sizeConfig/sizeConfig.dart';
import 'features/Notification/firebase_notification/push_notification_manager.dart';
import 'features/authentication/model/user.dart';
import 'features/authentication/screens/splashPaage.dart';
import 'features/authentication/viewModel/loginState.dart';
import 'features/chat/viewModel/chatViewModel.dart';
import 'features/makePayment/viewModel/makePaymentViewModel.dart';
import 'features/myOrder/viewModel/myOrderViewModel.dart';
import 'features/profile/viewModel/profileViewModel.dart';
import 'features/sendPackage/model/deliveryType.dart';
import 'features/sendPackage/model/delivery_time.dart';
import 'features/sendPackage/model/packageSize.dart';
import 'features/sendPackage/viewModel/createOrderViewModel.dart';
import 'features/sendPackage/viewModel/sendPackageViewModel.dart';
import 'features/trackOrder/viewModel/trackOrderViewModel.dart';
import 'features/wallet/model/walletbalance.dart';
import 'features/wallet/viewModel/walletState.dart';

final navKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  // await di.init();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  var box;
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdap());
  Hive.registerAdapter(PackageSizeAdapter());
  Hive.registerAdapter(Wallet());
  Hive.registerAdapter(DeliveryTimeAdapter());
  Hive.registerAdapter(DeliveryTypeAdapter());

  await Hive.openBox("user");

  box = Hive.box("user");
  User user = box.get('user', defaultValue: null);
  // Hive.registerAdapter(ContactCardModelAdapter());
  FlutterError.onError = (FlutterErrorDetails details) async {
    final exception = details.exception;
    final stackTrace = details.stack;
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(exception, stackTrace!);
    }
  };
  // var user = await  UserHive().getUser();

  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  Future<bool> isFirstTime() async {
    var isFirstTime = sharedPref.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      sharedPref.setBool('first_time', false);
      return false;
    } else {
      sharedPref.setBool('first_time', false);
      return true;
    }
  }

  bool hasUserUsedApp = false;
  isFirstTime().then((isFirstTimeb) {
    hasUserUsedApp = isFirstTimeb;
  });
  runZonedGuarded<Future<void>>(() async {
    runApp(DevicePreview(
        enabled: false,
        builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => AppState()),
                  ChangeNotifierProvider(
                      create: (_) => LoginState(value: user)),
                  ChangeNotifierProvider(create: (_) => BaseViewModel()),
                  ChangeNotifierProvider(create: (_) => SendPackageViewModel()),
                  ChangeNotifierProvider(create: (_) => CreateOrderState()),
                  ChangeNotifierProvider(create: (_) => MyOrderViewModel()),
                  ChangeNotifierProvider(create: (_) => ProfileState()),
                  ChangeNotifierProvider(create: (_) => WalletState()),
                  ChangeNotifierProvider(create: (_) => MakePaymentViewModel()),
                  ChangeNotifierProvider(create: (_) => TrackOrderViewModel()),
                  ChangeNotifierProvider(create: (_) => ChatState()),
                ],
                child: EasyLocalization(
                  supportedLocales: [
                    Locale(
                      'en',
                    ),
                    Locale('de'),
                    Locale(
                      'es',
                    ),
                    Locale('fr')
                  ],
                  path: 'assets/translation',
                  fallbackLocale: Locale(
                    'en',
                  ),
                  assetLoader: CodegenLoader(),
                  child: MyApp(user: user, hasNotUserUsedApp: hasUserUsedApp),
                ))));
  }, (error, stackTrace) async {
    print(error);
    print(stackTrace);
  });
}

class MyApp extends StatefulWidget {
  bool? hasNotUserUsedApp;
  User? user;
  MyApp({this.hasNotUserUsedApp, this.user});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setUpNotification();
    super.initState();
  }

  setUpNotification() async {
    await PushNotificationsManager(
      context: context,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(color: BarColor.black);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return OverlaySupport(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: MaterialApp(
                navigatorKey: navKey,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Hex Logistics',
                theme: ThemeData(
                  fontFamily: 'DMSans',
                  primarySwatch: Colors.blue,
                ),
                home: SplashPage(
                  hasNotUserUsedApp: widget.hasNotUserUsedApp!,
                  user: widget.user,
                )),
          ),
        );
      });
    });
  }
}
