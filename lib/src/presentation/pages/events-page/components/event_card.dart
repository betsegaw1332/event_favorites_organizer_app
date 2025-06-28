import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/app_extensions.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCard extends StatelessWidget {
  final EventModel eventData;
  final bool isLoading;
  final bool isFromFolderDetail;
  const EventCard({
    super.key,
    required this.eventData,
    this.isLoading = false,
    this.isFromFolderDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteFolderBloc, FavoriteFolderState>(
      builder: (context, favoriteFolderState) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
          child: Row(
            children: [
              // Image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  eventData.imageUrl,
                  width: 90.w,
                  height: 65.h,
                  fit: BoxFit.cover,
                ),
              ),
              16.w.widthSpace,

              // Title and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventData.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      eventData.date.getEventDateFormate(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Heart icon
              isLoading
                  ? SizedBox(
                    height: 15.h,
                    width: 15.h,
                    child: CircularProgressIndicator(),
                  )
                  : isFromFolderDetail
                  ? SizedBox.shrink()
                  : IconButton(
                    icon: Icon(Icons.favorite_outline, color: Colors.black),
                    onPressed: () {
                      if (favoriteFolderState.favoriteFolders != null &&
                          favoriteFolderState.favoriteFolders!.length > 1) {
                        FolderSelectorBottomsheet.showBottomSheetDialog(
                          context,
                          eventData,
                        );
                      } else {
                        context.read<EventsListBloc>().add(
                          AddEventToFolderEvent(
                            event: eventData,
                            folderID:
                                favoriteFolderState.favoriteFolders!.first.id,
                          ),
                        );
                      }
                    },
                  ),
            ],
          ),
        );
      },
    );
  }
}
