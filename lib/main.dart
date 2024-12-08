import 'package:flutter/material.dart';
import 'dart:async';
import 'sneakers_model.dart';
import 'sneakers_list.dart';
import 'new_sneakers_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hype Sneakers',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'Hype Sneakers',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var key = GlobalKey<ScaffoldState>();
  List<Sneakers> initialSneakers = [Sneakers('Reverse Mocha'), Sneakers('Forum BB'), Sneakers('AF1 MoMa')];

  Future _showNewSneakersForm() async {
    Sneakers newSneakers = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddSneakersFormPage();
    }));
    
    initialSneakers.add(newSneakers);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 128, 128),
      ),
      body: Center(
        child: SneakersList(initialSneakers),
      ),
      backgroundColor: const Color.fromARGB(255, 61, 92, 92),
      //Això es pot fer en l'icona de la AppBar
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 128, 128),
        tooltip: 'Add Sneaker',
        shape: const CircleBorder(),
        onPressed:_showNewSneakersForm,
        child: const Icon(
            Icons.add,
            color: Colors.white,
        ),
      ),
    );
  }
}
