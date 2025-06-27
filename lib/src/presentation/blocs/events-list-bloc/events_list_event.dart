part of 'events_list_bloc.dart';

abstract class EventsListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllEventsEvent extends EventsListEvent {}

class AddEventToFolderEvent extends EventsListEvent {
  final EventModel event;
  final int folderID;

  AddEventToFolderEvent({required this.event, required this.folderID});
}

class ReinitStateEvent extends EventsListEvent{}