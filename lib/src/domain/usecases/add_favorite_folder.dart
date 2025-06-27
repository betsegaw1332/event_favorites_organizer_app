import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

class AddFavoriteFolder {
  AddFavoriteFolder()
    : _folderRepository = serviceLocator.get<FolderRepositoryImpl>();
  final FolderRepository _folderRepository;

  Future<DataState<FolderModel>> call({required String name}) {
    return _folderRepository.createFolder(name: name);
  }
}
