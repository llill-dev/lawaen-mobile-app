import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/events/data/models/event_type_model.dart';

abstract class EventRepo {
  Future<Either<ErrorModel, List<EventTypeModel>>> getEventTypes();
}
