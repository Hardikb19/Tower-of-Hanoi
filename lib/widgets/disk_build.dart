import 'package:flutter/material.dart';

import '../models/disk.dart';

class DiskBuild extends StatefulWidget {
  final Disk disk;

  DiskBuild(this.disk);

  @override
  createState() => _DiskBuildState();
}

class _DiskBuildState extends State<DiskBuild> {
  // static Disk disk0 = Disk(
  //   diskSize: 0,
  //   currentRodId: 0,
  // );
  // static Disk disk1 = Disk(
  //   diskSize: 1,
  //   currentRodId: 1,
  // );
  // static Disk disk3 = Disk(
  //   diskSize: 3,
  //   currentRodId: 1,
  // );
  // static Disk disk2 = Disk(
  //   diskSize: 2,
  //   currentRodId: 1,
  // );

  @override
  Widget build(BuildContext context) {
    int _currentRodId = widget.disk.currentRodId;
    double diskWidth;
    if (widget.disk.diskSize > 0) {
      diskWidth = widget.disk.diskSize * MediaQuery.of(context).size.height/12;
    } else {
      diskWidth = 0;
    }
    return widget.disk.draggable
        ? Draggable<Disk>(
            data: Disk(
              diskSize: widget.disk.diskSize,
              currentRodId: _currentRodId,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey[100],
                    Colors.blueGrey[200],
                    Colors.blueGrey[300],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                // color: Colors.deepOrange[300],
                height: diskWidth == 0 ? 0 : 20,
                width: diskWidth,
              ),
            ),
            feedback: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                color: Colors.blueGrey,
                height: diskWidth == 0 ? 0 : 20,
                width: diskWidth,
              ),
            ),
            childWhenDragging: Container(),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Container(
              decoration: BoxDecoration(
              color: Colors.blueGrey,
                 gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey[100],
                    Colors.blueGrey[200],
                    Colors.blueGrey[300],
                  ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              // color: Colors.deepOrange[300],
              height: diskWidth == 0 ? 0 : 20,
              width: diskWidth,
            ),
          );
  }
}
