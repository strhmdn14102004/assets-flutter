// ignore_for_file: require_trailing_commas, always_specify_types, always_put_required_named_parameters_first

import "dart:io";

import "package:base/base.dart";
import "package:base/src/record_page.dart";
import "package:camera/camera.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class RecordPreviewPage extends StatefulWidget {
  final XFile xFile;
  final List<CameraDescription>? cameraDescriptions;
  final void Function(XFile xFile) callback;

  const RecordPreviewPage({
    super.key,
    required this.xFile,
    required this.cameraDescriptions,
    required this.callback,
  });

  @override
  State<RecordPreviewPage> createState() => RecordPreviewPageState();
}

class RecordPreviewPageState extends State<RecordPreviewPage> {
  VideoPlayerController? videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: initVideoPlayer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController!),
                    ),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  color: Colors.black,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigators.pushReplacement(
                              RecordPage(
                                cameraDescriptions: widget.cameraDescriptions,
                                callback: widget.callback,
                              ),
                            );
                          },
                        ),
                        Text(
                          "record_again".tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: Dimensions.size30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigators.pop();

                            widget.callback.call(widget.xFile);
                          },
                        ),
                        Text(
                          "use_this_video".tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.file(
      File(widget.xFile.path),
    );

    await videoPlayerController!.initialize();
    await videoPlayerController!.setLooping(true);
    await videoPlayerController!.play();
  }
}
