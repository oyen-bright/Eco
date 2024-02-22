import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_cubit.freezed.dart';
part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingState.initial());

  void loading({
    String? message,
    (String, void Function(), int?)? action1,
    (String, void Function(), int?)? action2,
  }) {
    emit(LoadingState.loading(
        message: message, action1: action1, action2: action2));
  }

  void loaded() {
    emit(const LoadingState.initial());
  }
}
