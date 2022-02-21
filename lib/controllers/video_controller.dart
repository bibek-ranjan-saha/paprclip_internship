import 'dart:convert';

import 'package:get/get.dart';
import 'package:internship/models/video_model.dart';
import 'package:internship/services/remote_services.dart';

class VideoController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  RxString errrorMsg = "".obs;
  var videos = <Video?>[].obs;

  @override
  void onInit() {
    loadVideos();
    super.onInit();
  }

  Future<void> refreshPage() async {
    videos.clear();
    loadVideos();
  }

  void loadVideos() async {
    var jsonData = await RemoteService.fetchVideos();
    if (jsonData != "network error" && jsonData != null) {
      for (var json in jsonData) {
        if (json != null) {
          videos.add(videoFromJson(jsonEncode(json)));
        } else {
          isError.value = true;
          isLoading.value = false;
        }
      }
    } else {
      errrorMsg.value = "no internet connection";
      isError.value = true;
      isLoading(false);
    }
    isLoading(false);
  }
}
