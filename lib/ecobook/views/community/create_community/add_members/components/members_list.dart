import 'package:flutter/material.dart';

class MemberList extends StatefulWidget {
  const MemberList({super.key});

  @override
  MemberListState createState() => MemberListState();
}


class MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
   return SliverList.builder(
       itemCount: 20,
       itemBuilder: (buildContext, index){
         // return const MemberWidget();
       });
  }

}