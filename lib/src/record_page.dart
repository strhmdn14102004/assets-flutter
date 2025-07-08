// ignore_for_file: cascade_invocations, always_put_required_named_parameters_first, always_specify_types, require_trailing_commas, use_build_context_synchronously

import "package:base/base.dart";
import "package:base/src/record_preview_page.dart";
import "package:camera/camera.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:timer_count_down/timer_controller.dart";
import "package:timer_count_down/timer_count_down.dart";

class RecordPage extends StatefulWidget {
  final List<CameraDescription>? cameraDescriptions;
  final void Function(XFile xFile) callback;

  const RecordPage({
    super.key,
    required this.cameraDescriptions,
    required this.callback,
  });

  @override
  State<RecordPage> createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  bool isRecording = false;
  bool rearCameraSelected = true;

  late CameraController cameraController;

  CountdownController countdownController = CountdownController(autoStart: false);

  @override
  void initState() {
    super.initState();

    initCamera(widget.cameraDescriptions![0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body(),
            Countdown(
              seconds: 120,
              controller: countdownController,
              build: (context, time) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.size20,
                      right: Dimensions.size20,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.size10,
                      vertical: Dimensions.size5,
                    ),
                    decoration: BoxDecoration(color: AppColors.surface(), borderRadius: BorderRadius.circular(Dimensions.size30), border: Border.all(color: AppColors.onSurface(), width: 0.2)),
                    child: Text(
                      "${time.toInt()} ${"second_left".tr()}",
                      style: TextStyle(
                        fontSize: Dimensions.text12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              interval: const Duration(seconds: 1),
              onFinished: recordVideo,
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
                  children: [
                    Expanded(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: Icon(
                          rearCameraSelected ? Icons.switch_camera : Icons.switch_camera_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(
                            () => rearCameraSelected = !rearCameraSelected,
                          );

                          initCamera(
                            widget.cameraDescriptions![rearCameraSelected ? 0 : 1],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: recordVideo,
                        iconSize: 50,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isRecording ? Icons.stop : Icons.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }

  Widget body() {
    if (cameraController.value.isInitialized) {
      return CameraPreview(cameraController);
    } else {
      return Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
  }

  void recordVideo() async {
    if (isRecording) {
      countdownController.pause();

      XFile xFile = await cameraController.stopVideoRecording();

      setState(() => isRecording = false);

      Navigators.pushReplacement(
        RecordPreviewPage(
          xFile: xFile,
          cameraDescriptions: widget.cameraDescriptions,
          callback: widget.callback,
        ),
      );
    } else {
      await cameraController.prepareForVideoRecording();
      await cameraController.startVideoRecording();

      setState(() => isRecording = true);

      countdownController.start();
    }
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    cameraController.setFocusMode(FocusMode.auto);
    cameraController.setExposureMode(ExposureMode.auto);

    try {
      await cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }

        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
}
