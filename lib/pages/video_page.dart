import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship/controllers/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;
  late VideoController videoController;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: '',
    );
    videoController = Get.put(VideoController());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("paprclip internship demo"),
      ),
      body: Obx(
        () {
          if (videoController.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            if (videoController.isError.value) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Problem is ${videoController.errrorMsg.value}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontSize: 28),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      videoController.loadVideos();
                    },
                    child: const Center(child: Text("retry")),
                  )
                ],
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => videoController.refreshPage(),
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: videoController.videos.length,
                  itemBuilder: (context, index) {
                    _controller = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                          videoController.videos[index]!.link)!,
                      flags: const YoutubePlayerFlags(
                          autoPlay: true,
                          hideControls: true,
                          disableDragSeek: true,
                          controlsVisibleAtStart: false,
                          hideThumbnail: true,
                          loop: true),
                    );
                    return YoutubePlayer(
                      thumbnail: Image.network(
                        videoController.videos[index]!.displayImage,
                        fit: BoxFit.fill,
                      ),
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
