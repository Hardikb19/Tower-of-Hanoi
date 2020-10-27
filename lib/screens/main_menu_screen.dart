import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../animations/pageTransition.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import './game_screen.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaineMenuScreenState();
  }
}

class _MaineMenuScreenState extends State<MainMenuScreen> {
  _getRow() {
    List<Widget> numbers = [];
    for (int i = 3; i < 8; i++) {
      numbers.add(GestureDetector(
        onTap: () {
          setState(() {
            numberOfDisks = i;
          });
        },
        child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            child: Text(i.toString(),
                style: TextStyle(
                    color: (i == numberOfDisks) ? Colors.white : Colors.black)),
            radius: 20,
            backgroundColor: (i == numberOfDisks) ? Colors.black : Colors.white,
          ),
        ),
      ));
    }
    return numbers;
  }

  int numberOfDisks = 3;
  bool selected = false;

  launchURL() async {
    const url = 'https://github.com/Hardikb19/Tower-of-Hanoi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close,color: Colors.black,),
          onPressed: (){
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(MdiIcons.github,color: Colors.black,),
            onPressed: () {
              launchURL();
            },
          )
        ],
      ),
      extendBody: true,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                  child: Text(
                'Tower of Hanoi',
                style: TextStyle(fontSize: 50, color: Colors.black87),
              )),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                child: Container(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          /* gradient: LinearGradient(
                                colors: [
                                  Colors.deepOrange[500],
                                  Colors.deepOrange[300],
                                  Colors.deepOrange[500]
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter) */
                        ),
                        width: 150,
                        height: 50,
                        // color: Colors.deepOrange[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              selected ? 'Start' : 'Play',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            if (!selected)
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black87,
                                size: 30.0,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  if (selected && numberOfDisks != null) {
                    /* setState(() {
                      GameScreen.rod1.disksList = widget.rod.disksList;
                      widget.rod.disksList = [];
                      main();
                    }); */
                    Navigator.of(context).push(slideRoute(
                        page: GameScreen(numberOfDisks),
                        beginOffset: Offset(0, 1),
                        endOffset: Offset.zero,
                        animateCurve: Curves.bounceInOut));
                  }
                  setState(() {
                    selected = !selected;
                  });
                },
              ),
            ),
            if (selected)
              Expanded(
                flex: 2,
                child: Container(
                    width: MediaQuery.of(context).size.height / 1.2,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _getRow())),
              )
          ],
        ),
      ),
    );
  }
}
