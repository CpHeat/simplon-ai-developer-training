import 'package:get_it/get_it.dart';
import 'package:grizbee/src/data/abstraction/contact_local_datasource.dart';
import 'package:grizbee/src/data/abstraction/contact_remote_datasource.dart';
import 'package:grizbee/src/domain/abstraction/contact_repository.dart';
import 'package:grizbee/src/domain/entities/contact.dart';

class ContactRepositoryImpl implements ContactRepository {
  final contactLocalDatasource = GetIt.instance.get<ContactLocalDatasource>();
  final contactRemoteDatasource = GetIt.instance.get<ContactRemoteDatasource>();

  @override
  Future<List<Contact>> getContacts() async {
    final contacts = await contactLocalDatasource.getContacts();
    if (contacts.isEmpty) return contactRemoteDatasource.getContacts();
    return contacts;
  }
}
