part of 'event_cubit.dart';

class EventState extends Equatable {
  final RequestState eventTypesState;
  final List<EventTypeModel> eventTypes;
  final String? eventTypesError;
  final RequestState eventsState;
  final List<EventModel> events;
  final String? eventsError;

  const EventState({
    this.eventTypesState = RequestState.idle,
    this.eventTypes = const [],
    this.eventTypesError,
    this.eventsState = RequestState.idle,
    this.events = const [],
    this.eventsError,
  });

  EventState copyWith({
    RequestState? eventTypesState,
    List<EventTypeModel>? eventTypes,
    String? eventTypesError,
    RequestState? eventsState,
    List<EventModel>? events,
    String? eventsError,
  }) {
    return EventState(
      eventTypesState: eventTypesState ?? this.eventTypesState,
      eventTypes: eventTypes ?? this.eventTypes,
      eventTypesError: eventTypesError,
      eventsState: eventsState ?? this.eventsState,
      events: events ?? this.events,
      eventsError: eventsError,
    );
  }

  @override
  List<Object?> get props => [eventTypesState, eventTypes, eventTypesError, eventsState, events, eventsError];
}
