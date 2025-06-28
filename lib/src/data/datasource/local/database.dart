// Database schema
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';

import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Events extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get date => text()();
  TextColumn get imageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Folders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class FolderEvents extends Table {
  IntColumn get folderId =>
      integer().customConstraint('REFERENCES folders(id) ON DELETE CASCADE NOT NULL')();
  IntColumn get eventId =>
      integer().customConstraint('REFERENCES events(id) ON DELETE CASCADE NOT NULL')();

  @override
  Set<Column> get primaryKey => {folderId, eventId};

  
}

// Database operations

@DriftDatabase(tables: [Events, Folders, FolderEvents])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()){
    initDefaultFolder();
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: AppConstants.appDatabaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<void> initDefaultFolder() async {

    // Check if default folder already exists
    final defaultFolder = await (select(folders)
      ..where((tbl) => tbl.isDefault.equals(true)))
      .getSingleOrNull();

    // Create if doesn't exist
    if (defaultFolder == null) {
      await into(folders).insert(
        FoldersCompanion.insert(
          name: "All Events",
          isDefault: Value(true),
        ),
      );
    }
  }
}
