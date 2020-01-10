import 'dart:convert';
import 'package:flutter/material.dart';

class PDMObject extends StatelessWidget{

  final String pbsNumber, name, frozen, itemType, buildType, qty, cadIssue, status, projectOwner, comment;

  const PDMObject({this.pbsNumber, this.name, this.frozen, this.itemType, this.buildType, this.qty, this.cadIssue, this.status, this.projectOwner, this.comment});


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: new Text("$name"),
      trailing: new Text("$pbsNumber"),
      children: <Widget>[
        new Text("FROZEN: $frozen"),
        new Text("ITEM TYPE: $itemType"),
        new Text("BUILD TYPE: $buildType"),
        new Text("QTY: $qty"),
        new Text("CAD ISSUE: $cadIssue"),
        new Text("STATUS: $status"),
        new Text("OWNER: $projectOwner"),
        new Text("COMMENT: $comment"),
      ],
    );
  }

}