import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hangman_game/screens/home_screen.dart';
import 'package:hangman_game/screens/score_screen.dart';
import 'package:hangman_game/screens/splash_screen.dart';
import 'package:hangman_game/utilities/constants.dart';
import 'package:hangman_game/utils/enum.dart';
import 'package:hangman_game/utils/global.dart';

import 'language/languages.dart';
import 'local_storage.dart';

void main() async{
  await LocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.en.name;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'HangMan',
          theme: ThemeData.dark().copyWith(
            tooltipTheme: TooltipThemeData(
              decoration: BoxDecoration(
                color: kTooltipColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
                letterSpacing: 1.0,
                color: Colors.white,
              ),
            ),
            scaffoldBackgroundColor: const Color(0xFF421b9b),
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'PatrickHand'),
          ),
          home:const SplashScreen(),
          // theme: CustomTheme.lightTheme,
          // darkTheme: CustomTheme.darkTheme,
          // themeMode: ThemeMode.system,
          translations: Languages(),
          locale: Global.language == Language.zh.name
              ? const Locale('zh', 'CN')
              : Global.language == Language.hi.name
              ? const Locale('hi', 'IN')
              : const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
        );
      },
    );
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.dark().copyWith(
    //     tooltipTheme: TooltipThemeData(
    //       decoration: BoxDecoration(
    //         color: kTooltipColor,
    //         borderRadius: BorderRadius.circular(5.0),
    //       ),
    //       textStyle: const TextStyle(
    //         fontWeight: FontWeight.w900,
    //         fontSize: 20.0,
    //         letterSpacing: 1.0,
    //         color: Colors.white,
    //       ),
    //     ),
    //     scaffoldBackgroundColor: const Color(0xFF421b9b),
    //     textTheme: Theme.of(context).textTheme.apply(fontFamily: 'PatrickHand'),
    //   ),
    //   home:const SplashScreen(),
    //   // initialRoute: 'homePage',
    //   // routes: {
    //   //   'homePage': (context) => HomeScreen(),
    //   //   'scorePage': (context) => const ScoreScreen(),
    //   // },
    // );
  }
}
