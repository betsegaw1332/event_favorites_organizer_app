import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/app_extensions.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FolderSelectorBottomsheet extends StatefulWidget {
  const FolderSelectorBottomsheet({super.key, required this.eventData});

  final EventModel eventData;

  static Future<void> showBottomSheetDialog(
    BuildContext context,
    EventModel eventData,
  ) async {
    return await AppUIUtil.showBottomSheetDialog(
      context,
      widget: FolderSelectorBottomsheet(eventData: eventData),
    );
  }

  @override
  State<FolderSelectorBottomsheet> createState() =>
      _FolderSelectorBottomsheetState();
}

class _FolderSelectorBottomsheetState extends State<FolderSelectorBottomsheet> {
  @override
  Widget build(BuildContext context) {
    final favoriteFolders =
        context.read<FavoriteFolderBloc>().state.favoriteFolders;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppConstants.saveToText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
          ),
          5.h.heightSpace,

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: AlwaysScrollableScrollPhysics(),
              primary: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<EventsListBloc>().add(
                      AddEventToFolderEvent(
                        event: widget.eventData,
                        folderID: favoriteFolders[index].id,
                      ),
                    );
                  },
                  child: FolderCard(folderData: favoriteFolders[index]),
                );
              },
          
              itemCount: favoriteFolders!.length,
            ),
          ),
        ],
      ),
    );
  }
}
