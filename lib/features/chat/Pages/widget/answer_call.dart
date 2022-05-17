import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ripple_animation/ripple_animation.dart';

import '../../../../core/utils/apiUrls/env.dart';
import '../../../../core/utils/styles/color_utils.dart';
import '../../../Notification/firebase_notification/push_notification_manager.dart';
import '../../../authentication/viewModel/loginState.dart';
import '../../viewModel/chatViewModel.dart';

class AnswerCall extends StatefulWidget {
  final String? callerName;
  final String? channelName;
  final bool? initiatingCall;
  final String? receiverToken;
  const AnswerCall(
      {Key? key,
      this.callerName,
      this.channelName,
      this.initiatingCall,
      this.receiverToken})
      : super(key: key);

  @override
  _AnswerCallState createState() => _AnswerCallState();
}

class _AnswerCallState extends State<AnswerCall>
    with AfterLayoutMixin<AnswerCall> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayerEnd = AudioPlayer();
  AudioCache? audioCache;
  AudioCache? audioCache2;
  String path = "audio/calling.mp3";
  RtcEngine? _engine;
  ChatState? chatState;
  LoginState? loginState;
  bool repeatAnimation = true;
  String stopWatchDisplay = "00:00:00";
  bool speaker = false;
  Timer? _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  var swatch = Stopwatch();

  final dur = const Duration(seconds: 1);
  void startTimer() {
    _timer = Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      stopWatchDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });

//
  }

  void startWatch() {
    swatch.start();
    startTimer();
    // print("watch called");
  }

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioCache2 = AudioCache(fixedPlayer: audioPlayerEnd);
    if (widget.initiatingCall!) {
      //play sound only if the user is initiating the call before the other party joins
      playWaitingSound();
      initializeAgora();
    }
  }

  Future<void> initializeAgora() async {
    try {
      // Get microphone permission
      await [Permission.microphone].request();

      RtcEngineContext cont = RtcEngineContext(SystemProperties.agoraAppID);
      _engine = await RtcEngine.createWithContext(cont);

      _addAgoraEventHandlers();

      await chatState
          ?.getCallToken(
              channel: widget.channelName, token: loginState!.user.token!)
          .then(
            (value) => value.fold(
              (l) => print(l),
              (r) async {
                await _engine?.joinChannel(
                    r.token, widget.channelName!, null, loginState!.user.id!);
              },
            ),
          );
    } on Exception catch (e) {
      // print(e.toString() + " error starting agora");
    }
  }

  /// Add agora event handlers
  // void _addAgoraEventHandlers() {
  //   _engine?.setEventHandler(
  //     RtcEngineEventHandler(
  //       error: (code) {
  //         print(code);
  //       },
  //       joinChannelSuccess: (channel, uid, elapsed) async {
  //         if (widget.initiatingCall) {
  //           //notify the involved user
  //           var res = chatState.sendFCMNotification(
  //             senderName: loginState.user.fullName,
  //
  //             body: "Tap to answer the call",
  //             action: "call",
  //             title: "${loginState.user.fullName} is calling",
  //             channelName: widget.channelName,
  //           );
  //           print(widget.initiatingCall);
  //           print("resssssssssss$res");
  //         }
  //         pauseMusic();
  //       },
  //       leaveChannel: (stats) {},
  //       userJoined: (uid, elapsed) {
  //         if (uid != loginState.user.id) {
  //           //stop audio when another userjoins the channel so that the involved parties can hear each other
  //           // pauseMusic();
  //           //update the call status string
  //           callStatus = "Connnected";
  //           setState(() {});
  //         }
  //       },
  //       userOffline: (uid, elapsed) {
  //         endCall();
  //       },
  //     ),
  //   );
  // }

  void _addAgoraEventHandlers() {
    _engine?.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          print(code);
        },
        joinChannelSuccess: (channel, uid, elapsed) async {
          // print("joined successfully");
          if (widget.initiatingCall!) {
            //notify the other user
            var res = await chatState!.sendFCMNotification(
              senderName: loginState!.user.fullName!,
              body: "Tap to answer the call",
              action: "call",
              senderId: loginState!.user.id.toString(),
              myToken: PushNotificationsManager.deviceToken,
              receiverToken: widget.receiverToken!,
              title: "${loginState!.user.fullName} is calling",
              channelName: widget.channelName!,
            );
            // print(res.toString());
          } else {
            setState(() {
              callStatus = "Connected";
              startWatch();
            });
          }
          setState(() {
            repeatAnimation = false;
          });
        },
        leaveChannel: (stats) {},
        userJoined: (uid, elapsed) {
          if (uid != loginState!.user.id) {
            //stop audio when another user joins the channel so that the involved parties can hear each other
            if (widget.initiatingCall!) {
              pauseMusic();
            }

            setState(() {
              callStatus = "Connected";
            });
            startWatch();
          }
        },
        userOffline: (uid, elapsed) {
          endCall();
        },
      ),
    );
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    audioPlayer.release();
    audioPlayer.dispose();
    swatch.stop();
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    chatState = Provider.of<ChatState>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.callerName!,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    callStatus,
                    style: const TextStyle(fontSize: 20),
                  ),
                  callStatus == "Connected"
                      ? Text(
                          stopWatchDisplay,
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )
                      : const SizedBox()
                ],
              ),
              RippleAnimation(
                color: Colors.grey,
                repeat: repeatAnimation,
                child: const CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.black54,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: endCall,
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 25,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  (widget.initiatingCall!)
                      ? const SizedBox()
                      : SizedBox(
                          height: 50,
                          width: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                              // answer call
                              initializeAgora();

                              startWatch();
                            },
                            child: const Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 25,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        ),
                  callStatus == "Connected"
                      ? SizedBox(
                          height: 40,
                          width: 40,
                          child: FloatingActionButton(
                            onPressed: () async {
                              // answer call
                              speaker = !speaker;

                              await _engine!.setEnableSpeakerphone(speaker);
                              setState(() {});
                            },
                            child: Icon(
                              (!speaker)
                                  ? Icons.volume_up
                                  : Icons.speaker_phone,
                              color: Colors.grey,
                              size: 25,
                            ),
                            backgroundColor: Colors.white,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void endCall() async {
    _engine?.leaveChannel();
    await playEndCallSound();

    Navigator.pop(context);
  }

  void answerCall() {}
  playWaitingSound() async {
    // print("playing sound");
    await audioCache!.play(path);
  }

  Future<void> playEndCallSound() async {
    await audioPlayer.pause();
    await audioCache2!.play("audio/end_call.mp3");
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }

  String callStatus = "Connecting";
  @override
  void afterFirstLayout(BuildContext context) {
    // initializeAgora();
  }
}
