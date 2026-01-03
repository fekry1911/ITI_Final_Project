import 'dart:io';
import '../../../../core/models/user_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class ProfileRepo {
  final ApiService apiService;

  ProfileRepo(this.apiService);

  Future<ApiResult<User>> getUserDetails(String userId) async {
    return await apiService.getUserDetails(userId);
  }

  Future<ApiResult<User>> updateProfileImage(File file) async {
    return await apiService.updateProfileImage(file);
  }
}
