import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<bool> {
  MenuCubit() : super(true);

  void changeMenu(bool value) {
    emit(value);
  }
}
