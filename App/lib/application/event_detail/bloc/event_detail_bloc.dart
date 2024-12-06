import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/event_failure.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/repositories/authentification/AuthRepository.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final EventRepository eventRepository;
  final AuthRepository authRepository;
  EventDetailBloc({required this.eventRepository, required this.authRepository})
      : super(EventDetailState.initial()) {
    on<InitializeEventDetailPage>((event, emit) {
      if (event.event != null) {
        final failOrUserId = authRepository.getUserId();
        String userID = "";
        failOrUserId.fold((l) => {}, (id) => userID = id);
        if (event.event?.adminid == userID) {
          emit(state.copyWith(
              event: event.event, isFinish: true, isAdmin: true));
        } else {
          emit(state.copyWith(event: event.event, isFinish: true));
        }
      }
    });

//Wenn saved noch animation
    on<SendMessagePressed>((event, emit) async {
      Either<EventFailure, Unit>? failureOrSuccess;
      emit(state.copyWith(isSaving: true, failureOrSuccesOption: none()));
      if (event.message!.isNotEmpty) {
        final groupeMessages = state.event.eventMessages;
        groupeMessages?.add(event.message);
        final Event editedEvent =
            state.event.copyWith(eventMessages: groupeMessages);

        if (state.isEditing) {
          failureOrSuccess = await eventRepository.update(editedEvent);
        }
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        failureOrSuccesOption: optionOf(failureOrSuccess),
      ));
    });
  }
}
