part of 'favorite_folder_bloc.dart';

abstract class FavoriteFolderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllFavoriteFoldersEvent extends FavoriteFolderEvent {}
class GetEventsInAFolderEvent extends FavoriteFolderEvent {
  final int folderID;

  GetEventsInAFolderEvent({required this.folderID});

  @override
  List<Object?> get props => [folderID];

}


class AddNewFavoriteFolderEvent extends FavoriteFolderEvent{
  final String name;

  AddNewFavoriteFolderEvent({required this.name});

  @override
  List<Object?> get props => [name];

}