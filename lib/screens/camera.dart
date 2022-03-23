import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription>? cameraList;
  const CameraScreen({this.cameraList, Key? key}) : super(key: key);
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController? controller;
  XFile? capturedImage;
  bool showCamera = true;
  bool showImage = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameraList![0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Visibility(
              visible: showCamera,
              child: CameraPreview(controller!),
            ),
            // Visibility(
            //   visible: showImage,
            //   child: Image.network(
            //     capturedImage!.path,
            //     height: double.infinity,
            //     width: double.infinity,
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: Container(
        child: InkWell(
          onTap: () async {
            capturedImage = await controller?.takePicture();
            if (capturedImage != null) {
              setState(() {
                showCamera = false;
                showImage = true;
              });
            }
          },
          child: const Icon(
            CupertinoIcons.camera_fill,
            color: Colors.white,
          ),
        ),
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
