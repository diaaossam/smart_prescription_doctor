import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prescription/screens/login_packages/phone_screen/cubit/phone_cubit.dart';
import 'package:smart_prescription/screens/login_packages/splash_screen/splash_screen.dart';
import 'package:smart_prescription/shared/helper/bloc_observer.dart';
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
      providers: [
        BlocProvider(create: (context) => PhoneCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeManger.setLightTheme(),
        home: SplashScreen(),
      ),
    );
  }
}
