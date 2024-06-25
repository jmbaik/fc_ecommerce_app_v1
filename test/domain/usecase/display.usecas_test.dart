import 'package:fc_ecommerce_app_v1/core/utils/error/error_response.dart';
import 'package:fc_ecommerce_app_v1/data/data_source/remote/display.api.dart';
import 'package:fc_ecommerce_app_v1/data/repository_impl/display.repository_impl.dart';
import 'package:fc_ecommerce_app_v1/domain/model/common/result.dart';
import 'package:fc_ecommerce_app_v1/domain/model/display/menu/menu.model.dart';
import 'package:fc_ecommerce_app_v1/domain/repository/display.repository.dart';
import 'package:fc_ecommerce_app_v1/domain/usecase/display/display.usecase.dart';
import 'package:fc_ecommerce_app_v1/domain/usecase/display/menu/get_menus_usecase.dart';
import 'package:fc_ecommerce_app_v1/presentation/pages/main/cubit/mall_typ_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayRepository extends Mock implements DisplayRepository {}

class MockGetMenusUsecase extends Mock implements GetMenusUsecase {}

class MockDisplayApi extends Mock implements DisplayApi {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayUsecase displayUsecase;
  setUpAll(() {
    displayRepository = DisplayRepositoryImpl(MockDisplayApi());
    displayUsecase = DisplayUsecase(displayRepository);
  });

  test('의존성 주입 성공', () => expect(displayUsecase, isNotNull));
  test('메뉴리스트 성공', () async {
    final result = Result.Success([Menu(tabId: -1, title: '패캠추천')]);
    final usecase = MockGetMenusUsecase();

    when(() => usecase.mallType).thenReturn(MallType.market);
    when(() => usecase.call(displayRepository)).thenAnswer((_) async => result);

    final actual = await displayUsecase.execute(usecase: usecase);
    expect(actual, result);
  });

  test('메뉴리스트 실패', () async {
    final result =
        Result<List<Menu>>.Failure(ErrorResponse(status: 'base_error'));
    final usecase = MockGetMenusUsecase();

    when(() => usecase.mallType).thenReturn(MallType.market);
    when(() => usecase.call(displayRepository)).thenAnswer((_) async => result);

    final actual = await displayUsecase.execute(usecase: usecase);
    expect(actual, result);
  });
}
