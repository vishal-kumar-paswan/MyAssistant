

import 'package:assistant/models/contact_details.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class FetchContactDetails {
  List<Contact>? contactList;
  Future<ContactDetails> getContactNumber(String contactName) async {
    if (await FlutterContacts.requestPermission()) {
      contactList = await FlutterContacts.getContacts(
        sorted: true,
        withProperties: true,
      );

      // Linear search algorithm for searching contacts
      for (int i = 0; i < contactList!.length; i++) {
        if (contactList![i]
                .displayName
                .toLowerCase()
                .compareTo(contactName.toLowerCase()) ==
            0) {
          ContactDetails cds = ContactDetails(true,
              contactName: contactName,
              contactNumber: contactList![i].phones[0].normalizedNumber);
          return cds;
          // print('user found!!');
          // print(contactName +
          //     " phone number " +
          //     contactList![i].phones[0].normalizedNumber);
          // String number = contactList![i].phones[0].normalizedNumber;

        }
      }
      // print(contactList);
    }
    return const ContactDetails(false);
  }
}
