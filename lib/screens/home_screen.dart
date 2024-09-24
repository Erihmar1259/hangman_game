import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hangman_game/components/action_button.dart';
import 'package:hangman_game/controller/game_controller.dart';
import 'package:hangman_game/controller/home_controller.dart';
import 'package:hangman_game/screens/score_screen.dart';
import 'package:hangman_game/screens/settings/setting_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../local_storage.dart';
import '../utils/color_const.dart';
import '../utils/enum.dart';
import '../utils/global.dart';
import '../widgets/custom_text.dart';
import 'game_screen.dart';
import 'loading_screen.dart';

class HomeScreen extends StatefulWidget {


  HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();

    first = LocalStorage.instance.read(StorageKey.first.name) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      surfaceTintColor: whiteColor,
                      backgroundColor: whiteColor,
                      content: SizedBox(
                        height: 1.sh * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height: 1.sh * 0.65,
                                  width: double.infinity,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString(
                                            Global.language == Language.zh.name
                                                ? Global.policyZh
                                                : Global.language ==
                                                Language.vi.name
                                                ? Global.policyVi
                                                : Global.language ==
                                                Language.hi.name
                                                ? Global.policyHi
                                                : Global.policyEn))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: secondaryColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? secondaryColor
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'agree'.tr,
                                  color: secondaryColor,
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateColor.resolveWith((states) =>
                                  isAccepted
                                      ? secondaryColor
                                      : greyColor)),
                              // ignore: sort_child_properties_last
                              child: CustomText(
                                text: "accept".tr,
                                color: whiteColor,
                                fontSize: 14.sp,
                              ),
                              onPressed: isAccepted
                                  ? () async {
                                LocalStorage.instance.write(
                                    StorageKey.first.name, 'notfirst');
                                Navigator.pop(context);
                              }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

final gameController = Get.put(GameController());
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                child: const Text(
                  '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 58.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3.0),
                ),
              ),
              IconButton(onPressed: (){
                Get.to(SettingScreen());
              }, icon: Icon(Icons.settings))
            ],
          ),
          Center(
            child: Image.asset(
              'images/gallow.png',
              height: height * 0.49,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Center(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                    SizedBox(
                      width: 150.w,
                      height: 50.h,
                      child: ActionButton(
                        buttonTitle: 'start'.tr,
                        onPress: () {
if(gameController.remainingTime.value>0){
  Get.defaultDialog(
    barrierDismissible: false,
    backgroundColor: whiteColor,
    cancel: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child:Icon(Icons.home_filled,color: whiteColor,),
      ),
    ),

    title: 'sorry'.tr,

    titleStyle: TextStyle(
      fontSize: 15.sp,

    ),

    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text:"no_lives_left".tr,
          color: secondaryColor,
          fontSize: 18.sp,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text:'next_life_in'.tr,
              fontSize: 18.sp,
              color: secondaryColor,
            ),
            Obx(()=>
               CustomText(text: " ${gameController.formatTime(gameController.remainingTime.value)}", fontSize: 22.sp,
                color: Colors.red,),
            )
          ],
        ),
      ],
    ),
  );
}
else{
                            Get.to(const GameScreen());
                          }
                        },
                      ),
                    ),

                  const SizedBox(
                    height: 18.0,
                  ),
                  SizedBox(
                    width: 150.w,
                    height: 50.h,
                    child: ActionButton(
                      buttonTitle: 'high_score'.tr,
                      onPress: () {
                       Get.to(ScoreScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
