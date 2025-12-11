import 'package:grizbee/src/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getContacts();
}
