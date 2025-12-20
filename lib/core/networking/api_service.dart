import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/const/api_const.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_request.dart';
import 'package:iti_moqaf/featuers/stations_details/data/model/station_model.dart';
import '../../featuers/near_stations/data/model/near_stations_model.dart';
import '../../featuers/register/data/model/user_register_request.dart';
import '../../featuers/stations/data/model/stations_model.dart';

class ApiService {
  Dio dio;

  ApiService(this.dio);

  Future<ApiResult> registerUser(UserRegisterRequest user) async {
    try {
      var response = await dio.post(register, data: user.toJson());
      return ApiSuccess(response);
    } on DioException catch (e) {
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  Future<ApiResult> loginUser(UserLoginRequest user) async {
    try {
      var response = await dio.post(login, data: user.toJson());
      print(response.data["data"]);
      print(response.statusCode);
      print(user.email);
      print(user.password);
      return ApiSuccess(response.data["data"]);
    } on DioException catch (e) {
      print(e.response);
      return ApiError(handleDioError(e));
    } catch (e) {
      print(e.toString());
      return ApiError(e.toString());
    }
  }


  Future<ApiResult> verifyEmail(String email, String code) async {
    try {
      var response = await dio.post(
        verifyEmailEndpoint,
        data: {"email": email, "verificationCode": code},
      );
      return ApiSuccess(response);
    } on DioException catch (e) {
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  Future<ApiResult<SimpleStationsResponse>> getAllStations({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        station,
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NDRiZDk3MjAyYmFlNDkyMmNjYTNlNiIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc2NjE1MTU0OX0.2znGJ_AMWXzlQzoae4g1cQLFQYG_GExNjResKY-BEoA",
          },
        ),
      );
      print(response.data);

      final SimpleStationsResponse stationsMoedl =
          SimpleStationsResponse.fromJson(response.data);
      print(stationsMoedl.toString());
      return ApiSuccess<SimpleStationsResponse>(stationsMoedl);
    } on DioException catch (e) {
      print(e.response.toString());
      return ApiError<SimpleStationsResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<SimpleStationsResponse>(e.toString());
    }
  }

  Future<ApiResult<StationModel>> getOneStationDetails(id) async {
    try {
      final response = await dio.get(
        "${station}/${id}",
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NDRiZDk3MjAyYmFlNDkyMmNjYTNlNiIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc2NjE1MTU0OX0.2znGJ_AMWXzlQzoae4g1cQLFQYG_GExNjResKY-BEoA",
          },
        ),
      );
      print(response.data);
      StationModel stationModel = StationModel.fromJson(response.data);
      return ApiSuccess<StationModel>(stationModel);
    } on DioException catch (e) {
      return ApiError<StationModel>(handleDioError(e));
    } catch (e) {
      return ApiError<StationModel>(e.toString());
    }
  }

  Future<ApiResult<StationsResponseModel>> getAllNearbyStations(double lat,double long ,double distance) async {
    try {
      final response = await dio.get(
        near,
        data:
          {
            "lat": lat,
            "lng":long,
            "distance": distance
          }


        ,
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NDRiZDk3MjAyYmFlNDkyMmNjYTNlNiIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc2NjE1MTU0OX0.2znGJ_AMWXzlQzoae4g1cQLFQYG_GExNjResKY-BEoA",
          },
        ),
      );
      print(response.data);
      StationsResponseModel stationsResponseModel = StationsResponseModel.fromJson(response.data);
      return ApiSuccess<StationsResponseModel>(stationsResponseModel);
    } on DioException catch (e) {
      print(e.toString());
      return ApiError<StationsResponseModel>(e.response.toString());
    } catch (e) {
      return ApiError(e.toString());
    }
  }
}
