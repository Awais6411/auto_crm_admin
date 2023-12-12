import 'package:auto_crm_admin/views/ui/oppurtunities/choose_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/admin/admin_provider.dart';
import 'splash_screen.dart';

Widget defaultWidget = const SplashScreen();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final entrypoint = prefs.getBool("entrypoint") ?? false;
  final loggedin = prefs.getBool("auctioneerLoggedin") ?? false;
  if (entrypoint && !loggedin) {
    defaultWidget = const SplashScreen();
  } else if (loggedin) {
    defaultWidget = const ChooseMonthScreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AdminNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'AutoCRM',
              home: defaultWidget);
        });
  }
}
