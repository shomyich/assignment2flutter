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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            onTap: () {
              _navigateToUpdateScreen(context, items[index]);
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, items[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToUpdateScreen(BuildContext context, Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UpdateItemScreen(item: item, updateItemList: updateItemList),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: Text('Are you sure you want to delete ${item.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  items.remove(item);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController groupController = TextEditingController();
    TextEditingController idController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: groupController,
                decoration: const InputDecoration(labelText: 'Group'),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'Id'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // Add item to the list
                int id = items.length + 1;
                String name = nameController.text;
                String group = groupController.text;

                setState(() {
                  items.add(Item(id: id, name: name, group: group));
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateItemList(Item newItem) {
    setState(() {
      int index = items.indexWhere((item) => item.id == newItem.id);
      if (index != -1) {
        items[index] = newItem;
      }
    });
  }
}

class UpdateItemScreen extends StatelessWidget {
  final Item item;
  final Function(Item) updateItemList;

  const UpdateItemScreen(
      {super.key, required this.item, required this.updateItemList});

  @override
  Widget build(BuildContext context) {
    TextEditingController idController =
        TextEditingController(text: item.id.toString());
    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController groupController =
        TextEditingController(text: item.group);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                int id = int.tryParse(idController.text) ?? item.id;
                String name = nameController.text;
                String group = groupController.text;
                Item updatedItem = Item(id: id, name: name, group: group);
                updateItemList(updatedItem);
                Navigator.pop(context);
              },
              child: const Text('Update Item'),
            ),
          ],
        ),
      ),
    );
  }
}
