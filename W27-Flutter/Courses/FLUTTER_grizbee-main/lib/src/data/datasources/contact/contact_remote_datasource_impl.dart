import 'package:grizbee/src/data/abstraction/contact_remote_datasource.dart';
import 'package:grizbee/src/data/datasources/mock_constants.dart';
import 'package:grizbee/src/data/datasources/mock_contacts.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/exceptions/contact_exception.dart';

class ContactRemoteDatasourceImpl implements ContactRemoteDatasource {
  @override
  Future<List<Contact>> getContacts() {
    // Simulation : fetching data from API
    return Future.delayed(Duration(seconds: FetchDataDelay.remote), () async {
      try {
        mockContacts = remoteContacts;
        return remoteContacts;
      } catch (error) {
        throw (ContactException());
      }
    });
  }
}
