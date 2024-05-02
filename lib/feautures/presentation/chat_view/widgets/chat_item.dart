import 'package:audio_wave/audio_wave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/core/widgets/custom_shimmer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../bussines_logic/chat_cubit/chat_cubit.dart';
import '../../../data/models/chat_model.dart';

// ignore: must_be_immutable
class ChatItem extends StatelessWidget {
  ChatItem({
    super.key,
    required this.chat,
    required this.index,
    required this.chatList,
  });
  ChatModel chat;
  int index;
  List<ChatModel> chatList;

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatBloc>(context);
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ChatBubble(
          clipper: ChatBubbleClipper6(
            type: chat.senderId == FirebaseAuth.instance.currentUser!.uid
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble,
          ),
          alignment: chat.senderId == FirebaseAuth.instance.currentUser!.uid
              ? Alignment.topRight
              : Alignment.topLeft,
          backGroundColor:
              chat.senderId == FirebaseAuth.instance.currentUser!.uid
                  ? AppColors.blue
                  : AppColors.grey,
          margin: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment:
                chat.senderId == FirebaseAuth.instance.currentUser!.uid
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Text(
                chat.message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color:
                        chat.senderId == FirebaseAuth.instance.currentUser!.uid
                            ? AppColors.white
                            : AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ).padding(5.w, 5.h),
              if (chat.chatImage != null)
                CachedNetworkImage(
                  placeholder: (context, url) {
                    return CustomShimmer(height: 100.h, width: 100.w);
                  },
                  imageUrl: chat.chatImage!,
                ),
              if (chat.chatAudio != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (chatCubit.isOnlinePlay &&
                        index == chatCubit.selectedIndex)
                      AudioWave(
                        height: 32,
                        width: 32,
                        spacing: 2.5,
                        animationLoop: 0,
                        bars: [
                          AudioWaveBar(
                              heightFactor: 0.7, color: Colors.lightBlueAccent),
                          AudioWaveBar(heightFactor: 0.8, color: Colors.blue),
                          AudioWaveBar(heightFactor: 1, color: Colors.black),
                          AudioWaveBar(heightFactor: 0.9),
                        ],
                      ),
                    IconButton(
                      onPressed: () {
                        if (index == chatList.indexOf(chat)) {
                          chatCubit.changePlayOnlineState();
                          chatCubit.playAudioOnline(chat.chatAudio!, index);
                        }
                      },
                      icon: chatCubit.isOnlinePlay &&
                              index == chatCubit.selectedIndex
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
