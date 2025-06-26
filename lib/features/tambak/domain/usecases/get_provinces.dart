import 'package:aquanotes/core/utils/usecase.dart';
import 'package:aquanotes/features/tambak/domain/entities/province.dart';
import 'package:aquanotes/features/tambak/domain/repositories/tambak_repository.dart';

class GetProvinces extends Usecase<Future<List<Province>>, NoParams> {
  final TambakRepository repository;

  GetProvinces(this.repository);

  @override
  Future<List<Province>> call(NoParams param) async {
    return repository.getProvince();
  }
}
