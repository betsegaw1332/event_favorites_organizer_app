part of 'favorite_folder_bloc.dart';

class FavoriteFolderState extends Equatable {
  final AppStateStatus stateStatus;
  final List<FolderModel>? favoriteFolders;
  final List<EventModel>? currentFolderEvents;
  final String? errorMessage;
  final AppError? error;
  const FavoriteFolderState({
    required this.stateStatus,
    this.favoriteFolders = const [],
    this.errorMessage,
    this.error,
    this.currentFolderEvents,
  });

  FavoriteFolderState copyWith({
    AppStateStatus? stateStatus,
    List<FolderModel>? favoriteFolders,
    String? errorMessage,
    AppError? error,
    List<EventModel>? currentFolderEvents,
  }) {
    return FavoriteFolderState(
      stateStatus: stateStatus ?? this.stateStatus,
      favoriteFolders: favoriteFolders ?? this.favoriteFolders,
      errorMessage: errorMessage ?? this.errorMessage,
      error: error ?? this.error,
      currentFolderEvents: currentFolderEvents ?? this.currentFolderEvents,
    );
  }

  @override
  List<Object?> get props => [
    stateStatus,
    favoriteFolders,
    errorMessage,
    currentFolderEvents,
  ];
}
