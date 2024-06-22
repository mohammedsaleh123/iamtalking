import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';
import 'package:iamtalking/feautures/bussines_logic/chat_cubit/chat_cubit.dart';
import 'package:iamtalking/feautures/data/models/user_auth_model.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

import '../../data/models/chat_model.dart';
import 'widgets/chat_fields.dart';
import 'widgets/chat_item.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({super.key, required this.otherUser});
  UserAuthModel otherUser;

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(otherUser.userName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          StreamBuilder<List<ChatModel>>(
            stream: chatCubit.getChat(otherUser.uid),
            builder: (context, chat) {
              if (chat.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (chat.hasError) {
                return const SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: chat.data!.length,
                  itemBuilder: (context, index) {
                    return ChatItem(
                      chat: chat.data![index],
                      index: index,
                      chatList: chat.data!,
                    );
                  },
                ),
              );
            },
          ),
          BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  if (chatCubit.isRecording)
                    SizedBox(
                      //height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (chatCubit.isLocalPlay)
                            AudioWave(
                              height: 32,
                              width: 32,
                              spacing: 2.5,
                              animationLoop: 0,
                              bars: [
                                AudioWaveBar(
                                    heightFactor: 0.7,
                                    color: Colors.lightBlueAccent),
                                AudioWaveBar(
                                    heightFactor: 0.8, color: Colors.blue),
                                AudioWaveBar(
                                    heightFactor: 1, color: Colors.black),
                                AudioWaveBar(heightFactor: 0.9),
                              ],
                            ),
                          if (chatCubit.chatAudioFile != null)
                            IconButton(
                              onPressed: () {
                                if (chatCubit.chatAudioFile != null) {
                                  chatCubit.changePlayLocalState();
                                  chatCubit.playAudioLocal();
                                }
                              },
                              icon: chatCubit.isLocalPlay
                                  ? const Icon(Icons.pause)
                                  : const Icon(Icons.play_arrow),
                            ),
                          //SizedBox(width: 10.w),
                          Expanded(
                            child: SocialMediaRecorder(
                              sendRequestFunction: (file, path) {
                                chatCubit.sendRequestAudioFunction(file, path);
                              },
                            ),
                          ),
                        ],
                      ).padding(10.w, 0),
                    ),
                  if (chatCubit.chatImageFile != null)
                    Image.file(chatCubit.chatImageFile!),
                  ChatFields(chatCubit: chatCubit, otherUser: otherUser),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}


