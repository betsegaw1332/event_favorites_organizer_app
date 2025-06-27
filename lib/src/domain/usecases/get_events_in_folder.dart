import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

class GetEventsInFolder {
  GetEventsInFolder()
    : _eventRepository = serviceLocator.get<EventRepositoryImpl>();
  final EventRepository _eventRepository;

  Future<DataState<List<EventModel>>> call({required int folderID}) {
    return _eventRepository.getEventsInFolder(folderID: folderID);
  }
}
