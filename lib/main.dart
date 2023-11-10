import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial_uz/mahsulot.dart';
import 'package:hive_tutorial_uz/qoshish.dart';

late Box<Mahsulot> mahsulotBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MahsulotAdapter());
  mahsulotBox = await Hive.openBox("mahsulot");
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mahsulotlar"),
      ),
      body: ListView.builder(
          itemCount: mahsulotBox.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.green[200],
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${mahsulotBox.getAt(index)?.nomi ?? "nomalum"}: ${mahsulotBox.getAt(index)?.narxi ?? "0"}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => QoshishPage(
                                        mahsulotBox: mahsulotBox,
                                        index: index,
                                      ))).then((value) {
                            setState(() {});
                          });
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            mahsulotBox.deleteAt(index);
                          });
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => QoshishPage(
                        mahsulotBox: mahsulotBox,
                      ))).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
