import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/data_state.dart';
import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

class FolderRepositoryImpl implements FolderRepository {
  final EventOrganizerServices _eventOrganizerServices;

  FolderRepositoryImpl()
    : _eventOrganizerServices = serviceLocator.get<EventOrganizerServices>();

  @override
  Future<DataState<List<FolderModel>>> getAllFolders() async {
    return _eventOrganizerServices.getFavoriteFolders();
  }

  @override
  Future<DataState<FolderModel>> createFolder({required String name}) {
    return _eventOrganizerServices.createFolder(name: name);
  }
}
