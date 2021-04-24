import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Yaziyazma extends StatefulWidget {
  @override
  _YaziyazmaState createState() => _YaziyazmaState();
}

class _YaziyazmaState extends State<Yaziyazma> {
  String yazilanveri = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFC3C3),
          title: Text("notes created by yusuf"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (yazilanveri.length >= 1) {
              Firestore.instance
                  .collection("yazilanveriler")
                  .document(yazilanveri)
                  .setData({"yazilanherveri": yazilanveri});
              Navigator.pop(context);
            }
          },
          backgroundColor: Color(0xff31AECA),
          child: Text(
            "ekle",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.0,
              decoration: BoxDecoration(
                  color: Color(0xffFFC3C3),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "verileriniz buraya giriniz",
                    border: InputBorder.none,
                  ),
                  onChanged: (gelenveri) {
                    setState(() {
                      if (gelenveri.length >= 1) {
                        yazilanveri = gelenveri;
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ));
  }
}
