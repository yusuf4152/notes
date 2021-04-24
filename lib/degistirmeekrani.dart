import 'package:flutter/material.dart';

class Degistirmeekrani extends StatefulWidget {
  final String oncekiveri;

  const Degistirmeekrani({Key key, this.oncekiveri}) : super(key: key);

  @override
  _DegistirmeekraniState createState() => _DegistirmeekraniState();
}

class _DegistirmeekraniState extends State<Degistirmeekrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("notes created by yusuf"),
        backgroundColor: Color(0xffFFC3C3),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              alignment: Alignment.topCenter,
              width: 400.0,
              height: 400.0,
              decoration: BoxDecoration(
                color: Color(0xffFFC3C3),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, left: 10.0, top: 10.0),
                    child: Text(widget.oncekiveri),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
