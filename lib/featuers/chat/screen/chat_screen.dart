import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/featuers/chat/screen/widgets/message.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/theme/color/colors.dart';
import '../data/model/chat_models.dart';
import '../logic/chat_cubit.dart';
import '../logic/chat_state.dart';
 


class ChatScreen extends StatelessWidget {
   ChatScreen({super.key, required this.name, required this.avatar});

   String name;
   String avatar;
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _messageController = TextEditingController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        
        children: [
          Container(
            width: 1.sw,
            height: 1.sh,
            child: Image.asset("assets/images/back.jpg",fit: BoxFit.fill,),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leadingWidth: 20.w,
              backgroundColor: AppColors.whiteColor.withOpacity(0.5),
              elevation: 0,
              centerTitle: true,
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    CircleAvatar(radius: 18.r,backgroundImage: NetworkImage(avatar)),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name, // Ideally passed from arguments
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.blackColor,
                          ),
                        ),
                        BlocBuilder<ChatCubit, ChatState>(
                          builder: (context, state) {
                            if (state is ChatLoaded && state.isTyping) {
                              return Text(
                                "Typing...",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new), // Changed from arrowRightLong for standard back nav
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: BlocConsumer<ChatCubit, ChatState>(
                      listener: (context, state) {
                         if (state is ChatLoaded) {
                           _scrollToBottom();
                         }
                      },
                      buildWhen: (previous, current) =>
                          current is ChatLoaded && previous != current,
                      builder: (context, state) {
                        final bool isLoading = state is ChatLoading;
                        final List<MessageModel> messages;
          
                        if (isLoading) {
                          messages = List.generate(
                              15,
                              (index) => MessageModel(
                                  text: "Loading message... text content",
                                  senderId: index.isEven
                                      ? context.read<ChatCubit>().userId
                                      : "dummy_partner",
                                  createdAt: DateTime.now()));
                        } else if (state is ChatLoaded) {
                          messages = state.messages;
                        } else if (state is ChatError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
          
                        return Skeletonizer(
                          enabled: isLoading,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final MessageModel msg = messages[index];
                              final bool isMe =
                                  msg.senderId == context.read<ChatCubit>().userId;
          
                              // Format time
                              final String time = msg.createdAt != null
                                  ? "${msg.createdAt!.hour}:${msg.createdAt!.minute.toString().padLeft(2, '0')}"
                                  : "Now";
          
                              return WhatsAppMessage(
                                message: msg.text ?? "",
                                isMe: isMe,
                                isRead:
                                    true, // Backend doesn't support read receipts in the provided code
                                time: time,
                              );
                            },
                          ),
                        );
                      },
          
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              onChanged: (val) {
                                if (val.isNotEmpty) {
                                  context.read<ChatCubit>().sendTyping();
                                } else {
                                  context.read<ChatCubit>().sendStopTyping();
                                }
                              },
                              decoration: InputDecoration(
                               /* prefixIcon: Icon(Icons.emoji_emotions_outlined),
                                suffixIcon: SizedBox(
                                  width: 90.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.attach_file_outlined),
                                      Icon(Icons.camera_alt_outlined),
                                    ],
                                  ),
                                ),*/
                                hintText: "Message",
                                fillColor: AppColors.whiteColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CircleAvatar(
                            radius: 25.r,
                            backgroundColor: AppColors.whiteColor,
                            child: IconButton(
                              onPressed: () {
                                 if (_messageController.text.isNotEmpty) {
                                   context.read<ChatCubit>().sendMessage(_messageController.text);
                                   _messageController.clear();
                                   context.read<ChatCubit>().sendStopTyping();
                                 }
                              },
                              icon: Icon(
                                Icons.send, // Changed to send icon
                                size: 25.r,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
