import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_app/cubit/cubit.dart';
import 'package:news/layout/news_app/news_layout.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'constant/bloc_observer.dart';
import 'layout/news_app/cubitAppMode/mode_cubit.dart';
import 'modules/search/search_screen.dart';

void main() async {
  // علشان المين بقي فيها التزامن لازم الكود دا يكون موجود
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBooleanData(key: 'isDark');
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // List value = NewsCubit.get(context)
    // SearchScreen searchScreen=SearchScreen();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessData()
            ..getSportData()
            ..getScienceData(),
        ),
        BlocProvider(
          create: (context) => ModeCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 40.0,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            //........................................................................
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              //primaryColor: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 40.0,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            //........................................................................
            themeMode: ModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
