import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main()=>runApp(new MyApp());

  class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp> {

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: "Flutter 4 features",
        theme: ThemeData(
          platform:TargetPlatform.iOS,
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title:'Flutter Demo'),
      );
    }
  }

  class MyHomePage extends StatefulWidget {

    MyHomePage({Key key,this.title}):super(key:key);

    final String title;
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {

    File imageFile;
    File videoFile;


    _camera()async{
      File theImage=await ImagePicker.pickImage(source: ImageSource.camera);

      if(theImage!=null){
        setState(() {
          imageFile=theImage;
        });
      }
    }

    _picture()async{

      File theImage=await ImagePicker.pickImage(source: ImageSource.gallery);

      if(theImage!=null){
        setState(() {
          imageFile=theImage;
        });
      }
    }

      _videoPic()async{
      File theVid = await ImagePicker.pickVideo(source: ImageSource.gallery);

      if(theVid !=null){
        setState(() {
          videoFile = theVid;
          print("set");
        });
      }
      }


    _record()async{
      File theVid = await ImagePicker.pickVideo(source: ImageSource.camera);

      if(theVid !=null){
        setState(() {
          videoFile = theVid;
        });
      }
    }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
          title: Text(widget.title),
        ),
       body: Center(
         child: new ListView(
           children: <Widget>[
             Column(
               children: <Widget>[
                 SizedBox(
                   height: 50.0,
                   width: 100.0,
                 ),

              //video

               Container(
                 color: Colors.brown,
                 height: MediaQuery.of(context).size.height*(30/100),
                 width: MediaQuery.of(context).size.height*(100/100),
                  child:  videoFile == null?Center(
                    child: Icon(Icons.videocam,color: Colors.red,size: 50.0,),
                  ):FittedBox(//Center
                    fit: BoxFit.contain,
                  child: mounted?Chewie(
                    controller: ChewieController(
                   videoPlayerController: VideoPlayerController.file(videoFile),
                      aspectRatio: 3/2,
                      autoPlay: true,
                      looping: true,
                    ),
              ):Container(),
              ),
               ),

               Container(
                 color: Colors.brown,
                 height: MediaQuery.of(context).size.height*(30/100),
                 width: MediaQuery.of(context).size.height*(100/100),
                 child:FittedBox(
                   fit: BoxFit.contain,
                     child:  imageFile == null?Center(
                       child: Icon(Icons.photo,color:Colors.blueAccent),

                     ):Image.file(imageFile),
                 ),
                  ),



                 RaisedButton(
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text("Camera"),
                       Icon(Icons.camera),
                     ],
                   ),

                   onPressed: (){_camera();},
                 ),
                 RaisedButton(
                   onPressed: (){_picture();},
                   child: Row(

                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text("Picture"),
                       Icon(Icons.add_a_photo),
                     ],
                   ),
                 ),
                 RaisedButton(
                   onPressed: (){_videoPic();},
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text("Video"),
                       Icon(Icons.video_library),
                     ],
                   ),
                 ),
                 RaisedButton(
                   onPressed: (){_record();},
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text("Picture"),
                       Icon(Icons.videocam),
                     ],
                   ),
                 ),
               ],
             )
           ],
         ),
       ),
      );
    }
  }

