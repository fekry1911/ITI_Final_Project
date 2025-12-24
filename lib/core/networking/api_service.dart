import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/const/api_const.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/models/comments_response_model.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_request.dart';
import 'package:iti_moqaf/featuers/stations_details/data/model/station_model.dart';

import 'package:iti_moqaf/featuers/community/data/model/like_resonse_model.dart';
import 'package:iti_moqaf/featuers/create_post/data/creatr_post_model.dart';
import 'package:iti_moqaf/featuers/line_details/data/model/microbus_models.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_response.dart';
import 'package:iti_moqaf/featuers/near_stations/data/model/near_stations_model.dart';
import 'package:iti_moqaf/featuers/register/data/model/user_register_request.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';

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

  Future<ApiResult<UserLoginResponse>> loginUser(UserLoginRequest user) async {
    try {
      var response = await dio.post(login, data: user.toJson());
      return ApiSuccess(UserLoginResponse.fromJson(response.data));
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

  Future<ApiResult<StationsResponseModel>> getAllNearbyStations(
    double lat,
    double long,
    double distance,
  ) async {
    try {
      final response = await dio.get(
        near,
        data: {"lat": lat, "lng": long, "distance": distance},
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NDRiZDk3MjAyYmFlNDkyMmNjYTNlNiIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc2NjE1MTU0OX0.2znGJ_AMWXzlQzoae4g1cQLFQYG_GExNjResKY-BEoA",
          },
        ),
      );
      print(response.data);
      StationsResponseModel stationsResponseModel =
          StationsResponseModel.fromJson(response.data);
      return ApiSuccess<StationsResponseModel>(stationsResponseModel);
    } on DioException catch (e) {
      print(e.toString());
      return ApiError<StationsResponseModel>(e.response.toString());
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  Future<ApiResult<User>> getUserDetails(String userId) async {
    var token = CacheHelper.getString(key: "token");
    print(token);
    try {
      final response = await dio.get(
        "$getUserById/$userId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      User user = User.fromJson(response.data["data"]["user"]);

      return ApiSuccess<User>(user);
    } on DioException catch (e) {
      return ApiError<User>(handleDioError(e));
    } catch (e) {
      return ApiError<User>(e.toString());
    }
  }

  Future<ApiResult<MicrobusResponse>> getVehicles(
    String lineId,
    String stationId,
  ) async {
    try {
      var response = await dio.get(
        "$station/$stationId/$lines/$lineId/$vichels",
      );
      MicrobusResponse microbusResponse = MicrobusResponse.fromJson(response.data);
      return ApiSuccess<MicrobusResponse>(microbusResponse);
    } on DioException catch (e) {
      return ApiError<MicrobusResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<MicrobusResponse>(e.toString());
    }
  }

  Future<ApiResult<List<PostModel>>> getAllPosts() async {
    try {
      Response response;

      response = await dio.get(posts);
      print(response.data);

      // Explicitly cast response.data as List
      List<PostModel> postModel = (response.data as List)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();

      print(postModel.toString());
      return ApiSuccess<List<PostModel>>(postModel);
    } on DioException catch (e) {
      return ApiError<List<PostModel>>(handleDioError(e));
    } catch (e) {
      return ApiError<List<PostModel>>(e.toString());
    }
  }

  Future<ApiResult<PostModel>> createPost(
    CreatePostModel createPostModel,
  ) async {
    try {
      var response = await dio.post(
        posts,
        data: await createPostModel.toFormData(),
      );
      
      var responseData = response.data;
      
      // If Dio didn't parse it automatically (e.g. missing Content-Type header)
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      Map<String, dynamic> json;
      if (responseData is Map) {
        final map = Map<String, dynamic>.from(responseData);
        if (map.containsKey('data') && map['data'] is Map) {
          json = Map<String, dynamic>.from(map['data']);
        } else {
          json = map;
        }
        
        // Handle case where 'user' is just an ID (String) instead of an object (Map)
        if (json.containsKey('user') && json['user'] is String) {
          json['user'] = {'_id': json['user']};
        }

        // Inject defaults for fields often missing in 'Create' responses
        json['likesCount'] ??= 0;
        json['commentsCount'] ??= 0;
        json['isLiked'] ??= false;
        json['mediaType'] ??= (json['media'] != null ? 'IMAGE' : 'NONE');
        json['__v'] ??= 0;
        json['createdAt'] ??= DateTime.now().toIso8601String();
        json['updatedAt'] ??= DateTime.now().toIso8601String();
        
        // Final safety check for bool types (sometimes they come as null even with ??=)
        json['isLiked'] = json['isLiked'] ?? false;
      } else {
        throw "Expected Map but got ${responseData.runtimeType}: $responseData";
      }

      print("ApiService: Final JSON for parsing: $json");
      print("ApiService: Parsing PostModel...");
      PostModel postModel = PostModel.fromJson(json);
      print("ApiService: PostModel parsed successfully. ID: ${postModel.id}");
      return ApiSuccess<PostModel>(postModel);
    } on DioException catch (e) {
      return ApiError<PostModel>(handleDioError(e));
    } catch (e) {
      print("Parsing Error in createPost: $e");
      return ApiError<PostModel>("Failed to parse created post: $e");
    }
  }

  Future<ApiResult<LikeResponseModel>> likePost(id) async {
    try {
      var response = await dio.post("$posts/${id}/like");
      LikeResponseModel likeResponseModel = LikeResponseModel.fromJson(
        response.data,
      );
      return ApiSuccess<LikeResponseModel>(likeResponseModel);
    } on DioException catch (e) {
      return ApiError<LikeResponseModel>(handleDioError(e));
    } catch (e) {
      return ApiError<LikeResponseModel>(e.toString());
    }
  }

  Future<ApiResult<List<PostModel>>> getAllPostsOfUser({String id = ""}) async {
    try {
      Response response;
      response = await dio.get("/api/community/users/${id}/posts");
      print(response.data);

      // Explicitly cast response.data as List
      List<PostModel> postModel = (response.data as List)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();

      print(postModel.toString());
      return ApiSuccess<List<PostModel>>(postModel);
    } on DioException catch (e) {
      return ApiError<List<PostModel>>(handleDioError(e));
    } catch (e) {
      return ApiError<List<PostModel>>(e.toString());
    }
  }

  Future<ApiResult<CommentModel>> commentOnPost(id, content) async {
    try {
      Response response;

      response = await dio.post(
        "${posts}/${id}/comments",
        data: {"content": content},
      );

      final responseData = response.data;
      Map<String, dynamic> json;
      if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
        json = responseData['data'] as Map<String, dynamic>;
      } else {
        json = responseData as Map<String, dynamic>;
      }

      return ApiSuccess<CommentModel>(CommentModel.fromJson(json));
    } on DioException catch (e) {
      return ApiError<CommentModel>(handleDioError(e));
    } catch (e) {
      print("Parsing Error in commentOnPost: $e");
      return ApiError<CommentModel>("Failed to parse comment: $e");
    }
  }

  Future<ApiResult<List<CommentModel>>> getAllCommentsOfPost({
    String id = "",
  }) async {
    try {
      Response response;
      response = await dio.get("${posts}/${id}/comments");
      print(response.data);

      List<CommentModel> commentModel = (response.data as List)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList();

      print(CommentModel);
      return ApiSuccess<List<CommentModel>>(commentModel);
    } on DioException catch (e) {
      return ApiError<List<CommentModel>>(handleDioError(e));
    } catch (e) {
      return ApiError<List<CommentModel>>(e.toString());
    }
  }
}
