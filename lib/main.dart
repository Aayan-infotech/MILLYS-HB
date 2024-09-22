import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:millyshb/configs/components/notification.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/routes/routes.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/view/splash/splash_screen.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/select_store_view_model.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessginBackgroundHandler(RemoteMessage event) async {
  await NotificationService.showNotification(event);

  debugPrint("background-------");
}

Future<void> main() async {
  CallHelper.url = "http://3.111.163.2:5001/";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessginBackgroundHandler);
  // Get the device token
  String? token = await messaging.getToken();
  print("Device Token: $token");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectStoreProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
  SharedPrefUtil.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(context);
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
              ),
              onGenerateRoute: Routes.generateRoute,
              initialRoute: RoutesName.splash,
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
