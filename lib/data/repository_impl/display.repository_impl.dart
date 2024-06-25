import '../../core/utils/constant.dart';
import '../../domain/model/display/menu/menu.model.dart';
import '../../domain/repository/display.repository.dart';
import '../data_source/remote/display.api.dart';
import '../dto/common/reponse_wrapper/response_wrapper.dart';
import '../mapper/common.mapper.dart';
import '../mapper/display/display.mapper.dart';

class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;

  DisplayRepositoryImpl(this._displayApi);

  @override
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType(
      {required MallType mallType}) async {
    final response = await _displayApi.getMenusByMallType(mallType.name);

    return response.toModel<List<Menu>>(
      response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
