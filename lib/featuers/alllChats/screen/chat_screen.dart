import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/alllChats/data/all_chats_response.dart';
import 'package:iti_moqaf/featuers/alllChats/logic/get_all_chats_cubit.dart';
import 'package:iti_moqaf/featuers/alllChats/screen/widgets/user_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/helpers/cach_helper.dart';
import '../../../core/shared_widgets/network_error.dart';
import '../../../core/theme/color/colors.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("All Chats", style: TextStyle(color: AppColors.whiteColor)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            color: AppColors.whiteColor,
            Icons.arrow_back_ios_new,
          ), // Changed from arrowRightLong for standard back nav
        ),
      ),
      body: BlocBuilder<GetAllChatsCubit, GetAllChatsState>(
        builder: (context, state) {
          if (state is GetAllChatsError) {
            if (state.error == "لا يوجد اتصال بالإنترنت") {
              return Expanded(
                child: Center(child: Column(
                  children: [
                    NetWorkErrorPage(),
                    Text("لا يوجد اتصال بالإنترنت"),
                  ],
                )),
              );}
            return Center(child: Text(state.error));
          }
          List<ChatData> chats = state is GetAllChatsLoaded
              ? state.chatData
              : state is GetAllChatsLoading
              ? fakeData
              : [];
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              Member? reciver;
              chats[index].members.forEach((member) {
                if (member.id != CacheHelper.getString(key: "userId")) {
                  reciver = member;
                }
              });
              return Skeletonizer(
                enabled: state is GetAllChatsLoading,
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      chatScreen,
                      arguments: {
                        "userId": CacheHelper.getString(key: "userId"),
                        "chatPartnerId": reciver!.id,
                        "chatPartnerName":
                            "${reciver!.firstName} ${reciver!.lastName}",
                        "chatPartnerAvatar": reciver!.avatar,
                      },
                    );
                  },
                  child: UserCard(
                    firstName: reciver!.firstName,
                    lastName: reciver!.lastName,
                    avatar: reciver!.avatar,
                    time:
                        "${chats[index].updatedAt.hour}:${chats[index].updatedAt.minute.toString().padLeft(2, '0')}",
                    imageUrl: '',
                    isMe: false,
                    updatedAt: chats[index].updatedAt,
                    id: chats[index].id,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: AppColors.greyColor.withOpacity(.2),
                height: .5,
                width: double.infinity,
                margin: EdgeInsets.only(right: 70),
              );
            },
            itemCount: chats.length,
          );
        },
      ),
    );
  }
}

List<ChatData> fakeData = [
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
  ChatData(
    id: "id",
    members: [
      Member(
        id: "id",
        firstName: "firstName",
        lastName: "lastName",
        avatar: "",
      ),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    version: 1,
  ),
];
