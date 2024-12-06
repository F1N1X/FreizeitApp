import 'package:dartz/dartz.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/entities/id.dart';
import '../../Failures/event_failure.dart';

abstract class EventRepository {
  Stream<Either<EventFailure, List<Event>>> watchAllSubscriped();

  Future<Either<EventFailure, Unit>> create(Event event);

  Future<Either<EventFailure, Unit>> update(Event event);

  Future<Either<EventFailure, Unit>> delete(Event event);

  Stream<Either<EventFailure, Event>> loadEvent(String id);

  Stream<Either<EventFailure, List<Event>>> loadAllEvents();

  Future<Either<EventFailure, Unit>> addEventToUser(UniqueID eventID);

  Future<Either<EventFailure, Unit>> addMessageToEvent(
      String id, String message);

  Future<Either<EventFailure, List<Event>>> loadEventList();
}
