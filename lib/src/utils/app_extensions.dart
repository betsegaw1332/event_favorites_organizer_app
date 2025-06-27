import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension DoubleExt on double {
  SizedBox get heightSpace => SizedBox(height: h);

  SizedBox get widthSpace => SizedBox(width: w);
}

extension DateTimeExtensions on DateTime {
  String getEventDateFormate() {
    return DateFormat('yMMMMd').format(this);
  }
}
