// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Item {
  final int id;
  final String name;
  final String group;
  Item({required this.id, required this.name, required this.group});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter List',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [
    Item(id: 1, name: 'Khusein', group: 'SE-2218'),
    Item(id: 2, name: 'Iliias', group: 'SE-2218'),
    Item(id: 3, name: 'Anelya', group: 'SE-2218'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Shamil`s friends:'),
        backgroundColor: const Color.fromARGB(255, 255, 110, 110),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text(items[index].group),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  items.remove(items[index]);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddItemModal(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController groupController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: groupController,
              decoration: const InputDecoration(labelText: 'Group'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int id = int.tryParse(idController.text) ?? 0;
                String name = nameController.text;
                String group = groupController.text;

                setState(() {
                  items.add(Item(id: id, name: name, group: group));
                });

                Navigator.pop(context);
              },
              child: const Text('Add new friend'),
            ),
          ],
        );
      },
    );
  }
}
