import 'package:equatable/equatable.dart';
import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/data_state.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_folder_state.dart';
part 'favorite_folder_event.dart';

class FavoriteFolderBloc
    extends Bloc<FavoriteFolderEvent, FavoriteFolderState> {
  FavoriteFolderBloc()
    : _getFavoriteFolderUsecase = serviceLocator.get<GetFavoriteFolders>(),
      _addFavoriteFolderUsecase = serviceLocator.get<AddFavoriteFolder>(),
      _getEventsInAFolderUsecase = serviceLocator.get<GetEventsInFolder>(),
      super(
        FavoriteFolderState(
          stateStatus: AppStateStatus.initial,
          favoriteFolders: List.generate(5, (index) => FolderModel.mockData()),
        ),
      ) {
    on<GetAllFavoriteFoldersEvent>(_onGetEventItemsEvent);
    on<AddNewFavoriteFolderEvent>(_onAddNewFavoriteFolderEvent);
    on<GetEventsInAFolderEvent>(_onGetEventsByFolderID);
  }

  final GetFavoriteFolders _getFavoriteFolderUsecase;
  final AddFavoriteFolder _addFavoriteFolderUsecase;
  final GetEventsInFolder _getEventsInAFolderUsecase;

  _onGetEventItemsEvent(
    GetAllFavoriteFoldersEvent event,
    Emitter<FavoriteFolderState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          stateStatus: AppStateStatus.loadingBody,
          error: null,
          errorMessage: null,
        ),
      );

      final response = await _getFavoriteFolderUsecase();

      if (response is DataSuccess) {
        final favoriteFolders = response.data;

        emit(
          state.copyWith(
            stateStatus: AppStateStatus.successLoaded,
            favoriteFolders: favoriteFolders,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: "Failed To Fetch event items",
            error: FailedToLoadFavoriteFolders(),
            stateStatus: AppStateStatus.error,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          error: FailedToLoadFavoriteFolders(),
          stateStatus: AppStateStatus.error,
        ),
      );
    }
  }

  _onGetEventsByFolderID(
    GetEventsInAFolderEvent event,
    Emitter<FavoriteFolderState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          stateStatus: AppStateStatus.loadingBody,
          error: null,
          errorMessage: null,
        ),
      );

      final response = await _getEventsInAFolderUsecase(
        folderID: event.folderID,
      );

      if (response is DataSuccess) {
        final currentFolderEvents = response.data;
        emit(
          state.copyWith(
            stateStatus: AppStateStatus.successLoaded,
            currentFolderEvents: currentFolderEvents,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: response.error.toString().replaceFirst('Exception: ', ''),
            error: FailedToLoadEventsInFolders(),
            stateStatus: AppStateStatus.error,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          error: FailedToLoadEventsInFolders(),
          stateStatus: AppStateStatus.error,
        ),
      );
    }
  }

  _onAddNewFavoriteFolderEvent(
    AddNewFavoriteFolderEvent event,
    Emitter<FavoriteFolderState> emit,
  ) async {
    try {
      emit(
       FavoriteFolderState(
          stateStatus: AppStateStatus.loadingButton,
          error: null,
          errorMessage: null,
          favoriteFolders: state.favoriteFolders,
          currentFolderEvents: state.currentFolderEvents
        ),
      );

      final response = await _addFavoriteFolderUsecase(name: event.name);

      if (response is DataSuccess) {
        final newFolder = response.data;
        emit(
          state.copyWith(
            stateStatus: AppStateStatus.successSubmit,
            favoriteFolders: [...state.favoriteFolders!, newFolder!],
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage:response.error.toString().replaceFirst('Exception: ', ''),
             stateStatus:AppStateStatus.error,
            error: FailedToCreateNewFolder(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          error: FailedToCreateNewFolder(),
           stateStatus:AppStateStatus.error,
        ),
      );
    }
  }
}
