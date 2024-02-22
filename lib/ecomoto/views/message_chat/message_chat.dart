library message_chat;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/messaging_cubit/messages_model.dart';
import 'package:emr_005/ecomoto/cubit/messaging_cubit/messaging_cubit.dart';
import 'package:emr_005/ecomoto/cubit/messaging_cubit/messaging_state.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/ui/components/headers_footers/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

part 'components/image_render.dart';
part 'components/message_bubble.dart';
part 'components/message_input.dart';
part 'constants/strings.dart';

class MessageChatView extends StatelessWidget {
  final String senderID;
  final Map<String, dynamic> lessor;
  final String tripID;

  const MessageChatView(
      {required this.senderID,
      required this.lessor,
      required this.tripID,
      super.key});

  @override
  Widget build(BuildContext context) {
    String receiverID = lessor["id"];
    context
        .read<MessagesCubit>()
        .loadMessages(context.read<UserCubit>().state.userID, tripID);

    return Scaffold(
      appBar: AppViewBar.small(
        title: lessor["username"],
      ),
      body: BlocBuilder<MessagesCubit, MessagesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            var filteredMessages = state.messages;
            //var filteredMessages = state.messages.where((message) => ((senderID == message.receiverId) && (receiverID == message.senderId)) || ((senderID == message.senderId) && (receiverID == message.receiverId))).toList();
            return Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView.builder(
                        reverse: true,
                        itemCount: filteredMessages.length,
                        itemBuilder: (context, index) {
                          var message = filteredMessages[index];
                          AlignmentGeometry alignment =
                              receiverID == message.senderId
                                  ? AlignmentDirectional.bottomStart
                                  : AlignmentDirectional.bottomEnd;

                          Color color = receiverID == message.senderId
                              ? const Color.fromRGBO(33, 87, 89, 1.0)
                              : const Color.fromRGBO(229, 249, 239, 1.0);

                          return Align(
                            alignment: alignment,
                            child: message.imageUrl != null
                                ? ImageRender(imageUrl: message.imageUrl!)
                                : MessageBubble(
                                    message: message,
                                    receiverId: receiverID,
                                    backgroundColor: color,
                                  ),
                          );
                        }),
                  ),
                ),
                MessageInputWidget(
                  senderId: senderID,
                  receiverId: receiverID,
                  tripId: tripID,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
