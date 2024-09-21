import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hangman_game/utils/color_const.dart';
import 'package:hangman_game/utils/dimen_const.dart';

import 'custom_text.dart';

class FmCardWidget extends StatelessWidget {
  const FmCardWidget({super.key,required this.label, required this.onTap, required this.onTapFav, required this.favImg});

final String label;
final Function() onTap;
final Function() onTapFav;
final String favImg;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: whiteColor,
              //border: Border.all(color: secondaryColor,width: 0.6),
              boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ]),
        child: Stack(
          children: [
            Positioned(
                right: 0.w,
                child: InkWell(
                    onTap: onTapFav,
                    child: Image.asset(favImg,width: 20.w,height: 20.h,color: secondaryColor,))),
            Center(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/fm.webp",
                    width: 50.w,
                    height: 50.h,
                  ),
                   kSizedBoxH5,
                   SizedBox(
                       height: 30.h,
                       child: CustomText(text: label,fontWeight: FontWeight.bold,maxLines: 2,textAlign: TextAlign.center,))
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
