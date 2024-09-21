// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:sport_fm_radio/utils/color_const.dart';
// import '../models/station_lists.dart';
//
// class RadioController extends GetxController {
//   AudioPlayer player = AudioPlayer();
//   final box = GetStorage();
//   final fav = ''.obs;
//
//   late RxList<StationListsModel> stationLists = <StationListsModel>[].obs;
//   RxList<StationListsModel> favLists = <StationListsModel>[].obs;
//   RxList<StationListsModel> searchLists = <StationListsModel>[].obs;
//
//   Rx<TextEditingController> searchController = TextEditingController().obs;
//
//   RxString name = "".obs;
//
//   Rx<int> selectedIndex = 0.obs;
//   Rx<int> selectedFavIndex = 0.obs;
//   Rx<int> selectedSearchIndex = 0.obs;
//
//   RxBool isFavLoading = false.obs;
//   RxBool isLoading = false.obs;
//   RxBool isPause = false.obs;
//   RxBool isAudioLoading = false.obs;
//
//   @override
//   void onInit() async {
//     dataInsert();
//     getFavList();
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     player.dispose();
//     searchController.value.dispose();
//     player.stop();
//     super.onClose();
//   }
//
//   @override
//   void dispose() {
//     player.stop();
//     searchController.value.dispose();
//     player.dispose();
//     super.dispose();
//   }
//
//   ///get fav list
//   getFavList() {
//     isFavLoading.value = true;
//     fav.value = box.read('fav') ?? '[]';
//     favLists.clear();
//     favLists.addAll(jsonDecode(fav.value).map<StationListsModel>((item) {
//       return StationListsModel.fromJson(item);
//     }));
//     Future.delayed(const Duration(milliseconds: 500), () {
//       isFavLoading.value = false;
//     });
//   }
//
//   setText(String value) {
//     searchController.value.text = value;
//   }
//
//   clearSearchList() {
//     searchLists.clear();
//   }
//
//   searchChannel(String searchText) {
//     isLoading.value = true;
//     searchLists.clear();
//     searchLists.value = stationLists
//         .where((element) => (element.stationName
//             .toLowerCase()
//             .contains(searchText.toLowerCase())))
//         .toList();
//     Future.delayed(const Duration(milliseconds: 500), () {
//       isLoading.value = false;
//     });
//   }
//
//   ///normal play
//   playRadio(String url, String channelName, int index) {
//     name.value = channelName;
//     selectedIndex.value = index;
//     player.setUrl(url).then((_) {});
//     if (url.isNotEmpty) {
//       player.play();
//
//       isPause.value = true;
//     }
//
//     player.positionStream.listen((position) {});
//     player.playerStateStream.listen((event) {
//       final processingState = event.processingState;
//       final playing = event.playing;
//       if(processingState==ProcessingState.loading||processingState==ProcessingState.buffering){
//         isAudioLoading.value=true;
//       }else if(!playing){
//         //isPause.value=true;
//         isAudioLoading.value=false;
//       }else if(processingState==ProcessingState.completed){
//
//         isAudioLoading.value=false;
//       }else{
//
//         isAudioLoading.value=false;
//       }
//     });
//   }
//
//   ///fav play
//   playFavRadio(String url, String channelName, int index) {
//     name.value = channelName;
//     selectedFavIndex.value = index;
//     player.setUrl(url).then((_) {});
//     if (url.isNotEmpty) {
//       player.play();
//
//       isPause.value = true;
//     }
//
//     player.positionStream.listen((position) {});
//     player.playerStateStream.listen((event) {
//       final processingState = event.processingState;
//       final playing = event.playing;
//       if(processingState==ProcessingState.loading||processingState==ProcessingState.buffering){
//         isAudioLoading.value=true;
//       }else if(!playing){
//         //isPause.value=true;
//         isAudioLoading.value=false;
//       }else if(processingState==ProcessingState.completed){
//
//         isAudioLoading.value=false;
//       }else{
//
//         isAudioLoading.value=false;
//       }
//     });
//   }
//
//   ///search play
//   playSearchRadio(String url, String channelName, int index) {
//     name.value = channelName;
//     selectedSearchIndex.value = index;
//     player.setUrl(url).then((_) {});
//     if (url.isNotEmpty) {
//       player.play();
//
//       isPause.value = true;
//     }
//
//     player.positionStream.listen((position) {});
//     player.playerStateStream.listen((event) {
//       final processingState = event.processingState;
//       final playing = event.playing;
//       if(processingState==ProcessingState.loading||processingState==ProcessingState.buffering){
//         isAudioLoading.value=true;
//       }else if(!playing){
//         //isPause.value=true;
//         isAudioLoading.value=false;
//       }else if(processingState==ProcessingState.completed){
//
//         isAudioLoading.value=false;
//       }else{
//
//         isAudioLoading.value=false;
//       }
//     });
//   }
//
//   ///change index
//   changeIndex(int index) {
//     selectedIndex.value = index;
//   }
//
//   ///change fav index
//   changeFavIndex(int index) {
//     selectedFavIndex.value = index;
//   }
//
//   ///change search index
//   changeSearchIndex(int index) {
//     selectedSearchIndex.value = index;
//   }
//
//   ///change index and play
//   changeIndexPlayRadio(int index) {
//     name.value = stationLists[index].stationName;
//     selectedIndex.value = index;
//     player.setUrl(stationLists[index].url).then((_) {});
//     if (stationLists[index].url.isNotEmpty) {
//       player.play();
//     }
//
//     player.positionStream.listen((position) {});
//   }
//
//   ///change index and play
//   changeIndexPlayFavRadio(int index) {
//     name.value = favLists[index].stationName;
//     selectedFavIndex.value = index;
//     player.setUrl(favLists[index].url).then((_) {});
//     if (favLists[index].url.isNotEmpty) {
//       player.play();
//     }
//
//     player.positionStream.listen((position) {});
//   }
//
//   ///change index and play
//   changeIndexPlaySearchRadio(int index) {
//     name.value = searchLists[index].stationName;
//     selectedSearchIndex.value = index;
//     player.setUrl(searchLists[index].url).then((_) {});
//     if (searchLists[index].url.isNotEmpty) {
//       player.play();
//     }
//
//     player.positionStream.listen((position) {});
//   }
//
//   ///play pause
//   void playPause() {
//     if (player.playing) {
//       player.pause();
//
//       isPause.value = false;
//     } else {
//       player.play();
//       isPause.value = true;
//     }
//     update();
//   }
//
//   void lastChannel() {
//     player.pause();
//     selectedIndex.value = stationLists.length - 1;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       player.play();
//     });
//   }
//
//   void lastFavChannel() {
//     player.pause();
//     selectedFavIndex.value = favLists.length - 1;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       player.play();
//     });
//   }
//
//   void firstChannel() {
//     player.pause();
//     selectedIndex.value = 0;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       player.play();
//     });
//   }
//
//   void firstFavChannel() {
//     player.pause();
//     selectedFavIndex.value = 0;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       player.play();
//     });
//   }
//
//   void lastSearchChannel() {
//     player.pause();
//     selectedSearchIndex.value = searchLists.length - 1;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       player.play();
//     });
//   }
//
//   void firstSearchChannel() {
//     player.pause();
//     selectedSearchIndex.value = 0;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       player.play();
//     });
//   }
//
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       player.stop();
//     }
//   }
//
//   ///add favourite
//   addToFav(StationListsModel item) {
//     favLists.add(item);
//     Get.snackbar("notice".tr, "add_success".tr, colorText: secondaryColor);
//
//     box.remove('fav');
//     box.write('fav', jsonEncode(favLists));
//     print("Add to fav $favLists");
//     print("box read ${box.read('fav')}");
//   }
//
//   ///add favourite
//
//   void removeFav(StationListsModel item) {
//     favLists.removeWhere((fav) => fav.stationName == item.stationName);
//     updateCartList(); // Call updateCartList to refresh UI and storage
//     Get.snackbar("notice".tr, "remove_success".tr, colorText: secondaryColor);
//   }
//
//   void updateCartList() {
//     // Update the UI
//     update();
//     // Update the storage
//     box.write(
//         'fav', jsonEncode(favLists.map((item) => item.toJson()).toList()));
//   }
//
//   ///station list initialize
//   void dataInsert() {
//     isLoading.value = true;
//     Future.delayed(const Duration(seconds: 1), () {
//       stationLists.value = [
//         StationListsModel(
//             "Fox Sports 1280", "https://stream.revma.ihrhls.com/zc1509"),
//         StationListsModel("Sports Radio 94.1 WIP",
//             "https://live.amperwave.net/manifest/audacy-wipfmaac-imc"),
//         StationListsModel(
//             "FOX Sports Radio", "https://stream.revma.ihrhls.com/zc4732"),
//         StationListsModel("95.7 The Game",
//             "https://live.amperwave.net/direct/audacy-kgmzfmaac-imc"),
//         StationListsModel(
//             "SportsTalk 790", "https://stream.revma.ihrhls.com/zc2257"),
//         StationListsModel("670 The Score",
//             "https://live.amperwave.net/direct/audacy-wscramaac-imc"),
//         StationListsModel("Sports Radio 610",
//             "https://live.amperwave.net/direct/audacy-kiltamaac-imc"),
//         StationListsModel(
//             "AM 570 LA Sports", "https://stream.revma.ihrhls.com/zc189"),
//         StationListsModel("Fox Sports 98.9/1340",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/KKGKAMAAC.aac"),
//         // StationListsModel("98.5 The Sports Hub",
//         //     "https://playerservices.streamtheworld.com/api/livestream-redirect/WBZFMAAC.aac"),
//         StationListsModel(
//             "Sports Radio 93.3 KJR", "https://stream.revma.ihrhls.com/zc2577"),
//         StationListsModel(
//             "Sports Talk 1400 KREF", "https://ice9.securenetsystems.net/KREF"),
//         StationListsModel("WEEI Sports Radio Network",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/WEEIFMAAC.aac"),
//         StationListsModel("AM 560 Sports WQAM",
//             "https://live.amperwave.net/direct/audacy-wqamamaac-imc"),
//         StationListsModel("Altitude Sports Radio 92.5",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/KKSEFMAAC.aac"),
//         StationListsModel("Seattle Sports 710 AM",
//             "https://bonneville.cdnstream1.com/2642_48.aac"),
//         StationListsModel("WWLS The Sports Animal",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/WWLSAMAAC.aac"),
//         StationListsModel("Sactown Sports 1140",
//             "https://bonneville.cdnstream1.com/2616_48.aac"),
//         StationListsModel("Arizona Sports 98.7",
//             "https://bonneville.cdnstream1.com/2699_48.aac"),
//         StationListsModel("CBS Sports Radio",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/CBSSPORTSAAC.aac"),
//         StationListsModel("SportsMap Radio",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/SPORTS_MAP_RADIO.mp3"),
//         StationListsModel("SB Nation Radio",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/YAHOOSPORTSRADIO.mp3"),
//         StationListsModel("1300 WTLS & 106.5 FM",
//             "https://radiobash.net:2000/stream/wtls/stream"),
//         StationListsModel("Online radio: SPORT Music",
//             "http://web.bolognauno.it:9944/stream/1/"),
//         StationListsModel("Sactown Sports 1140",
//             "https://bonneville.cdnstream1.com/2616_48.aac"),
//         StationListsModel(
//             "Sports Talk 97.7", "https://ice7.securenetsystems.net/RDSPORTS"),
//         StationListsModel(
//             "Fox Sports 1360", "https://stream.revma.ihrhls.com/zc4688"),
//         StationListsModel(
//             "1430 The Buzz", "https://stream.revma.ihrhls.com/zc1941"),
//         StationListsModel(
//             "San Diego Sports 760", "https://stream.revma.ihrhls.com/zc249"),
//         StationListsModel(
//             "Steelers Nation Radio", "https://stream.revma.ihrhls.com/zc4870"),
//         StationListsModel(
//             "1010 XL/92.5 FM", "https://ice23.securenetsystems.net/WJXL"),
//         StationListsModel(
//             "96.9 The Game", "https://stream.revma.ihrhls.com/zc601"),
//         StationListsModel(
//             "AM 1300 The Zone", "https://stream.revma.ihrhls.com/zc2181"),
//         StationListsModel(
//             "KFAN Plus", "https://stream.revma.ihrhls.com/zc6920"),
//         StationListsModel("92.1 The Ticket",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/KQSMFMAAC.aac"),
//         StationListsModel("ESPN 1420 Honolulu",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/KKEAAM_AAC.aac"),
//         StationListsModel("ESPN 630 DC",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/WSBNAMAAC.aac"),
//         StationListsModel(
//             "ESPN Central Texas", "https://ais-sa1.streamon.fm/7050_24k.aac"),
//         StationListsModel("Fox Sports 640 South Florida",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/WMENAMAAC.aac"),
//         StationListsModel("Wildcats Radio 1290",
//             "https://playerservices.streamtheworld.com/api/livestream-redirect/KCUBAMAAC.aac"),
//       ];
//       isLoading.value = false;
//     });
//   }
// }
