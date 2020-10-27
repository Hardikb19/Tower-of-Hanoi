import 'package:flutter/material.dart';
import '../main.dart';

import '../screens/game_screen.dart';
import '../models/rod.dart';
import '../models/disk.dart';
import '../widgets/disk_build.dart';

class RodBuild extends StatefulWidget {
  final Rod rod;
  final int numberOfDisks;

  RodBuild(this.rod, this.numberOfDisks);
  @override
  State<StatefulWidget> createState() {
    return _RodBuildState();
  }
}

class _RodBuildState extends State<RodBuild> {

  

  @override
  void reassemble(){
    super.reassemble();
  }

  Disk lastLeftDisk;

  @override
  void initState() {
    int numberOfDisks = widget.numberOfDisks;
    if (widget.rod == GameScreen.rod1) {
      int i;
      for (i = 0; i < numberOfDisks; i++) {
        widget.rod.disksList.add(
          Disk(
            diskSize: numberOfDisks - i,
            currentRodId: widget.rod.id,
            draggable: i == numberOfDisks - 1 ? true : false,
          ),
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Disk> listD = widget.rod.disksList;
    double rodHeight = 170;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return DragTarget<Disk>(
      onAccept: (acceptedDisk) {
        RodControl.rod2 = widget.rod;
        print('on accept rod : ${widget.rod.id}');
        if (listD.length > 0) {
          if (acceptedDisk.diskSize < listD.last.diskSize &&
              listD.length <= widget.numberOfDisks) {
            listD.last.draggable = false;
            listD.add(Disk(
              diskSize: acceptedDisk.diskSize,
              currentRodId: widget.rod.id,
            ));
            listD.last.draggable = true;
            GameScreen.lastLeftDisk = null;
          }else if(acceptedDisk.diskSize < listD.last.diskSize){
            setState(() {
              
              RodControl.rod1.disksList.add(acceptedDisk);
              main();
            });
          }
        } else {
          listD.add(Disk(
            diskSize: acceptedDisk.diskSize,
            currentRodId: widget.rod.id,
          ));
          listD.last.draggable = true;
          GameScreen.lastLeftDisk = null;
        }
        if (GameScreen.lastLeftDisk != null) {
          Rod rodToChange;
          rodToChange = GameScreen.rodList.firstWhere((rod) {
            return rod.id == GameScreen.lastLeftDisk.currentRodId;
          });
          if (rodToChange.disksList.length > 0) {
            rodToChange.disksList.last.draggable = false;
          }
          setState((){
            rodToChange.disksList.add(Disk(
              diskSize: GameScreen.lastLeftDisk.diskSize,
              currentRodId: rodToChange.id,
              ));
              
            rodToChange.disksList.last.draggable = true;
            
            GameScreen.lastLeftDisk = null;

            reassemble();
          });
          print('Rod${RodControl.rod1.id}:${RodControl.rod1.disksList}');
          print('Rod${RodControl.rod2.id}:${RodControl.rod2.disksList}');
          setState(() {
            main();
          });
        }
        print('length of the rod${widget.rod.id} is ${listD.length}');
        if (widget.rod.id == 3 && listD.length == widget.numberOfDisks) {
          showDialog(
            barrierDismissible: false,
              context: context,
              builder: (ctx) {
                return AlertDialog(

                  title: Text(
                    'You Won !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26.0, color: Colors.black),
                  ),
                  backgroundColor: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Replay',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          GameScreen.rod1.disksList = widget.rod.disksList;
                          widget.rod.disksList = [];
                          main();
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
        setState(() {
            main();
          });
      },
      onLeave: (leavingDisk) {
        RodControl.rod1 = widget.rod;
        var l1 = leavingDisk as Disk;
        if (listD.length > 0 &&
            l1.currentRodId == widget.rod.id &&
            GameScreen.lastLeftDisk == null) {
          GameScreen.lastLeftDisk = listD.removeLast();
          setState(() {
            GameScreen.numberOfMoves++;
          });
          if (listD.length > 0) listD.last.draggable = true;
        }
      },
      onWillAccept: (hoveringDisk) {
        return true;
      },
      builder: (BuildContext context, List<Disk> candidateData, rejectedData) {
        print(rejectedData);
        print(candidateData);
        return Container(
          height: MediaQuery.of(context).size.height,
          width: deviceWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      height: rodHeight,
                      width: 12,
                    ),
                  ),
                  for (int i = 0; i < listD.length; i++)
                    Positioned(
                      child: DiskBuild(listD[i]),
                      bottom: 20.0 * i,
                    ),
                  // ...disksList.map((disk) {
                  //   return Positioned(child: disk, bottom: 30 * ,);
                  // }),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 300,
              ),
            ],
          ),
        );
      },
    );
  }
}

class RodControl{
  static Rod rod1;
  static Rod rod2;
}
