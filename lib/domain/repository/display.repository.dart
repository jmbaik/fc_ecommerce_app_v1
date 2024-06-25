import '../../data/dto/common/reponse_wrapper/response_wrapper.dart';
import '../../presentation/pages/main/cubit/mall_typ_cubit.dart';
import '../model/display/menu/menu.model.dart';
import 'repository.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType({
    required MallType mallType,
  });
}
