import 'package:event_favorites_organizer/src/presentation/presentation.dart';
import 'package:event_favorites_organizer/src/utils/app_extensions.dart';
import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddFolderBottomsheet extends StatefulWidget {
  const AddFolderBottomsheet({super.key});

  static Future<void> showBottomSheetDialog(BuildContext context) async {
    return await AppUIUtil.showBottomSheetDialog(
      context,
      widget: const AddFolderBottomsheet(),
    );
  }

  @override
  State<AddFolderBottomsheet> createState() => _AddFolderBottomsheetState();
}

class _AddFolderBottomsheetState extends State<AddFolderBottomsheet> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppConstants.addNewFolderText,
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
            50.h.heightSpace,
            TextFormField(
              controller: _controller,
              validator: (value) => AppUIUtil.validateInput(value!),
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.5.h,
                  horizontal: 10.w,
                ),
                labelText: AppConstants.folderNameText,
                labelStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(),
              ),
            ),
            14.h.heightSpace,
            BlocConsumer<FavoriteFolderBloc, FavoriteFolderState>(
              listener: (context, favoriteFolderState) {
                if (favoriteFolderState.error != null &&
                    favoriteFolderState.error is FailedToCreateNewFolder) {
                  AppHelperFunctions.showAppSnackBar(
                    context,
                    favoriteFolderState.errorMessage!,
                    backgroundColor: Colors.red,
                  );
                } else if (favoriteFolderState.stateStatus ==
                    AppStateStatus.successSubmit) {
                  AppHelperFunctions.showAppSnackBar(
                    context,
                    "Folder Created!",
                    backgroundColor: Colors.green,
                  );
                }
              },
              builder: (context, favoriteFolderSate) {
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  label:
                      favoriteFolderSate.stateStatus ==
                              AppStateStatus.loadingButton
                          ? SizedBox(
                            height: 15.h,
                            width: 15.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                          : Text('Add'),

                  onPressed:
                      favoriteFolderSate.stateStatus ==
                              AppStateStatus.loadingButton
                          ? () {}
                          : () {
                            if (!_formKey.currentState!.validate()) {
                              AppHelperFunctions.showAppSnackBar(
                                context,
                                "Name can not be empty",
                              );
                            } else {
                              context.read<FavoriteFolderBloc>().add(
                                AddNewFavoriteFolderEvent(
                                  name: _controller.text,
                                ),
                              );
                            }
                          },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
