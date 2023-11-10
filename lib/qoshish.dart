import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial_uz/mahsulot.dart';
import 'package:hive_tutorial_uz/main.dart';

class QoshishPage extends StatefulWidget {
  final Box<Mahsulot> mahsulotBox;
  final int? index;

  const QoshishPage({super.key, required this.mahsulotBox, this.index});

  @override
  State<QoshishPage> createState() => _QoshishPageState();
}

class _QoshishPageState extends State<QoshishPage> {
  TextEditingController txtNomi = TextEditingController();
  TextEditingController txtNarxi = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      txtNarxi = TextEditingController(
          text: widget.mahsulotBox.getAt(widget.index!)?.narxi.toString());
      txtNomi = TextEditingController(
          text: widget.mahsulotBox.getAt(widget.index!)?.nomi.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mahsulot qoshish"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtNomi,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Mahsulot nomi"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtNarxi,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Mahsulot narxi"),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Mahsulot mahsulot =
                  Mahsulot(txtNomi.text, int.parse(txtNarxi.text));

              if (widget.index != null) {
                widget.mahsulotBox.putAt(widget.index!, mahsulot);
              } else {
                widget.mahsulotBox.add(mahsulot);
              }
              Navigator.pop(context);
            },
            child: Text(widget.index != null ? "O'zgartirish" : "Saqlash"),
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
