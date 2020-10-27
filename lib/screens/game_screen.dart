import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/rod_build.dart';
import '../models/rod.dart';
import '../models/disk.dart';
import '../data.dart';
class GameScreen extends StatefulWidget {
  static List<Disk> list1 = [];
  static List<Disk> list2 = [];
  static List<Disk> list3 = [];
  static Rod rod1 = Rod(id: 1, disksList: list1);
  static Rod rod2 = Rod(id: 2, disksList: list2);
  static Rod rod3 = Rod(id: 3, disksList: list3);
  static int level = 1;

  static String organism;

  static int numberOfMoves = 0;

  static List<Rod> rodList = [rod1, rod2, rod3];

  static Disk lastLeftDisk;

  int numberOfDisks;

  GameScreen(this.numberOfDisks){
    list1 = [];
    list2 = [];
    list3 = [];
    rod1 = Rod(id: 1, disksList: list1);
    rod2 = Rod(id: 2, disksList: list2);
    rod3 = Rod(id: 3, disksList: list3);
    numberOfMoves = 0;
    rodList = [rod1, rod2, rod3];
  }

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  List<String> inserts = [];

  String name = '';
  String level = GameScreen.level.toString();
  Color color = Colors.black.withOpacity(0.2);

  onSwitch(int number){
    setState(() {
      inserts.insert(0, data[GameScreen.organism]['lvl${GameScreen.level}']['discs'][number-1]);
      print(inserts[0]);
    });
  }

  onFinish(){
    setState(() {
      inserts.clear();
      color = Colors.green;
      name = 'Please Restart level $level';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close),color: Colors.black87,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.refresh_bold,color: Colors.black87,),
              onPressed: (){
                setState(() {
                  name = '';
                  GameScreen.rod1.disksList = [];
                  for (int i = 0; i < widget.numberOfDisks; i++) {
                    GameScreen.rod1.disksList.add(
                      Disk(
                        diskSize: widget.numberOfDisks - i,
                        currentRodId: GameScreen.rod1.id,
                        draggable: i == widget.numberOfDisks - 1 ? true : false,
                      ),
                    );
                  }
                  GameScreen.rod2.disksList = [];
                  GameScreen.rod3.disksList = [];
                });
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            IgnorePointer(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1200),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: List.generate(data[GameScreen.organism]['lvl${GameScreen.level}']['discs'].length, (index){
                        String org = '';
                        try{
                          org = inserts[index];
                          
                        }catch(e){
                          org = '';
                        }
                        return Text(org, style: TextStyle(fontSize: (50 -5.0*index), color: color));
                      }
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height - 300,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  RodBuild(GameScreen.rod1, widget.numberOfDisks, onSwitch, onFinish),
                  RodBuild(GameScreen.rod2, widget.numberOfDisks, onSwitch, onFinish),
                  RodBuild(GameScreen.rod3, widget.numberOfDisks, onSwitch, onFinish),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
