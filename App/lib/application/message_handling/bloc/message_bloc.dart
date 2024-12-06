import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Failures/event_failure.dart';
import 'package:freizeit_app/repositories/event/eventrepository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../Model/event.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final EventRepository eventRepository;

  StreamSubscription<Either<EventFailure, Event>>? _eventStream;

  MessageBloc({required this.eventRepository}) : super(MessageInitial()) {
    on<LoadEventForMessage>((event, emit) async {
      await _eventStream?.cancel();
      _eventStream = eventRepository.loadEvent(event.id).listen((event) {
        add(FinishLoadingEvent(failedOrLoadedEvents: event));
      });
    });

    on<FinishLoadingEvent>((event, emit) async {
      event.failedOrLoadedEvents.fold(
          (failed) => emit(EventForMessageLoadingFailed(failed)),
          (succes) => emit(EventForMessageLodingSucceded(event: succes)));
    });

    on<UpdateEventWithMessage>((event, emit) async {
      await eventRepository.addMessageToEvent(event.id, event.message);
    });
  }

  @override
  Future<void> close() async {
    await _eventStream?.cancel();
    return super.close();
  }
}
