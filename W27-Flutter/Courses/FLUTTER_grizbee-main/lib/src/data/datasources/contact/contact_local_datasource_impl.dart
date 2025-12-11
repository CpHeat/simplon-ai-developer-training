import 'package:grizbee/src/data/abstraction/contact_local_datasource.dart';
import 'package:grizbee/src/data/datasources/mock_constants.dart';
import 'package:grizbee/src/data/datasources/mock_contacts.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/exceptions/contact_exception.dart';

class ContactLocalDatasourceImpl implements ContactLocalDatasource {
  @override
  Future<List<Contact>> getContacts() {
    // Simulation : fetching data from local mock
    return Future.delayed(Duration(seconds: FetchDataDelay.local), () async {
      try {
        return mockContacts;
      } catch (error) {
        throw (ContactException());
      }
    });
  }
}
