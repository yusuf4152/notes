import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/Yaziyazma.dart';
import 'package:notes/degistirmeekrani.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Notlarekrani(),
    );
  }
}

class Notlarekrani extends StatefulWidget {
  @override
  _NotlarekraniState createState() => _NotlarekraniState();
}

class _NotlarekraniState extends State<Notlarekrani> {
  String kartyazisi = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFC3C3),
        title: Text("notes created by yusuf"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff67DC8F),
        child: Text("oluştur"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Yaziyazma(),
          ));
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("yazilanveriler").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("henüz hiç veriniz yok"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("hatalı işlem"),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2), // kaç sütün olması gerektiğini söyledik
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              kartyazisi = snapshot.data.documents[index]["yazilanherveri"];
              return GestureDetector(
                onLongPress: () {
                  // uzun süre basılı tutması durumunda alert dialog gösterdim
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("silmek istediğinize emin misiniz"),
                        content: Text(
                            "sil'e tıklarsanız veriniz kalıcı olarak silinir"),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text("silme"),
                              )),
                          FlatButton(
                              onPressed: () {
                                kartyazisi = snapshot.data.documents[index]
                                    ["yazilanherveri"];
                                Firestore.instance
                                    .collection("yazilanveriler")
                                    .document(kartyazisi)
                                    .delete();
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text("sil"),
                              ))
                        ],
                      );
                    },
                  );
                },
                onTap: () {
                  kartyazisi = snapshot.data.documents[index]["yazilanherveri"];
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Degistirmeekrani(
                      oncekiveri: kartyazisi,
                    ),
                  ));
                },
                child: Card(
                  margin: EdgeInsets.all(20.0),
                  color: Color(0xffFFC3C3),
                  child: ListView(
                    children: [
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(kartyazisi)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
