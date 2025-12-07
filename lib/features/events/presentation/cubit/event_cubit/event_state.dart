part of 'event_cubit.dart';

class EventState extends Equatable {
  final RequestState eventTypesState;
  final List<EventTypeModel> eventTypes;
  final String? eventTypesError;

  const EventState({
    this.eventTypesState = RequestState.idle,
    this.eventTypes = const [],
    this.eventTypesError,
  });

  EventState copyWith({
    RequestState? eventTypesState,
    List<EventTypeModel>? eventTypes,
    String? eventTypesError,
  }) {
    return EventState(
      eventTypesState: eventTypesState ?? this.eventTypesState,
      eventTypes: eventTypes ?? this.eventTypes,
      eventTypesError: eventTypesError,
    );
  }

  @override
  List<Object?> get props => [eventTypesState, eventTypes, eventTypesError];
}
