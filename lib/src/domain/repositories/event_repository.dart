import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

abstract class EventRepository {
  Future<DataState<String>> addEventToFolder({
    required EventModel event,
    required int folderID,
  });

  Future<DataState<List<EventModel>>> getEventsInFolder({
    required int folderID,
  });
}
