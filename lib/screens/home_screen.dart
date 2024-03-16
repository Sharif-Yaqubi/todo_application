import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/provider/firebase_crud_provider.dart';
import 'package:todo_app/widget/new_task_widget.dart';

import '../widget/cart_todo_list_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchData);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            backgroundImage: const AssetImage('assets/user.jpg'),
          ),
          title: Text(
            'Hello I\'m',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: const Text(
            'Sharif Yaqubi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Task',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Wednesday,11 May',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      backgroundColor: const Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade800,
                    ),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      builder: (context) => const NewTaskWidget(),
                    ),
                    child: const Text('+ New Task'),
                  ),
                ],
              ),
              const Gap(20),
              ListView.builder(
                itemCount: todoData.value?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) => CardToDoListWidget(
                  getIndex: index,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
