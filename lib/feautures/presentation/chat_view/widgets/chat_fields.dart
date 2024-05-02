import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamtalking/core/extensions/padding_extension.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import '../../../bussines_logic/chat_cubit/chat_cubit.dart';
import '../../../data/models/user_auth_model.dart';
import 'choose_chat_media.dart';

class ChatFields extends StatelessWidget {
  const ChatFields({
    super.key,
    required this.chatCubit,
    required this.otherUser,
  });

  final ChatBloc chatCubit;
  final UserAuthModel otherUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: S.of(context).add_message,
            textController: chatCubit.messageController,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: ChooseChatMedia(
                              chatCubit: chatCubit),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.photo_library),
                ),
                IconButton(
                  onPressed: () {
                    chatCubit.changeIsRecording();
                  },
                  icon: const Icon(Icons.mic),
                ),
              ],
            ),
          ).padding(10.w, 10.h),
        ),
        IconButton(
          onPressed: () {
            chatCubit.sendMessage(otherUser.uid);
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}