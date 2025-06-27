import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

class AddEventToFolder {
  AddEventToFolder()
    : _eventRepository = serviceLocator.get<EventRepositoryImpl>();
  final EventRepository _eventRepository;

  Future<DataState<String>> call({
    required EventModel event,
    required int folderID,
  }) {
    return _eventRepository.addEventToFolder(event: event, folderID: folderID);
  }
}
