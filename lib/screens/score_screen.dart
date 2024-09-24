import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hangman_game/controller/game_controller.dart';
import 'package:hangman_game/screens/settings/setting_screen.dart';
import 'package:hangman_game/utilities/constants.dart';
import 'package:hangman_game/utils/color_const.dart';
import 'package:hangman_game/utils/dimen_const.dart';
import 'package:hangman_game/widgets/custom_text.dart';
import 'package:hangman_game/widgets/setting_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScoreScreen extends StatelessWidget {
  final query;

  const ScoreScreen({super.key, this.query});


  @override
  Widget build(BuildContext context) {
    final gameController=Get.put(GameController());
    gameController.getScore();
    return Scaffold(
      appBar:AppBar(
        backgroundColor: secondaryColor,
        centerTitle: true,
        title: CustomText(text: 'your_best_score'.tr,fontSize: 16.sp,color: whiteColor,),
      ),
      body: Padding(
        padding:  EdgeInsets.all(8.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CustomText(text: 'your_best_score'.tr,color: whiteColor,fontSize: 16.sp,fontWeight: FontWeight.bold,),
            kSizedBoxH10,
            SettingsCardWidget(
                childWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'your_score'.tr,fontSize: 14.sp,fontWeight: FontWeight.bold,),
                    CustomText(text: "${gameController.score.value}",fontSize: 16.sp,fontWeight: FontWeight.bold,),
                  ],
                )
            ),
          ],
        ),
      )
    );
  }
}
