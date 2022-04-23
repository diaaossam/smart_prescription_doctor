import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_prescription/screens/phone_screen/cubit/phone_cubit.dart';
import 'package:smart_prescription/screens/splash_screen/splash_screen.dart';
import 'package:smart_prescription/shared/helper/bloc_observer.dart';
import 'package:smart_prescription/shared/helper/lang_helper/app_local.dart';
import 'package:smart_prescription/shared/services/local/cache_helper.dart';
import 'package:smart_prescription/shared/styles/styles.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      CachedHelper.init();
      Firebase.initializeApp();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => PhoneCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("en", "US"),
          Locale("ar", "EG"),
        ],
        localeResolutionCallback: (locale, supportLang) {
          for (var suportedLocal in supportLang) {
            if (suportedLocal.languageCode == locale!.languageCode &&
                suportedLocal.countryCode == locale.countryCode) {
              return suportedLocal;
            }
          }
          return supportLang.first;
        },
        theme: ThemeManger.setLightTheme(),
        darkTheme: ThemeManger.setDarkTheme(),
        home: SplashScreen(),
      ),
    );
  }
}
