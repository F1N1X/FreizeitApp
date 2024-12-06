// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_form_bloc.dart';

class CreationFormState {
  final Event event;
  DateTime? date;
  String? categorie;
  String? description;
  String? eventName;
  int? member;

  final Option<Either<EventFailure, Unit>> failOrSuccesOption;
  CreationFormState({
    required this.event,
    required this.failOrSuccesOption,
  });

  factory CreationFormState.initial() =>
      CreationFormState(event: Event.empty(), failOrSuccesOption: none());

  CreationFormState copyWith({
    Event? event,
    Option<Either<EventFailure, Unit>>? failOrSuccesOption,
  }) {
    return CreationFormState(
      event: event ?? this.event,
      failOrSuccesOption: failOrSuccesOption ?? this.failOrSuccesOption,
    );
  }
}
