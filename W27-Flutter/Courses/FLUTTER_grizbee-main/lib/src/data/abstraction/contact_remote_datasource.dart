import 'package:grizbee/src/domain/entities/contact.dart';

abstract class ContactRemoteDatasource {
  Future<List<Contact>> getContacts();
}
