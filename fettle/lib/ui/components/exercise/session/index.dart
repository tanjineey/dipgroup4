import 'package:flutter/material.dart';

//Agora stuff
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

// replace with your App ID from Agora.io
const APP_ID = "aae49542fb7e4c98b20b970b8c9ebe00";

class VideoRoom extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String groupId;

  /// Creates a call page with given channel name.
  const VideoRoom({Key key, this.groupId}) : super(key: key);

  @override
  VideoRoomState createState() {
    return new VideoRoomState();
  }
}

class VideoRoomState extends State<VideoRoom> {
  bool _joined = false;
  int _remoteUid;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    var engine = await RtcEngine.create(APP_ID);
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = null;
      });
    }));
    await engine.enableVideo();
    await engine.joinChannel(
        '006aae49542fb7e4c98b20b970b8c9ebe00IAAHZ5H2j9BV/CErLRNm+u+tqRl4yz/xTa9vuZH+Eb6hK+Osgc1PMNz+IgD6c1Q2ymF8XwQAAQBaHntfAgBaHntfAwBaHntfBABaHntf',
        'Zong Han',
        null,
        0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video Call Test'),
        ),
        body: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                        _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
