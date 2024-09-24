import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hangman_game/controller/game_controller.dart';
import 'package:hangman_game/controller/home_controller.dart';
import 'package:hangman_game/utilities/constants.dart';
import 'package:hangman_game/utilities/hangman_words.dart';
import 'package:hangman_game/utils/color_const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/custom_text.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key,});



  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController());
    final homeController = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Perform your UI update or state change after the frame is rendered
      if (!gameController.resetGame.value) {
        gameController.initWords(homeController.hangmanWords);
      }
    });
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Obx(()=>
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 0.5),
                                  child: IconButton(
                                    tooltip: 'Lives',
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    iconSize: 39,
                                    icon: Icon(MdiIcons.heart),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.7, 7.9, 0, 0.8),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 38,
                                    width: 38,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Obx(()=>
                                        Text(
                                            gameController.lives.value.toString() == "1"
                                                ? "I"
                                                : gameController.lives.value.toString(),
                                            style: const TextStyle(
                                              color: Color(0xFF2C1E68),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'PatrickHand',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Obx(()=>
                         SizedBox(
                            child: Text(
                              gameController.wordCount.value == 1 ? "I" : '${gameController.wordCount.value}',
                              style: kWordCounterTextStyle,
                            ),
                          ),
                        ),
                        Obx(()=>
                          SizedBox(
                            child: IconButton(
                              tooltip: 'Hint',
                              iconSize: 39,
                              icon: Icon(MdiIcons.lightbulb),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: gameController.hintStatus.value
                                  ? () {
                                      int rand = Random()
                                          .nextInt(gameController.hintLetters.length);
                                      gameController.wordPress(gameController.englishAlphabet.alphabet
                                          .indexOf(
                                          gameController.wordList[gameController.hintLetters[rand]]));
                                      gameController.hintStatus.value = false;
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(()=>
                      SizedBox(
                        height:MediaQuery.of(context).size.height*.2,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset(
                            'images/${gameController.hangState.value}.png',
                            height: 200,
                            width: 150,
                            gaplessPlayback: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(()=>
                     SizedBox(
                       height:MediaQuery.of(context).size.height*.2,
                      child: (gameController.word.isEmpty)
                          ? const CircularProgressIndicator()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 200.w
                                ,
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(
                                  'images/${gameController.word}.webp',
                                  width: 200.w
                                  ,
                                   height: 150.h,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Obx(()=>
                    SizedBox(
                      height:MediaQuery.of(context).size.height*.1,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35.0),
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            gameController.hiddenWord.value,
                            style: kWordTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (gameController.remainingTime.value > 0)?Padding(
                padding:  EdgeInsets.only(bottom: 15.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text:"no_lives_left".tr,
                     color: whiteColor,
                      fontSize: 18.sp,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text:'next_life_in'.tr,
                          fontSize: 18.sp,
                          color: whiteColor,
                        ),
                        CustomText(text: " ${gameController.formatTime(gameController.remainingTime.value)}", fontSize: 22.sp,
                          color: Colors.red,)
                      ],
                    ),
                  ],
                ),
              ): Container(
                padding: const EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  //columnWidths: {1: FlexColumnWidth(10)},
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: gameController.createButton(0),
                      ),
                      TableCell(
                        child: gameController.createButton(1),
                      ),
                      TableCell(
                        child: gameController.createButton(2),
                      ),
                      TableCell(
                        child: gameController.createButton(3),
                      ),
                      TableCell(
                        child: gameController.createButton(4),
                      ),
                      TableCell(
                        child: gameController.createButton(5),
                      ),
                      TableCell(
                        child: gameController.createButton(6),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: gameController.createButton(7),
                      ),
                      TableCell(
                        child: gameController.createButton(8),
                      ),
                      TableCell(
                        child: gameController.createButton(9),
                      ),
                      TableCell(
                        child: gameController.createButton(10),
                      ),
                      TableCell(
                        child: gameController.createButton(11),
                      ),
                      TableCell(
                        child: gameController.createButton(12),
                      ),
                      TableCell(
                        child: gameController.createButton(13),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: gameController.createButton(14),
                      ),
                      TableCell(
                        child: gameController.createButton(15),
                      ),
                      TableCell(
                        child: gameController.createButton(16),
                      ),
                      TableCell(
                        child: gameController.createButton(17),
                      ),
                      TableCell(
                        child: gameController.createButton(18),
                      ),
                      TableCell(
                        child: gameController.createButton(19),
                      ),
                      TableCell(
                        child: gameController.createButton(20),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: gameController.createButton(21),
                      ),
                      TableCell(
                        child: gameController.createButton(22),
                      ),
                      TableCell(
                        child: gameController.createButton(23),
                      ),
                      TableCell(
                        child: gameController.createButton(24),
                      ),
                      TableCell(
                        child: gameController.createButton(25),
                      ),
                      const TableCell(
                        child: Text(''),
                      ),
                      const TableCell(
                        child: Text(''),
                      ),
                    ]),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){Get.back();},
                child: Container(
                  margin: EdgeInsets.all(8.w),
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.arrow_back_ios_new,color: secondaryColor,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
