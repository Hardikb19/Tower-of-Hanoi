import 'package:flutter/material.dart';

class Disk {
  final int diskSize;
  final int currentRodId;
  bool draggable;

  int get disknumber => diskSize;

  Disk(
      {@required this.diskSize,
      @required this.currentRodId,
      this.draggable});

  @override
  String toString() {
    return this.diskSize.toString();
  }
}
