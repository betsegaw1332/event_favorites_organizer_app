part of 'events_list_bloc.dart';

class EventListState extends Equatable {
  final AppStateStatus stateStatus;
  final AppError? error;
  final List<EventModel>? eventsData;
  final String? message;
  final int? currentAddedEventID;
  const EventListState({
    required this.stateStatus,
    this.error,
    this.message,
    this.eventsData = const [],
    this.currentAddedEventID
  });

  EventListState copyWith({
    AppStateStatus? stateStatus,
    AppError? error,
    List<EventModel>? eventsData,
    String? message,
    int? currentAddedEventID,
  }) {
    return EventListState(
      stateStatus: stateStatus ?? this.stateStatus,
      error: error ?? this.error,
      message: message ?? this.message,
      eventsData: eventsData ?? this.eventsData,
      currentAddedEventID:currentAddedEventID??this.currentAddedEventID
    );
  }

  @override
  List<Object?> get props => [stateStatus, error, message, eventsData,currentAddedEventID];
}
