import 'package:fc_ecommerce_app_v1/core/utils/constant.dart';
import 'package:fc_ecommerce_app_v1/data/data_source/mock/display/display_mock_api.dart';
import 'package:fc_ecommerce_app_v1/data/data_source/remote/display.api.dart';
import 'package:fc_ecommerce_app_v1/data/dto/common/reponse_wrapper/response_wrapper.dart';
import 'package:fc_ecommerce_app_v1/data/dto/display/menu/menu.dto.dart';
import 'package:fc_ecommerce_app_v1/data/mapper/common.mapper.dart';
import 'package:fc_ecommerce_app_v1/data/mapper/display/display.mapper.dart';
import 'package:fc_ecommerce_app_v1/data/repository_impl/display.repository_impl.dart';
import 'package:fc_ecommerce_app_v1/domain/model/display/menu/menu.model.dart';
import 'package:fc_ecommerce_app_v1/domain/repository/display.repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayApi displayApi;
  setUpAll(
    () {
      displayApi = MockDisplayApi();
      displayRepository = DisplayRepositoryImpl(displayApi);
    },
  );

  test('의존성 주입 및 객체 생성 완료', () => expect(displayRepository, isNotNull));

  group(
    '메뉴 리스트 불러오기',
    () {
      // api 호출 성공
      test('api 호출완료', () async {
        try {
          await displayRepository.getMenuByMallType(mallType: MallType.market);
        } catch (_) {}
        verify(() => displayApi.getMenusByMallType(any())).called(1);
      });

      test('api 호출 실패', () async {
        final exception = Exception('error');
        when(() => displayApi.getMenusByMallType(any())).thenThrow(exception);
        expect(
          () => displayRepository.getMenuByMallType(mallType: MallType.market),
          throwsA(exception),
        );
      });

      test('api 호출 성공적으로 불러옴', () async {
        final MallType mallType = MallType.market;
        final ResponseWrapper<List<MenuDto>> mockingData =
            await DisplayMockApi().getMenusByMallType(mallType.name);

        when(() => displayApi.getMenusByMallType(any()))
            .thenAnswer((_) async => mockingData);

        final actual =
            await displayRepository.getMenuByMallType(mallType: mallType);
        final expected = mockingData.toModel<List<Menu>>(
          mockingData.data?.map((MenuDto) => MenuDto.toModel()).toList() ?? [],
        );
        expect(actual, expected);
      });
    },
  );
}
