import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../views/services_manager_screen.dart';

part 'add_item_state.dart';

@Singleton()
class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  final List<ServicesModel> _items = [];

  List<ServicesModel> get items => _items;

  void addItem(String name, String price) {
    _items.add(ServicesModel(name: name, price: price));
    emit(AddItemUpdated(_items));
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    emit(AddItemUpdated(_items));
  }
}
