import 'package:event_favorites_organizer/src/domain/domain.dart';
import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FolderDetailPage extends StatelessWidget {
  const FolderDetailPage({super.key, required this.folderData});

  final FolderModel folderData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folderData.name, style: TextStyle(fontSize: 18)),
      ),

      body: BlocConsumer<FavoriteFolderBloc, FavoriteFolderState>(
        listener: (context, favoriteFolderState) {
          if (favoriteFolderState.error != null &&
              favoriteFolderState.error is FailedToLoadEventsInFolders) {
            AppHelperFunctions.showAppSnackBar(
              context,
              favoriteFolderState.errorMessage!,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, favoriteFolderState) {
          if (favoriteFolderState.stateStatus == AppStateStatus.loadingBody ||
              favoriteFolderState.stateStatus == AppStateStatus.initial) {
            return SizedBox(
              height: 15.h,
              width: 15.h,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (favoriteFolderState.error != null &&
              favoriteFolderState.error is FailedToLoadEventsInFolders) {
            return Center(child: Text("Failed to load events  in this folder"));
          } else if (favoriteFolderState.currentFolderEvents!.isEmpty) {
            return Center(
              child: Text("This folder doesn't have events currently!"),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children:
                    favoriteFolderState.currentFolderEvents!
                        .map(
                          (event) => EventCard(
                            eventData: event,
                            isFromFolderDetail: true,
                          ),
                        )
                        .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
