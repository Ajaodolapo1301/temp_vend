import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/features/chat/Pages/widget/agora_message.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../authentication/viewModel/loginState.dart';
import '../model/chatModel.dart';
import '../viewModel/chatViewModel.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with AfterLayoutMixin<Messages> {
  ChatState? chatState;
  LoginState? loginState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ChatsProvider().getChats(widget.data.token!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    chatState = Provider.of<ChatState>(context);
    loginState = Provider.of<LoginState>(context);
    return Scaffold(
      // appBar: kAppBar("Chat", showLead: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .05),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(
                height: 3,
              ),
              const Divider(),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  builder:
                      (BuildContext context, List<Chat>? value, Widget? child) {
                    // print(value);
                    if (value!.isEmpty) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("${imagePath}wallet/chat.png"),
                                  SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier,
                                  ),
                                  Text(
                                    "No active Chats",
                                    style: kBold700.copyWith(
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AgoraMessage(
                                  chatId: value[index].chatId,
                                  receiverFcmToken:
                                      value[index].receiverFcmToken,
                                  channelName: value[index].channelName,
                                  userName: value[index].riderName,
                                  token: value[index].token,
                                  userId: value[index].riderId,
                                  myId: loginState!.user.id.toString(),
                                ),
                              ),
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.withOpacity(0.2),
                            radius: 20,
                            child: Text(
                              value[index].riderName![0].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          title: Text(
                            value[index].riderName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          subtitle: const Text("Tap to chat"),
                        );
                      },
                    );
                  },
                  valueListenable: chatState!.chatsNotifier,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onSubmitted: (value) {
          chatState!.filterChats(value);
        },
        cursorColor: const Color(0XF757575),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.white,
          labelText: "Search",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: complementary,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: complementary,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(width: 1.5, color: complementary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: complementary, width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    chatState!.getChats();
  }
}
