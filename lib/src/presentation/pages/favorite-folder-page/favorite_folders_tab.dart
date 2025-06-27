import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FavoriteFoldersTab extends StatelessWidget {
  const FavoriteFoldersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteFolderBloc, FavoriteFolderState>(
      listener: (context, favoriteFolderState) {
        if (favoriteFolderState.error != null &&
            favoriteFolderState.error is FailedToLoadFavoriteFolders) {
          AppHelperFunctions.showAppSnackBar(
            context,
            favoriteFolderState.errorMessage!,
          );
        }
      },
      builder: (context, favoriteFolderState) {
        if (favoriteFolderState.error != null &&
            favoriteFolderState.error is FailedToLoadFavoriteFolders) {
          return Center(child: Text("Failed to load folders"));
        } else {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.read<FavoriteFolderBloc>().add(
                    GetEventsInAFolderEvent(
                      folderID: favoriteFolderState.favoriteFolders![index].id,
                    ),
                  );
                  context.pushNamed(
                    AppRoutes.folderDetailPage,
                    extra: favoriteFolderState.favoriteFolders![index],
                  );
                },
                child: FolderCard(
                  folderData: favoriteFolderState.favoriteFolders![index],
                ),
              );
            },
            separatorBuilder:
                (context, index) => Divider(color: Colors.grey, height: 1),
            itemCount: favoriteFolderState.favoriteFolders!.length,
          );
        }
      },
    );
  }
}
