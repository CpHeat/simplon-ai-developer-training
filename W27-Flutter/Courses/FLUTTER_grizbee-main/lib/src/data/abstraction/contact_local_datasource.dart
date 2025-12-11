import 'package:grizbee/src/domain/entities/contact.dart';

abstract class ContactLocalDatasource {
  Future<List<Contact>> getContacts();
}
