import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox getSizeBox({
  double height = 14.0,
  double width = double.maxFinite,

}) {
  return SizedBox(
    height: height.h,
    width: width.w,
  );
}