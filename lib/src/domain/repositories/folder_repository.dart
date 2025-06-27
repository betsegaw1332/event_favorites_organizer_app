import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

abstract class FolderRepository {
  Future<DataState<List<FolderModel>>> getAllFolders();
  Future<DataState<FolderModel>> createFolder({required String name});
}
