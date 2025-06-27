import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  const AppError({this.message});

  final String? message;
  @override
  List<Object?> get props => [message];
}

class LoadEventsFromJsonError extends AppError {
  const LoadEventsFromJsonError({
    super.message = "Couldn't load events from json",
  });
}
class AddEventsToFolderError extends AppError {
  const AddEventsToFolderError({
    super.message = "Couldn't add events to folder",
  });
}
class FailedToLoadFavoriteFolders extends AppError {
  const FailedToLoadFavoriteFolders({
    super.message = "Couldn't  load favorite folders",
  });
}
class FailedToLoadEventsInFolders extends AppError {
  const FailedToLoadEventsInFolders({
    super.message = "Couldn't  load events in folders",
  });
}

class FailedToCreateNewFolder extends AppError{
   const FailedToCreateNewFolder({
    super.message = "Failed to add new folder",
  });
}