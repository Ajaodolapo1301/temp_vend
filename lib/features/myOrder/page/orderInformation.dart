import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/styles/fontSize.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../chat/Pages/widget/agora_message.dart';
import '../../chat/model/chatModel.dart';
import '../../chat/viewModel/chatViewModel.dart';
import '../model/myOrderModel.dart';
import '../widget/orderInfoWidget.dart';

class OrderInformation extends StatefulWidget {
  final MyOrderModel? orderModel;
  final bool? completed;
  const OrderInformation({Key? key, this.orderModel, this.completed})
      : super(key: key);

  @override
  _OrderInformationState createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  Map<String, List> stage = {};
  LoginState? loginState;
  ChatState? chatState;

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    chatState = Provider.of<ChatState>(context);

    return LoadingOverlayWidget(
      loading: chatState?.busy,
      child: Scaffold(
        // floatingActionButton:
        // widget.orderModel.riderInfo == null || widget.completed
        //     ? SizedBox()
        //     : BoomMenu(
        //   animatedIcon: AnimatedIcons.menu_close,
        //   animatedIconTheme: IconThemeData(size: 22.0),
        //   //child: Icon(Icons.add),
        //   onOpen: () => print('OPENING DIAL'),
        //   onClose: () => print('DIAL CLOSED'),
        //   // scrollVisible: scrollVisible,
        //   overlayColor: Colors.black,
        //   overlayOpacity: 0.7,
        //   children: [
        //     MenuItem(
        //       child: Icon(Icons.call, color: Colors.white),
        //       title: "In App call",
        //       titleColor: Colors.white,
        //       subtitle: "You Can Your rider about your order",
        //       subTitleColor: Colors.white,
        //       backgroundColor: Colors.deepOrange,
        //       onTap: () {
        //         // String channelName = loginState.user.id
        //         //     .toString() +
        //         //     widget.orderModel.riderInfo.id.toString() +
        //         //     "mm";
        //             String channelName = widget.orderModel.riderInfo.id.toString() +
        //                 loginState.user.id.toString() + "mm";
        //
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) =>
        //                 AnswerCall(
        //                     receiverToken: widget.orderModel.riderInfo.fcmToken,
        //                     callerName: widget.orderModel.riderInfo.fullName,
        //                     channelName: channelName,
        //                     initiatingCall: true),
        //           ),
        //         );
        //       },
        //     ),
        //     MenuItem(
        //       child: Icon(Icons.chat, color: Colors.white),
        //       title: "Chat",
        //       titleColor: Colors.white,
        //       subtitle: "You can chat with the rider",
        //       subTitleColor: Colors.white,
        //       backgroundColor: Colors.green,
        //       onTap: () {
        //         String channel = widget.orderModel.riderInfo.id.toString() +
        //             loginState.user.id.toString();
        //         getmessageToken(channel);
        //         // getAgoraToken(channel);
        //       },
        //     ),
        //     MenuItem(
        //       child: Icon(Icons.phone_android, color: Colors.white),
        //       title: "Phone call",
        //       titleColor: Colors.white,
        //       subtitle: "You Can call Your rider on a normal call",
        //       subTitleColor: Colors.white,
        //       backgroundColor: Colors.blue,
        //       onTap: () async {
        //         pushTo(context, RateRider(orderModel: widget.orderModel,));
        //       },
        //     ),
        //
        //   ],
        // ),

        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Platform.isIOS
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              onPressed: () => pop(context)),
          backgroundColor: Colors.white,
          actions: [
            // IconButton(onPressed: (){
            //    showRequestType(context);
            //  }, icon:    Icon(Icons.call, color: Colors.black,),),
            //  widget.orderModel.riderInfo == null || widget.completed ? SizedBox() :           IconButton(onPressed: null, icon:  Icon(Icons.message, color: Colors.black,))
          ],
          centerTitle: true,
          title: Text(
            "Order information",
            style: kBold700.copyWith(
                color: Colors.black, fontSize: 2.2 * SizeConfig.textMultiplier),
          ),
        ),
        // kAppBar("Order information",
        //     onPress: () => pop(context), showAction: false, showLead: true,  ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: thirty_two,
                ),
                InkWell(
                    onTap: () {
                      toast("Copied to Clipboard");
                      Clipboard.setData(ClipboardData(
                          text: widget.orderModel!.trackingId ?? ""));
                    },
                    child: Text(
                      "Tracking ID: ${widget.orderModel!.trackingId}",
                      style: kBold700.copyWith(
                          fontSize: fourteen, color: const Color(0xff979797)),
                    )),

                SizedBox(
                  height: sixteen,
                ),

                widget.orderModel!.riderInfo == null || widget.completed!
                    ? const SizedBox()
                    : getRiderUI(widget.orderModel!, loginState, context, () {
                        String channel =
                            widget.orderModel!.riderInfo!.id.toString() +
                                loginState!.user.id.toString();
                        getmessageToken(channel);
                      }),

                orderInfoWidget(widget.orderModel!,
                    boldText:
                        "Amount Paid : ${widget.orderModel!.payment!.price}",
                    text: "Payment with ${widget.orderModel!.payment!.method}",
                    subtext: "Delivered on 11:15am  24th July 2021",
                    type: "Delivery Info"),

                SizedBox(
                  height: sixteen,
                ),
                orderInfoWidget(widget.orderModel!,
                    boldText: widget.orderModel!.senderInfo!.senderName!,
                    text: widget.orderModel!.senderInfo!.pickupAddress!,
                    subtext: widget.orderModel!.senderInfo!.senderPhoneNumber!,
                    type: "Sender’s Info"),

                SizedBox(
                  height: sixteen,
                ),
                orderInfoWidget(widget.orderModel!,
                    boldText: widget.orderModel!.receiverInfo!.receiverName!,
                    text: widget.orderModel!.receiverInfo!.destinationAddress!,
                    subtext:
                        widget.orderModel!.receiverInfo!.receiverPhoneNumber!,
                    type: "Receiver Info"),

                SizedBox(
                  height: sixteen,
                ),
                orderInfoWidget(widget.orderModel!,
                    boldText:
                        "${widget.orderModel!.deliveryType!.name} Delivery",
                    text: widget.orderModel!.itemDescription!,
                    subtext: widget.orderModel!.deliveryTime!.name!,
                    type: "Package Info"),

                // orderInfoWidget(
                //     widget.orderModel,
                //     boldText:"${widget.orderModel.deliveryType.name} Delivery",
                //     text: widget.orderModel.itemDescription,
                //     subtext:widget.orderModel.deliveryTime.name,
                //     type: "Package Info"
                // ),

                SizedBox(
                  height: sixteen,
                ),
                // widget.completed || widget.orderModel.riderInfo == null ? SizedBox() :     CustomButton(text: "Chat With Rider", type: ButtonType.outlined,
                //      onPressed: (){
                //        String channel = loginState.user.id.toString() + widget.orderModel.riderInfo.id.toString();
                //
                //              getAgoraToken(channel);
                //      },
                //      ),
                SizedBox(
                  height: sixteen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // showRequestType(context){
  //   showDialog(context: context, builder: (context){
  //     TextStyle s = TextStyle(fontSize: 1.8 * SizeConfig.textMultiplier ,fontWeight: FontWeight.w800, color: Colors.grey[800]);
  //     return AlertDialog(
  //       contentPadding: const EdgeInsets.symmetric(vertical: 5),
  //       content: SizedBox(
  //         height: 12.3 * SizeConfig.heightMultiplier,
  //         child: Column(
  //           children: <Widget>[
  //
  //             Expanded(
  //               child: ListTile(
  //                 title:Text("In-App call", style: s,),
  //                 onTap: ()async{
  //                   Navigator.of(context,rootNavigator: true).pop();
  //
  //                   String channelName = loginState.user.id
  //                       .toString() +
  //                       widget.orderModel.riderInfo.id.toString()+
  //                       "mm";
  //
  //                   Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                       builder: (context) => AnswerCall(
  //                           callerName: widget.orderModel.senderInfo.senderName,
  //                           channelName: channelName,
  //                           initiatingCall: true),
  //                     ),
  //                   );
  //
  //                 },
  //               ),
  //             ),
  //             Divider(
  //               height: 1,
  //             ),
  //             Expanded(
  //               child: ListTile(
  //                 title: Text("Phone call", style: s,),
  //                 onTap: ()async{
  //                   Navigator.of(context,rootNavigator: true).pop();
  //
  //
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

  void getAgoraToken(channel) async {
    var res = await chatState!
        .getCallToken(channel: channel, token: loginState!.user.token);
    res.fold(
        (l) => kShowSnackBar(
            context, l.props.first.toString() ?? "An Error occurred"), (r) {
      int id = Random().nextInt(1232020);
      Chat? chat = Chat(
          chatId: id,
          messages: [],
          riderId: widget.orderModel!.riderInfo!.id.toString(),
          channelName: channel,
          riderName: widget.orderModel!.riderInfo!.fullName ?? "");
      chatState!.addChat(chat);
      pushTo(
          context,
          AgoraMessage(
            receiverFcmToken: widget.orderModel!.riderInfo!.fcmToken,
            channelName: chat.channelName,
            token: chat.token,
            chatId: chat.chatId,
            userName: chat.riderName,
            userId: chat.riderId,
            myId: loginState!.user.id.toString(),
          ));
    });
  }

  void getmessageToken(channel) async {
    var res = await chatState!
        .getMessageToken(channel: channel, token: loginState!.user.token);
    res.fold(
        (l) => kShowSnackBar(
            context, l.props.first.toString() ?? "An Error occured"), (r) {
      int id = Random().nextInt(1232020);
      Chat chat = Chat(
          chatId: id,
          messages: [],
          riderId: widget.orderModel!.riderInfo!.id.toString() ?? "",
          channelName: channel,
          receiverFcmToken: widget.orderModel!.riderInfo!.fcmToken,
          riderName: widget.orderModel!.riderInfo!.fullName ?? "");
      chatState!.addChat(chat);
      pushTo(
          context,
          AgoraMessage(
            channelName: chat.channelName,
            token: chat.token,
            chatId: chat.chatId,
            userName: chat.riderName,
            receiverFcmToken: chat.receiverFcmToken,
            userId: chat.riderId,
            myId: loginState!.user.id.toString(),
          ));
    });
  }
}
