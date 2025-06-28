import 'package:drift/drift.dart';
import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/data/data.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';

class EventOrganizerServices {
  final AppDatabase _appDatabase;

  EventOrganizerServices() : _appDatabase = serviceLocator.get<AppDatabase>();


  Future<DataState<List<FolderModel>>> getFavoriteFolders() async {
    try {
      final temp =
          _appDatabase.select(_appDatabase.folders)
            ..orderBy([
              (t) => OrderingTerm(
                expression: t.createdAt,
                mode: OrderingMode.asc,
              ), // Order by date first
            ])
            ..get();
      final response = await temp.get();
      final eventItems =
          response
              .map(
                (item) => FolderModel(
                  id: item.id,
                  name: item.name,
                  createdAt: item.createdAt,
                ),
              )
              .toList();
      return DataSuccess(eventItems);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<FolderModel>> createFolder({required String name}) async {
    // Prevent duplicate folder names

    try {
      final exists = await folderExists(name);
      if (exists) {
        return DataFailed(Exception("Folder '$name' already exists"));
      }

      final folderID = await _appDatabase
          .into(_appDatabase.folders)
          .insert(FoldersCompanion(name: Value(name)));

      return DataSuccess(
        FolderModel(id: folderID, name: name, createdAt: DateTime.now()),
      );
    } catch (e) {
      return DataFailed(Exception("Failed to create folder"));
    }
  }

  Future<DataState<String>> addEventToFolder({
    required EventModel event,
    required int folderId,
  }) async {
    try {
      // Get guaranteed event ID
      final eventId = await getOrCreateEventId(event: event);

      // Check if event already in folder
      final exists = await isEventInFolder(eventId, folderId);
      if (exists) {
        final folder =
            await (_appDatabase.select(_appDatabase.folders)
              ..where((tbl) => tbl.id.equals(folderId))).getSingle();
        return DataFailed(
          Exception('Event already exists in "${folder.name}" folder'),
        );
      }

      await _appDatabase
          .into(_appDatabase.folderEvents)
          .insert(
            FolderEventsCompanion.insert(folderId: folderId, eventId: eventId),
          );

      return DataSuccess("Event added to folder successfully");
    } catch (e) {
      return DataFailed(Exception("Failed to add event to folder"));
    }
  }

  Future<bool> folderExists(String name) async {
    final query = _appDatabase.select(_appDatabase.folders)
      ..where((tbl) => tbl.name.equals(name));

    return await query.getSingleOrNull() != null;
  }

  Future<int> getOrCreateEventId({required EventModel event}) async {
    final query = _appDatabase.select(_appDatabase.events)
      ..where((tbl) => tbl.id.equals(event.id));

    final existing = await query.getSingleOrNull();

    if (existing != null) return existing.id;

    final id = await _appDatabase
        .into(_appDatabase.events)
        .insert(
          EventsCompanion.insert(
            id: Value(event.id),
            title: event.title,
            date: event.date.toString(),
            imageUrl: event.imageUrl,
          ),
        );

    return id;
  }

  Future<bool> isEventInFolder(int eventId, int folderId) async {
    final query =
        _appDatabase.select(_appDatabase.folderEvents)
          ..where((tbl) => tbl.eventId.equals(eventId))
          ..where((tbl) => tbl.folderId.equals(folderId));

    return await query.getSingleOrNull() != null;
  }

  Future<DataState<List<EventModel>>> getEventsInFolder({
    required int folderId,
  }) async {
    try {
      final query = _appDatabase.select(_appDatabase.events).join([
        innerJoin(
          _appDatabase.folderEvents,
          _appDatabase.folderEvents.eventId.equalsExp(_appDatabase.events.id),
        ),
      ])..where(_appDatabase.folderEvents.folderId.equals(folderId));

      final results = await query.get();

      final response =
          results.map((row) {
            return EventModel(
              id: row.readTable(_appDatabase.events).id,
              title: row.readTable(_appDatabase.events).title,
              date: DateTime.parse(row.readTable(_appDatabase.events).date),
              imageUrl: row.readTable(_appDatabase.events).imageUrl,
            );
          }).toList();

      return DataSuccess(response);
    } catch (e) {
      return DataFailed(Exception(e.toString()));
    }
  }
}
