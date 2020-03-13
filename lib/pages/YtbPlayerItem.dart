import 'package:flutter/material.dart';
import 'package:wap_i/models/YtbVid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtbPlayerItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play

  final YtbVid ytbVid;

  YtbPlayerItem({
    @required this.ytbVid,
    Key key,
  }) : super(key: key);

  @override
  _YtbPlayerItemState createState() => _YtbPlayerItemState();
}

class _YtbPlayerItemState extends State<YtbPlayerItem> {

     YoutubePlayerController _ytbController;

  @override
  void initState() {

     String videoId = YoutubePlayer.convertUrlToId(widget.ytbVid.link.toString());
    _ytbController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          forceHideAnnotation: false,
          enableCaption: true
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //return   Widget wapiYtPlayer(String url, String titre, String resume){
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(

                  child: YoutubePlayer(
                      controller:_ytbController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amber
                      ),
                      onReady:(){
                        print('player is ready');
                      }
                  ),

                ),
              ],
            ),
            Padding(

              padding: const EdgeInsets.all(10.0),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            widget.ytbVid.title.toString().toUpperCase(),
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Text(
                          widget.ytbVid.resume.toString(),
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    flex: 9,
                  ),
                  Expanded(
                    child: Icon(Icons.more_vert),
                    flex: 1,
                  ),
                ],
              ),

            ),
            Container(
              decoration: BoxDecoration(

                border: Border(
                  bottom: BorderSide(
                    color: Colors.black54,
                    width: 3.0,
                  ),
                ),
              ),
            ),

          ],
        ),
      );


  }

//
//  @override
//  void dispose() {
//    if (_ytbController != null) _ytbController.dispose();
////    widget.videoPlayerController.dispose();
////    _chewieController.dispose();
//    super.dispose();
//  }

}
