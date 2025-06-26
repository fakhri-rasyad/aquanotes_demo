import 'package:aquanotes/core/data/local/hive/hive_service.dart';
import 'package:aquanotes/core/model/province.dart';

abstract class TambakLocalDatasource {
  Future<List<ProvinceModel>> getAllProvinces();
}

class TambakDataSourceImplementation implements TambakLocalDatasource {
  final HiveService hive;

  TambakDataSourceImplementation(this.hive);

  @override
  Future<List<ProvinceModel>> getAllProvinces() async {
    return await hive.getAll("provinces");
  }
}
