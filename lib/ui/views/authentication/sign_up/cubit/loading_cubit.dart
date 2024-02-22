import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_cubit.freezed.dart';
part 'loading_state.dart';

class AuthLoadingCubit extends Cubit<LoadingState> {
  AuthLoadingCubit() : super(const LoadingState.initial());

  void loading({String? message}) {
    emit(LoadingState.loading(message: message));
  }

  void loaded() {
    emit(const LoadingState.initial());
  }
}
