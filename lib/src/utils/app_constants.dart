abstract class AppConstants{
  static String upcomingEventTitle="Upcoming Events";
  static String eventsTabName="Events";
  static String favoriteTabName="Favorites";
  static String eventsJsonDataPath="assets/json/data.json";
  static String appDatabaseName="event_favorites_organizer";
  static String addNewFolderText="Add New Folder";
  static String folderNameText = "Folder Name";
  static String saveToText="Save to";
}

enum AppStateStatus {
  initial,
  loadingBody,
  successLoaded,
  error,
  loadingButton,
  successSubmit
}

typedef JSON = Map<String, dynamic>;