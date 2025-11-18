part of 'add_item_cubit.dart';

sealed class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object> get props => [];
}

final class AddItemInitial extends AddItemState {}

class AddItemUpdated extends AddItemState {
  final List<ServicesModel> items;

  const AddItemUpdated(this.items);

  @override
  List<Object> get props => [items];
}
