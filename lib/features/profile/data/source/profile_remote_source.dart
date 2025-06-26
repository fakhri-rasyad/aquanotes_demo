import 'package:aquanotes/core/data/remote/end_points.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteSource {
  Future<Either<String, String>> remoteLogout();
}

class ProfileRemoteSourcImpl implements ProfileRemoteSource {
  final Dio dio;
  ProfileRemoteSourcImpl(this.dio);
  @override
  Future<Either<String, String>> remoteLogout() async {
    try {
      final response = await dio.post(EndPoints.logoutEndPoint);

      String message = response.data["message"];

      if (response.statusCode == 200) {
        message = "Logout berhasil";
      }

      return right(message);
    } on DioException catch (e) {
      return left("Error $e");
    }
  }
}
