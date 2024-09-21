import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../utils/color_const.dart';


class CustomCircleLoading extends StatelessWidget {
  const CustomCircleLoading({super.key,  this.type, this.colors, this.width, this.height});
  final Indicator? type;
  final List<Color>? colors;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width?? 50.w,
      height:height?? 50.h,
      child:  LoadingIndicator(
          indicatorType:type?? Indicator.ballPulseSync,
          colors: colors?? [Colors.green,secondaryColor,Colors.blue,],
          strokeWidth: 1
      ),
    );
  }
}
