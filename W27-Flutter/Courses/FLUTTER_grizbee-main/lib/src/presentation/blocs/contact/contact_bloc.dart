import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grizbee/src/domain/abstraction/contact_repository.dart';
import 'package:grizbee/src/domain/entities/contact.dart';
import 'package:grizbee/src/domain/exceptions/contact_exception.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final contactRepository = GetIt.instance.get<ContactRepository>();

  ContactBloc() : super(ContactInitial()) {
    // Gestion de GetContactsEvent
    on<GetContactsEvent>((event, emit) async {
      try {
        emit(ContactsLoading());
        final contacts = await contactRepository.getContacts();
        emit(ContactsLoaded(contacts));
      } catch (error) {
        if (error is ContactException) {
          emit(GetContactsFailure(error.message));
        }
      }
    });
  }
}
