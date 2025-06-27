import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> serviceLocatorInit() async {
  //services singletons
  serviceLocator.registerSingleton<AppDatabase>(AppDatabase());
  serviceLocator.registerSingleton<EventOrganizerServices>(
    EventOrganizerServices(),
  );

  //repository factories
  serviceLocator.registerFactory<FolderRepositoryImpl>(
    () => FolderRepositoryImpl(),
  );
  serviceLocator.registerFactory<EventRepositoryImpl>(
    () => EventRepositoryImpl(),
  );

  //usecase factories
  serviceLocator.registerFactory<GetFavoriteFolders>(
    () => GetFavoriteFolders(),
  );
  serviceLocator.registerFactory<AddFavoriteFolder>(() => AddFavoriteFolder());
  serviceLocator.registerFactory<AddEventToFolder>(() => AddEventToFolder());
  serviceLocator.registerFactory<GetEventsInFolder>(() => GetEventsInFolder());

  serviceLocator.registerSingleton<EventsListBloc>(EventsListBloc());
  serviceLocator.registerSingleton<FavoriteFolderBloc>(FavoriteFolderBloc());
}
