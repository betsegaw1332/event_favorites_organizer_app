import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingEventsTab extends StatefulWidget {
  const UpcomingEventsTab({super.key});

  @override
  State<UpcomingEventsTab> createState() => _UpcomingEventsTabState();
}

class _UpcomingEventsTabState extends State<UpcomingEventsTab> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsListBloc, EventListState>(
      listener: (context, eventsState) {
        if (eventsState.error != null &&
            eventsState.error is LoadEventsFromJsonError) {
          AppHelperFunctions.showAppSnackBar(
            context,
            eventsState.message!,
            backgroundColor: Colors.red,
          );
        } else if (eventsState.error != null &&
            eventsState.error is AddEventsToFolderError) {
          AppHelperFunctions.showAppSnackBar(
            context,
            eventsState.message!,
            backgroundColor: Colors.red,
          );
        } else if (eventsState.stateStatus == AppStateStatus.successSubmit) {
          AppHelperFunctions.showAppSnackBar(
            context,
            "Event Added to folder",
            backgroundColor: Colors.green,
          );
        }
      },
      builder: (context, eventsState) {
        if (eventsState.stateStatus == AppStateStatus.loadingBody ||
            eventsState.stateStatus == AppStateStatus.initial) {
          return SizedBox(
            height: 15.h,
            width: 15.h,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (eventsState.error != null &&
            eventsState.error is LoadEventsFromJsonError) {
          return Center(child: Text("Failed to load upcoming events"));
        } else {
          return SingleChildScrollView(
            child: Column(
              children:
                  eventsState.eventsData!
                      .map(
                        (event) => EventCard(
                          eventData: event,
                          isLoading:
                              eventsState.stateStatus ==
                                  AppStateStatus.loadingButton &&
                              event.id == eventsState.currentAddedEventID,
                        ),
                      )
                      .toList(),
            ),
          );
        }
      },
    );
  }
}
