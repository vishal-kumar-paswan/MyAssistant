import 'package:permission_handler/permission_handler.dart';

class PermissionRequests {
  static void permissionRequests() async {
    await [
      Permission.camera,
      Permission.contacts,
      Permission.microphone,
    ].request();
  }
}
