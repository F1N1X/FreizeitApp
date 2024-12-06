// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/event_failure.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
import 'package:meta/meta.dart';

part 'event_form_event.dart';
part 'event_form_state.dart';

class EventFormBloc extends Bloc<EventFormEvent, CreationFormState> {
  final EventRepository eventRepository;

  EventFormBloc({required this.eventRepository})
      : super(CreationFormState.initial()) {
    on<InitialzeCreationForm>((event, emit) {
      if (event.event != null) {
        emit(state.copyWith(event: event.event));
      }
    });

    on<CreatePressedEvent>((event, emit) async {
      Either<EventFailure, Unit>? failOrSuccess;

      emit(state.copyWith(failOrSuccesOption: none()));

      //Validation
      final Event eventData = state.event.copyWith(
          startDate: event.startDate,
          eventCreationDate: event.eventCreationDate,
          eventType: event.eventType,
          name: event.name,
          maxMember: event.maxMember,
          eventDescription: event.eventDescription,
          eventGeoPoint: event.eventGeoPoint);

      failOrSuccess = await eventRepository.create(eventData);

      emit(state.copyWith(failOrSuccesOption: optionOf(failOrSuccess)));
    });

    on<UpdatePressed>((event, emit) async {
      Either<EventFailure, Unit>? failOrSuccess;

      emit(state.copyWith(failOrSuccesOption: none()));

      //Validation
      final Event eventData = state.event.copyWith(
          startDate: event.startDate,
          eventCreationDate: event.eventCreationDate,
          eventType: event.eventType,
          name: event.name,
          maxMember: event.maxMember,
          eventDescription: event.eventDescription,
          eventGeoPoint: event.eventGeoPoint);

      failOrSuccess = await eventRepository.update(eventData);
      failOrSuccess.fold(
          (l) => {}, (r) => emit(state.copyWith(event: eventData)));

      emit(state.copyWith(failOrSuccesOption: optionOf(failOrSuccess)));
    });
  }
}
