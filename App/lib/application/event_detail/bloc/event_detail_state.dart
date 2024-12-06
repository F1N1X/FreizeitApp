part of 'event_detail_bloc.dart';

class EventDetailState {
  final Event event;
  final Option<Either<EventFailure, Unit>> failureOrSuccedOption;
  final bool isSaving;
  final bool isEditing;
  final String newMessage;
  final bool isFinish;
  final bool isAdmin;

  EventDetailState(
      {required this.isAdmin,
      required this.isFinish,
      required this.event,
      required this.failureOrSuccedOption,
      required this.isSaving,
      required this.isEditing,
      required this.newMessage});

  factory EventDetailState.initial() => EventDetailState(
      isFinish: false,
      event: Event.empty(),
      isEditing: false,
      isSaving: false,
      isAdmin: false,
      failureOrSuccedOption: none(),
      newMessage: "");

  EventDetailState copyWith({
    Event? event,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    bool? isAdmin,
    String? newMessage,
    bool? isFinish,
    Option<Either<EventFailure, Unit>>? failureOrSuccesOption,
  }) {
    return EventDetailState(
      isAdmin: isAdmin ?? this.isAdmin,
      isFinish: isFinish ?? this.isFinish,
      event: event ?? this.event,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccedOption: failureOrSuccesOption ?? failureOrSuccedOption,
      newMessage: newMessage ?? this.newMessage,
    );
  }
}
