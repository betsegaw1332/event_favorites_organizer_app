import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await serviceLocatorInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsListBloc>(
          create:
              (context) =>
                  serviceLocator.get<EventsListBloc>()
                    ..add(LoadAllEventsEvent()),
        ),
        BlocProvider<FavoriteFolderBloc>(
          create:
              (context) =>
                  serviceLocator.get<FavoriteFolderBloc>()
                    ..add(GetAllFavoriteFoldersEvent()),
        ),
      ],
      child: ScreenUtilInit(
        builder: ((context, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
          );
        }),
      ),
    );
  }
}
