import 'package:components_demo/state_notifier_demo/user_list_notifier.dart';
import 'package:components_demo/utils/default_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateNotiferDemoScreen extends ConsumerWidget {
  StateNotiferDemoScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<User> userList = ref.watch(usersProivder);
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "State Notifier Demo"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showUserAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(userList[index].name),
          subtitle: Text(userList[index].place ?? ""),
          trailing: IconButton(
              onPressed: () {
                ref.read(usersProivder.notifier).removeUser(userList[index].name);
              },
              icon: Icon(Icons.delete)),
        ),
      ),
    );
  }

  void showUserAddDialog(BuildContext context, WidgetRef ref) {
    nameController.clear();
    placeController.clear();

    showDialog(
      context: context,
      builder: (context) => Card(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(label: Text("Name")),
            ),
            TextField(
              controller: placeController,
              decoration: InputDecoration(label: Text("Place")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) return;
                      ref.read(usersProivder.notifier).addUser(User(
                          name: nameController.text,
                          place: placeController.text.isNotEmpty ? placeController.text : null));
                      Navigator.pop(context);
                    },
                    child: Text("Add"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
