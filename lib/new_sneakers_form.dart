import 'package:sneakers/sneakers_model.dart';
import 'package:flutter/material.dart';


class AddSneakersFormPage extends StatefulWidget {
  const AddSneakersFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddSneakersFormPageState createState() => _AddSneakersFormPageState();
}

class _AddSneakersFormPageState extends State<AddSneakersFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the sneakers name'),
      ));
    } else {
      var newSneakers = Sneakers(nameController.text);
      Navigator.of(context).pop(newSneakers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new sneakers'),
        backgroundColor: Color.fromARGB(255, 0, 128, 128),
      ),
      body: Container(
        color: const Color.fromARGB(255, 61, 92, 92),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(decoration: TextDecoration.none),
                onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Sneakers Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => submitPup(context),
                    child: const Text('Add Sneakers'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
