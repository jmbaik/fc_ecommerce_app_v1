import '../../core/utils/constant.dart';
import '../../data/dto/common/reponse_wrapper/response_wrapper.dart';
import '../model/display/menu/menu.model.dart';
import 'repository.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType({
    required MallType mallType,
  });
}
