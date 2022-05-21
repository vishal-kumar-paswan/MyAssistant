import 'package:assistant/utils/text_to_speech.dart';
import 'package:device_apps/device_apps.dart';

class OpenApplicationSection {
  static void openApplication(String appName) async {
    late List<Application> installedApps;
    late String _packageName = "";
    installedApps =
        await DeviceApps.getInstalledApplications(includeSystemApps: true);
    for (int i = 0; i < installedApps.length; i++) {
      if (appName
              .toLowerCase()
              .compareTo(installedApps[i].appName.toLowerCase()) ==
          0) {
        _packageName = installedApps[i].packageName;
        break;
      }
    }

    _packageName != ""
        ? await DeviceApps.openApp(_packageName.toString())
        : TextToSpeechModel.speakText("app is not installed on your phone");
  }
}
