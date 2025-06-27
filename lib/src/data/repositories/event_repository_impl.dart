import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/data_state.dart';
import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

class EventRepositoryImpl implements EventRepository {
  final EventOrganizerServices _eventOrganizerServices;

  EventRepositoryImpl()
    : _eventOrganizerServices = serviceLocator.get<EventOrganizerServices>();

  @override
  Future<DataState<String>> addEventToFolder({
    required EventModel event,
    required int folderID,
  }) async {
    return _eventOrganizerServices.addEventToFolder(
      event: event,
      folderId: folderID,
    );
  }

  @override
  Future<DataState<List<EventModel>>> getEventsInFolder({
    required int folderID,
  }) async {
    return _eventOrganizerServices.getEventsInFolder(folderId: folderID);
  }
}
