import 'package:assistant/models/contact_details.dart';
import 'package:assistant/screens/camera.dart';
import 'package:assistant/utils/fetch_contact_details.dart';
import 'package:camera/camera.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AssistantOperations {
  void selectTask(String operation) async {
    if (operation.toLowerCase().startsWith('call')) {
      String contactName = operation.substring(operation.indexOf(' ') + 1);
      ContactDetails _contactDetails =
          await FetchContactDetails().getContactNumber(contactName);

      if (_contactDetails.isContactFound) {
        await FlutterPhoneDirectCaller.callNumber(
            (_contactDetails.contactNumber).toString());
      }
    } else {
      switch (operation) {
        case 'open camera':
          openCamera();
          break;
        default:
      }
      
    }
  }

  void openCamera() async {
    var status = await Permission.camera.request().isGranted;
    if (status) {
      await availableCameras().then(
        (value) => Get.to(
          CameraScreen(
            cameraList: value,
          ),
        ),
      );
    }
  }
}
