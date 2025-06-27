import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppUIUtil {
  static Future<dynamic> showBottomSheetDialog(
    BuildContext context, {
    required Widget widget,
    double height = .55,
    bool isDynamic = false,
  }) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,

      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder:
          (context) => ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: SizedBox(
              height: isDynamic ? null : height.sh,
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SafeArea(
                      child: SizedBox(
                        height: isDynamic ? null : height.sh,
                        child: widget,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  static String? validateInput(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return 'Invalid Input';
    }
    return null;
  }
}
