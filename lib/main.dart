import 'package:flutter/material.dart';
import 'package:millyshb/configs/network/call_helper.dart';
import 'package:millyshb/configs/routes/routes.dart';
import 'package:millyshb/configs/routes/routes_names.dart';
import 'package:millyshb/configs/theme/app_theme.dart';
import 'package:millyshb/configs/components/shared_preferences.dart';
import 'package:millyshb/configs/components/size_config.dart';
import 'package:millyshb/view/select_store_screen.dart';
import 'package:millyshb/view/splash/splash_screen.dart';
import 'package:millyshb/view_model/address_view_model.dart';
import 'package:millyshb/view_model/cart_view_model.dart';
import 'package:millyshb/view_model/product_view_model.dart';
import 'package:millyshb/view_model/select_store_view_model.dart';
import 'package:millyshb/view_model/theme_viewmodel.dart';
import 'package:millyshb/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  CallHelper.url = "http://13.200.240.28:3003/";
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
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
