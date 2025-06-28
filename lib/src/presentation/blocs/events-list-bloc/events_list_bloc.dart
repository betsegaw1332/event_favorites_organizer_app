import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:event_favorites_organizer/service_locator.dart';
import 'package:event_favorites_organizer/src/config/config.dart';
import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_list_event.dart';
part 'events_list_state.dart';

class EventsListBloc extends Bloc<EventsListEvent, EventListState> {
  EventsListBloc()
    : _addEventToFolder = serviceLocator.get<AddEventToFolder>(),
      super(EventListState(stateStatus: AppStateStatus.initial)) {
    on<LoadAllEventsEvent>(_loadEventsFromJsonFile);
    on<AddEventToFolderEvent>(_onAddEventToFolderEvent);
   
  }

  final AddEventToFolder _addEventToFolder;

  _loadEventsFromJsonFile(
    LoadAllEventsEvent event,
    Emitter<EventListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          stateStatus: AppStateStatus.loadingBody,
          error: null,
          message: null,
        ),
      );

      final String jsonString = await rootBundle.loadString(
        AppConstants.eventsJsonDataPath,
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      final events = jsonData.map((item) => EventModel.fromJson(item)).toList();

      emit(
        state.copyWith(
          stateStatus: AppStateStatus.successLoaded,
          eventsData: events,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          stateStatus: AppStateStatus.error,
          error: LoadEventsFromJsonError(),

        ),
      );
    }
  }

  _onAddEventToFolderEvent(
    AddEventToFolderEvent event,
    Emitter<EventListState> emit,
  ) async {
    emit(
     EventListState(
        stateStatus: AppStateStatus.loadingButton,
        currentAddedEventID: event.event.id,
        eventsData: state.eventsData,
        error: null,
        message: null,
      ),
    );

    try {
      final response = await _addEventToFolder(
        event: event.event,
        folderID: event.folderID,
      );

      if (response is DataSuccess) {
        emit(state.copyWith(stateStatus: AppStateStatus.successSubmit));
      } else {
        emit(
          state.copyWith(
            message: response.error.toString().replaceFirst('Exception: ', ''),
            stateStatus: AppStateStatus.error,
            error: AddEventsToFolderError(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString().replaceFirst('Exception: ', ''),
          stateStatus: AppStateStatus.error,
          error: AddEventsToFolderError(),
        ),
      );
    }
  }
}
