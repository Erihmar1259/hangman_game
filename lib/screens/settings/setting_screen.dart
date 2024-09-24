import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hangman_game/utils/color_const.dart';
import 'package:hangman_game/utils/dimen_const.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/setting_card.dart';
import 'change_language.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
            toolbarHeight: kToolbarHeight+10.h,
            backgroundColor: const Color(0xFF421b9b),
            centerTitle: true,
            title:CustomText(text: "settings".tr,color: whiteColor,)
        ),
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: ListView(
            children: [
              CustomText(text: 'general'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,color: whiteColor),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ChangeLanguageScreen());
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("images/language.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'language'.tr,fontWeight: FontWeight.bold)
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'lang'.tr,
                             color: greyColor.withOpacity(0.6),
                          ),
                          Image.asset("images/forward.webp",width: 15.w,height: 15.h,color: secondaryColor,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              kSizedBoxH20,
              CustomText(text: 'other'.tr,fontWeight: FontWeight.bold,fontSize: 14.sp,color: whiteColor),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
                child: SettingsCardWidget(
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("images/policy.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'policy'.tr,fontWeight: FontWeight.bold,)
                        ],
                      ),
                      Image.asset("images/forward.webp",width: 15.w,height: 15.h,color: secondaryColor,),
                    ],
                  ),
                ),
              ),
              kSizedBoxH20,
              SettingsCardWidget(
                childWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/info.webp",width: 20.w,height: 20.h,color: secondaryColor,),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(text: 'version'.tr,fontWeight: FontWeight.bold,),
                      ],
                    ),
                    const CustomText(text: '1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
