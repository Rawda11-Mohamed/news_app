import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/splash_screen.dart';
import 'constants/app_colors.dart';
import 'repositories/articles_repository.dart';
import 'repositories/bookmarks_repository.dart';
import 'repositories/weather_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/location_repository.dart';
import 'cubits/location/location_cubit.dart';

import 'cubits/articles/articles_cubit.dart';
import 'cubits/bookmarks/bookmarks_cubit.dart';
import 'cubits/weather/weather_cubit.dart';
import 'cubits/search/search_cubit.dart';
import 'cubits/user/user_cubit.dart';

void main() {
  runApp(const KhaberApp());
}

class KhaberApp extends StatelessWidget {
  const KhaberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ArticlesRepository>(
          create: (context) => ArticlesRepository(),
        ),
        RepositoryProvider<BookmarksRepository>(
          create: (context) => BookmarksRepository(),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ArticlesCubit>(
            create: (context) => ArticlesCubit(
              context.read<ArticlesRepository>(),
            ),
          ),
          BlocProvider<BookmarksCubit>(
            create: (context) => BookmarksCubit(
              context.read<BookmarksRepository>(),
            ),
          ),
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(
              context.read<ArticlesRepository>(),
            ),
          ),
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
              context.read<UserRepository>(),
            ),
          ),
          BlocProvider<LocationCubit>(
            create: (context) => LocationCubit(
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Khaber',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'SF Pro Display',
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

