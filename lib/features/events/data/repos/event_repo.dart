import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/data/models/event_type_model.dart';
import 'package:lawaen/features/events/presentation/params/get_events_params.dart';

abstract class EventRepo {
  Future<Either<ErrorModel, List<EventTypeModel>>> getEventTypes();

  Future<Either<ErrorModel, List<EventModel>>> getEvents({
    required GetEventsParams params,
    required String eventTypeId,
  });
}
