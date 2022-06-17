import 'package:assistant/screens/alarm_section/alarms.dart';
import 'package:assistant/screens/notes_section/edit_note_page.dart';
import 'package:assistant/screens/query_page/query_result.dart';
import 'package:assistant/screens/reminders_section/reminders.dart';
import 'package:assistant/screens/share_files_section/share_files.dart';
import 'package:assistant/utils/call_section.dart';
import 'package:assistant/utils/fetch_app_list.dart';
import 'package:assistant/utils/local_authentication.dart';
import 'package:assistant/utils/play_music.dart';
import 'package:assistant/utils/send_sms.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:device_apps/device_apps.dart';
import 'package:get/get.dart';
import '../screens/notes_section/notes_page.dart';
import 'global_context.dart';

class AssistantOperations {
  static void selectTask(String operation) async {
    // For greetings
    if (operation.toLowerCase().compareTo('good morning') == 0) {
      TextToSpeechModel.speakText('Good morning');
    } else if (operation.toLowerCase().compareTo('good afternoon') == 0) {
      TextToSpeechModel.speakText('Good afternoon');
    } else if (operation.toLowerCase().compareTo('good evening') == 0) {
      TextToSpeechModel.speakText('Good evening');
    } else if (operation.toLowerCase().compareTo('good night') == 0) {
      TextToSpeechModel.speakText('Good night');
    }

    // Weather details
    if (operation.toLowerCase().compareTo('how is the weather') == 0) {
    } else if (operation.toLowerCase().compareTo('how\'s the weather') == 0) {}

    // For calling
    if (operation.toLowerCase().startsWith('call')) {
      String contactName = operation.substring(operation.indexOf(' ') + 1);
      CallSection.makeACall(contactName);
    }

    // For sending SMS - 1
    else if (operation.toLowerCase().startsWith('send a message to')) {
      SendSMS.sendMessage(
          (NavigationService.navigatorKey.currentContext)!, operation);
    } else if (operation.toLowerCase().startsWith('send message to')) {
      SendSMS.sendMessage(
          (NavigationService.navigatorKey.currentContext)!, operation);
    } else if (operation.toLowerCase().startsWith('send a text to')) {
      SendSMS.sendMessage(
          (NavigationService.navigatorKey.currentContext)!, operation);
    } else if (operation.toLowerCase().startsWith('send text to')) {
      SendSMS.sendMessage(
          (NavigationService.navigatorKey.currentContext)!, operation);
    }

    // Query section
    else if (operation.toLowerCase().startsWith('what is')) {
      Get.to(() => QuerySection(), arguments: [
        {
          "query": operation.substring(operation.lastIndexOf(' ') + 1),
        },
      ]);
    }

    // For sharing files
    else if (operation.toLowerCase().startsWith('share files')) {
      Get.to(() => const ShareFileSection());
    } else if (operation.toLowerCase().startsWith('transfer files')) {
      Get.to(() => const ShareFileSection());
    }

    // Play music
    else if (operation.toLowerCase().compareTo('play music') == 0) {
      MusicSection.playMusic();
    } else if (operation.toLowerCase().compareTo('play some music') == 0) {
      MusicSection.playMusic();
    }

    // Open notes
    else if (operation.toLowerCase().compareTo('open notes') == 0) {
      final isAuthenticated = await LocalAuthenticationAPI.authenticate();
      if (isAuthenticated) {
        Get.to(() => const NotesSection());
      }
    } else if (operation.toLowerCase().compareTo('open note') == 0) {
      final isAuthenticated = await LocalAuthenticationAPI.authenticate();
      if (isAuthenticated) {
        Get.to(() => const NotesSection());
      }
    } else if (operation.toLowerCase().compareTo('view notes') == 0) {
      final isAuthenticated = await LocalAuthenticationAPI.authenticate();
      if (isAuthenticated) {
        Get.to(() => const NotesSection());
      }
    } else if (operation.toLowerCase().compareTo('view note') == 0) {
      final isAuthenticated = await LocalAuthenticationAPI.authenticate();
      if (isAuthenticated) {
        Get.to(() => const NotesSection());
      }
    } else if (operation.toLowerCase().compareTo('browse notes') == 0) {
      final isAuthenticated = await LocalAuthenticationAPI.authenticate();
      if (isAuthenticated) {
        Get.to(() => const NotesSection());
      }
    } else if (operation.toLowerCase().compareTo('browse note') == 0) {
      final isAuthenticated = await LocalAuthenticationAPI.authenticate();
      if (isAuthenticated) {
        Get.to(() => const NotesSection());
      }
    }
    // Add notes
    else if (operation.toLowerCase().compareTo('add notes') == 0) {
      Get.to(() => const AddEditNotePage());
    } else if (operation.toLowerCase().compareTo('add note') == 0) {
      Get.to(() => const AddEditNotePage());
    } else if (operation.toLowerCase().compareTo('add a note') == 0) {
      Get.to(() => const AddEditNotePage());
    }

    // Set reminder
    else if (operation.toLowerCase().compareTo('set a reminder') == 0) {
      Get.to(() => const ReminderSection());
    } else if (operation.toLowerCase().compareTo('add a reminder') == 0) {
      Get.to(() => const ReminderSection());
    } else if (operation.toLowerCase().compareTo('set reminder') == 0) {
      Get.to(() => const ReminderSection());
    } else if (operation.toLowerCase().compareTo('add reminder') == 0) {
      Get.to(() => const ReminderSection());
    }

    // Set alarm
    else if (operation.toLowerCase().compareTo('set a alarm') == 0) {
      Get.to(() => const AlarmClockSection());
    } else if (operation.toLowerCase().compareTo('set an alarm') == 0) {
      Get.to(() => const AlarmClockSection());
    } else if (operation.toLowerCase().compareTo('set alarm') == 0) {
      Get.to(() => const AlarmClockSection());
    } else if (operation.toLowerCase().compareTo('add a alarm') == 0) {
      Get.to(() => const AlarmClockSection());
    } else if (operation.toLowerCase().compareTo('add an alarm') == 0) {
      Get.to(() => const AlarmClockSection());
    } else if (operation.toLowerCase().compareTo('add alarm') == 0) {
      Get.to(() => const AlarmClockSection());
    }

    // To open device apps
    else if (operation.toLowerCase().startsWith('open')) {
      String task = operation.substring(operation.indexOf(' ') + 1);

      switch (task) {
        case 'my share':
          Get.to(() => const ShareFileSection());
          break;
        default:
          String? packageName =
              await FetchInstalledAppList.getPackageName(task);
          await DeviceApps.openApp(packageName.toString());
          TextToSpeechModel.speakText('Opening $task');
      }
    }
  }
}
