import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/error/error_response.dart';
import '../../../../../core/utils/exception/common_exception.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../domain/model/common/result.dart';
import '../../../../../domain/model/display/menu/menu.model.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';
import '../../../../../domain/usecase/display/menu/get_menus_usecase.dart';

part 'menu_bloc.freezed.dart';
part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final DisplayUsecase _displayUsecase;

  MenuBloc(this._displayUsecase) : super(MenuState()) {
    on<MenuInitialized>(_onMenusInitialized);
  }

  // gnb 초기화
  Future<void> _onMenusInitialized(
    MenuInitialized event,
    Emitter<MenuState> emit,
  ) async {
    final mallType = event.mallType;
    emit(state.copyWith(status: Status.loading));
    try {
      final Result<List<Menu>> response = await _fetch(mallType: mallType);
      response.when(Success: (menus) {
        emit(state.copyWith(
          status: Status.success,
          mallType: mallType,
          menus: menus,
        ));
      }, Failure: (error) {
        emit(state.copyWith(status: Status.error, error: error));
      });
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
        status: Status.error,
        error: CommonException.setError(error),
      ));
    }
  }

  Future<Result<List<Menu>>> _fetch({required MallType mallType}) async {
    return await _displayUsecase.execute(
      usecase: GetMenusUsecase(mallType: mallType),
    );
  }
}
