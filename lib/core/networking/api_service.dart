import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:iti_moqaf/core/const/api_const.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/models/comments_response_model.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/chat/data/model/chat_models.dart';
import 'package:iti_moqaf/featuers/community/data/model/like_resonse_model.dart';
import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'package:iti_moqaf/featuers/create_post/data/creatr_post_model.dart';
import 'package:iti_moqaf/featuers/line_details/data/model/microbus_models.dart';
import 'package:iti_moqaf/featuers/line_details/data/model/stripe_checkout_response.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_request.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_response.dart';
import 'package:iti_moqaf/featuers/near_stations/data/model/near_stations_model.dart';
import 'package:iti_moqaf/featuers/register/data/model/user_register_request.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';
import 'package:iti_moqaf/featuers/stations_details/data/model/station_model.dart';

import '../../featuers/alllChats/data/all_chats_response.dart';
import '../../featuers/line_details/data/model/book_response_model.dart';

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

  Future<ApiResult<User>> updateProfileImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      var response = await dio.patch(updateProfile, data: formData);
      
      User user = User.fromJson(response.data['data']['user']);

      return ApiSuccess<User>(user);
    } on DioException catch (e) {
      return ApiError(handleDioError(e));
    } catch (e) {
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
    int? limit,
  }) async {
    try {
      final response = await dio.get(
        station,
        queryParameters: {'page': page, if (limit != null) 'limit': limit},
      );
      print(response.data);

      final SimpleStationsResponse stationsMoedl =
          SimpleStationsResponse.fromJson(response.data);
      print(stationsMoedl.toString());
      return ApiSuccess<SimpleStationsResponse>(stationsMoedl);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<SimpleStationsResponse>(e.toString());
    }
  }

  Future<ApiResult<StationModel>> getOneStationDetails(id) async {
    try {
      final response = await dio.get("${station}/${id}");
      StationModel stationModel = StationModel.fromJson(response.data);
      return ApiSuccess<StationModel>(stationModel);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
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
        queryParameters: {"lat": lat, "lng": long, "distance": distance},
      );
      print(response.data);
      StationsResponseModel stationsResponseModel =
          StationsResponseModel.fromJson(response.data);
      return ApiSuccess<StationsResponseModel>(stationsResponseModel);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  Future<ApiResult<User>> getUserDetails(String userId) async {
    var token = CacheHelper.getString(key: "token");
    print(token);
    try {
      final response = await dio.get("$getUserById/$userId");

      User user = User.fromJson(response.data["data"]["user"]);

      return ApiSuccess<User>(user);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<User>(e.toString());
    }
  }

  Future<ApiResult<MicrobusResponse>> getVehicles(
    String lineId,
    String stationId,
  ) async {
    try {
      print(lineId);
      print(stationId);
      var response = await dio.get(
        "$station/$stationId/$lines/$lineId/$vichels",
      );
      MicrobusResponse microbusResponse = MicrobusResponse.fromJson(
        response.data,
      );
      return ApiSuccess<MicrobusResponse>(microbusResponse);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<MicrobusResponse>(e.toString());
    }
  }

  Future<ApiResult<PostsResponse>> getAllPosts({required int page}) async {
    try {
      Response response;

      response = await dio.get(posts, queryParameters: {"page": page});
      print(response.data);

      // Explicitly cast response.data as List
      PostsResponse postsResponse = PostsResponse.fromJson(response.data);
      return ApiSuccess<PostsResponse>(postsResponse);
    } on DioException catch (e) {
      return ApiError<PostsResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<PostsResponse>(e.toString());
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

      // If Dio didn't parse it automatically
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      Map<String, dynamic> json;
      if (responseData is Map) {
        final map = Map<String, dynamic>.from(responseData);
        json = map.containsKey('data') && map['data'] is Map
            ? Map<String, dynamic>.from(map['data'])
            : map;
      } else {
        throw "Expected Map but got ${responseData.runtimeType}: $responseData";
      }

      print("ApiService: Parsing PostModel with ID: ${json['_id']}");
      PostModel postModel = PostModel.fromJson(json);
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

  Future<ApiResult<PostsResponse>> getAllPostsOfUser({
    String id = "",
    required int page,
  }) async {
    try {
      Response response;
      response = await dio.get(
        "/api/community/users/${id}/posts",
        queryParameters: {"page": page},
      );
      print(response.data);

      // Explicitly cast response.data as List
      PostsResponse postModel = PostsResponse.fromJson(response.data);

      return ApiSuccess<PostsResponse>(postModel);
    } on DioException catch (e) {
      return ApiError<PostsResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<PostsResponse>(e.toString());
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
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data')) {
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
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<List<CommentModel>>(e.toString());
    }
  }

  Future<ApiResult<List<ConversationModel>>> getConversations(
    String userId,
  ) async {
    try {
      final response = await dio.get("$conversations/$userId");
      final List<ConversationModel> conversationList =
          (response.data['data'] as List)
              .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return ApiSuccess<List<ConversationModel>>(conversationList);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<List<ConversationModel>>(e.toString());
    }
  }

  Future<ApiResult<List<MessageModel>>> getMessages(
    String conversationId,
  ) async {
    try {
      final response = await dio.get("$messages/$conversationId");
      final List<MessageModel> messageList = (response.data['data'] as List)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiSuccess<List<MessageModel>>(messageList);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<List<MessageModel>>(e.toString());
    }
  }

  Future<ApiResult<ConversationModel>> createConversation(
    String senderId,
    String receiverId,
  ) async {
    try {
      final response = await dio.post(
        conversations,
        data: {"senderId": senderId, "receiverId": receiverId},
      );
      return ApiSuccess<ConversationModel>(
        ConversationModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return ApiError<ConversationModel>(handleDioError(e));
    } catch (e) {
      return ApiError<ConversationModel>(e.toString());
    }
  }

  Future<ApiResult<MessageModel>> sendMessage(
    String conversationId,
    String senderId,
    String text,
  ) async {
    try {
      final response = await dio.post(
        messages,
        data: {
          "conversationId": conversationId,
          "senderId": senderId,
          "text": text,
        },
      );
      return ApiSuccess<MessageModel>(
        MessageModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return ApiError<MessageModel>(handleDioError(e));
    } catch (e) {
      return ApiError<MessageModel>(e.toString());
    }
  }

  Future<ApiResult<ChatResponse>> getAllChats(String id) async {
    try {
      var response = await dio.get("$conversations/$id");
      ChatResponse chatResponse = ChatResponse.fromJson(response.data);
      return ApiSuccess<ChatResponse>(chatResponse);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return ApiError("لا يوجد اتصال بالإنترنت");
      }
      return ApiError(handleDioError(e));
    } catch (e) {
      return ApiError<ChatResponse>(e.toString());
    }
  }

  Future<ApiResult<SeatBookingResponse>> bookSeatInVehicle({
    required String vehicleId,
    required String lineId,
    required String stationId,
  }) async {
    try {
      var response = await dio.post(
        "$station/${stationId}/${lines}/${lineId}/${vichels}/${vehicleId}/book",
      );
      SeatBookingResponse seatBookingResponse = SeatBookingResponse.fromJson(
        response.data,
      );
      return ApiSuccess<SeatBookingResponse>(seatBookingResponse);
    } on DioException catch (e) {
      return ApiError<SeatBookingResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<SeatBookingResponse>(e.toString());
    }
  }

  Future<ApiResult<SeatBookingResponse>> cancelBookSeatInVehicle({
    required String vehicleId,
    required String lineId,
    required String stationId,
  }) async {
    try {
      var response = await dio.delete(
        "$station/${stationId}/${lines}/${lineId}/${vichels}/${vehicleId}/book",
      );
      SeatBookingResponse seatBookingResponse = SeatBookingResponse.fromJson(
        response.data,
      );
      return ApiSuccess<SeatBookingResponse>(seatBookingResponse);
    } on DioException catch (e) {
      return ApiError<SeatBookingResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<SeatBookingResponse>(e.toString());
    }
  }

  Future<ApiResult<String>> confirmBook({required String sessionId}) async {
    try {
      var response = await dio.post(
        "${checkOut}/confirm-payment",
        data: {"sessionId": sessionId},
      );
      var data = response.data;
      String message = "";
      if (data is Map<String, dynamic>) {
        message = data['message']?.toString() ?? data.toString();
      } else {
        message = data.toString();
      }
      return ApiSuccess<String>(message);
    } on DioException catch (e) {
      return ApiError<String>(handleDioError(e));
    } catch (e) {
      return ApiError<String>(e.toString());
    }
  }

  Future<ApiResult<StripeCheckoutResponse>> handleCheckoutPayment({
    required String bookingId,
  }) async {
    try {
      var response = await dio.post(
        "${checkOut}/checkout-session",
        data: {"bookingId": bookingId},
      );
      StripeCheckoutResponse stripeCheckoutResponse =
          StripeCheckoutResponse.fromJson(response.data);
      return ApiSuccess<StripeCheckoutResponse>(stripeCheckoutResponse);
    } on DioException catch (e) {
      return ApiError<StripeCheckoutResponse>(handleDioError(e));
    } catch (e) {
      return ApiError<StripeCheckoutResponse>(e.toString());
    }
  }

  Future<ApiResult<String>> sendVerificationCode({
    required String email,
  }) async {
    try {
      var response = await dio.post(
        sendVerificationPassword,
        data: {"email ": email},
      );
      return ApiSuccess<String>(response.data["data"]["message"]);
    } on DioException catch (e) {
      return ApiError<String>(handleDioError(e));
    } catch (e) {
      return ApiError<String>(e.toString());
    }
  }

  Future<ApiResult<String>> verifyVerificationCode({
    required String code,
  }) async {
    try {
      var response = await dio.post(
        verifyPassword,
        data: {"verificationCode ": code},
      );
      return ApiSuccess<String>(response.data["data"]["resetToken"]);
    } on DioException catch (e) {
      return ApiError<String>(handleDioError(e));
    } catch (e) {
      return ApiError<String>(e.toString());
    }
  }

  Future<ApiResult<String>> resetNewPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    try {
      var response = await dio.post(
        "$resetPassword/$token",
        data: {"newPassword ": newPassword, "confirmPassword": confirmPassword},
      );
      return ApiSuccess<String>(response.data["data"]["message"]);
    } on DioException catch (e) {
      return ApiError<String>(handleDioError(e));
    } catch (e) {
      return ApiError<String>(e.toString());
    }
  }
}
