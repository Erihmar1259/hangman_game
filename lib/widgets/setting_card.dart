import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hangman_game/utils/color_const.dart';

class SettingsCardWidget extends StatelessWidget {
  const SettingsCardWidget({super.key, required this.childWidget, this.cardColor});
  final Widget childWidget;
  final Color? cardColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderOnForeground: true,
      surfaceTintColor:cardColor?? whiteColor,
      color:cardColor?? whiteColor,
      elevation: 5,
      shadowColor: greyColor,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: cardColor??whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: childWidget,
      ),
    );
  }
}
